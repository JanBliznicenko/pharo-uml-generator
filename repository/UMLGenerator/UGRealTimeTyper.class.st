Class {
	#name : #UGRealTimeTyper,
	#superclass : #Object,
	#instVars : [
		'typePossibilitiesDictionary',
		'returnLinkBlock',
		'assignmentLinkBlock',
		'argumentsLinkBlock',
		'returnSelfLinkBlock',
		'links',
		'atomicCollectionTypes',
		'linkedPackages'
	],
	#classInstVars : [
		'default'
	],
	#category : 'UMLGenerator-Typer'
}

{ #category : #accessing }
UGRealTimeTyper class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #example }
UGRealTimeTyper class >> exampleCode [
	| generator model typesManager typerAdaptor typesFinalizer |
	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.
	
	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	'Zinc-HTTP' asPackage classes do: #recompile.
	
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.
	
	"this is the time to run tests/scenarios to log types"
	self notify: 'This is time to run tests/scenarios to log types for realtime type inferer.', String cr, 'Run the tests/scenarios and then click Proceed'.
	
	"save types into following file"
	typesManager := UGTypesManager withFile: 'default.typeinfo-all-backups.ston'.
	"use following typer(s)"
	typerAdaptor := UGTyperBackupsCombinator
		withAdaptors:
			{UGRealTimeTyperAdaptor new.
			UGRoelTyperAdaptor new.
			UGRBTyperAdaptor new}.
	"setup types manager"			
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	"use finalizer for getting final types from all the ones found by typers"
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.
	"use the proper generator for the target tool (each one requires little differences in the model)"
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: typesFinalizer.
	
	"generate model for the following packages"
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	"save the xmi model into following file"
	generator saveXmlTo: 'Zinc-HTTP-EA.xmi'.
	
	^ model
]

{ #category : #singleton }
UGRealTimeTyper class >> resetDefault [
	default := nil.
]

{ #category : #adding }
UGRealTimeTyper >> add: aClass asPossibleTypeOf: aUGItem [
	(self possibleTypesOf: aUGItem) addPossibleType: aClass
]

{ #category : #adding }
UGRealTimeTyper >> addLinksToPackageNamed: aPackageName [
	| package definedClasses |
	package := aPackageName asPackage.
	(linkedPackages includes: package)
		ifTrue: [ ^ self ].
	definedClasses := package definedClasses.
	definedClasses , (definedClasses collect: #class)
		do: [ :eachClass | 
			eachClass methods
				do: [ :eachMethod | 
					eachMethod ast link: (links add: (argumentsLinkBlock value: eachMethod)).
					eachMethod ast assignmentNodes
						select: [ :eachNode | eachNode variable isInstance ]
						thenDo: [ :eachNode | eachNode link: (links add: (assignmentLinkBlock value: eachClass)) ].
					eachMethod ast allChildren
						select: [ :eachNode | eachNode isReturn ]
						thenDo:
							[ :eachNode | eachNode link: (links add: (returnLinkBlock value: eachMethod selector value: eachClass)) ].
					eachMethod ast lastIsReturn
						ifFalse: [ eachMethod ast
								link: (links add: (returnSelfLinkBlock value: eachMethod selector value: eachClass)) ] ] ]
]

{ #category : #adding }
UGRealTimeTyper >> addTypeOf: aValue asPossibleTypeOf: aUGItem [
	| possibleTypes |
	possibleTypes := self possibleTypesOf: aUGItem.
	(self shouldTypeAsCollection: aValue)
		ifFalse: [ ^ possibleTypes addPossibleType: aValue class ].
	aValue
		do: [ :each | possibleTypes addPossibleCollectionType: aValue class with: each class ]
]

{ #category : #initialization }
UGRealTimeTyper >> createArgumentsLinkBlock [
	argumentsLinkBlock := [ :method | 
	| class methodName argumentNames |
	class := method methodClass.
	methodName := method selector.
	argumentNames := method argumentNames.
	MetaLink new
		metaObject: [ :arguments | 
			arguments
				ifNotEmpty: [ arguments
						withIndexDo: [ :each :index | 
							self
								addTypeOf: each
								asPossibleTypeOf:
									(UGInputMethodParameter
										named: (argumentNames at: index)
										in: (UGMethod named: methodName in: class)) ] ] ];
		selector: #value:;
		arguments: #(arguments);
		control: #before ]
]

{ #category : #initialization }
UGRealTimeTyper >> createAssignmentLinkBlock [
	assignmentLinkBlock := [ :class | 
	MetaLink new
		metaObject: [ :node :value | 
			self
				addTypeOf: value
				asPossibleTypeOf: (UGVariable named: node variable name asString in: class) ];
		selector: #value:value:;
		arguments: #(node value);
		control: #after ]
]

{ #category : #initialization }
UGRealTimeTyper >> createReturnLinkBlock [
	returnLinkBlock := [ :methodName :class | 
	MetaLink new
		metaObject: [ :value | 
			self
				addTypeOf: value
				asPossibleTypeOf: (UGReturnParameter in: (UGMethod named: methodName in: class)) ];
		selector: #value:;
		arguments: #(value);
		control: #before ]
]

{ #category : #initialization }
UGRealTimeTyper >> createReturnSelfLinkBlock [
	returnSelfLinkBlock := [ :methodName :class | 
	MetaLink new
		metaObject: [ self
				add: class
				asPossibleTypeOf: (UGReturnParameter in: (UGMethod named: methodName in: class)) ];
		control: #after ]
]

{ #category : #initialization }
UGRealTimeTyper >> initialize [
	super initialize.
	typePossibilitiesDictionary := Dictionary new.
	links := OrderedCollection new.
	linkedPackages := Set new.
	self
		createAssignmentLinkBlock;
		createArgumentsLinkBlock;
		createReturnLinkBlock;
		createReturnSelfLinkBlock
]

{ #category : #pages }
UGRealTimeTyper >> links [
	^ links
]

{ #category : #api }
UGRealTimeTyper >> possibleTypesOf: aUGItem [
	^ typePossibilitiesDictionary at: aUGItem ifAbsentPut: [ UGTypePossibilities for: aUGItem ]
]

{ #category : #adding }
UGRealTimeTyper >> shouldTypeAsCollection: aValue [
	^ UGTypePossibilities shouldTypeAsCollection: aValue class
]

{ #category : #api }
UGRealTimeTyper >> uninstallLinks [
	self links do: #uninstall.
	links := OrderedCollection new.
	linkedPackages := Set new.
]
