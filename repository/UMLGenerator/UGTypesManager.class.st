Class {
	#name : #UGTypesManager,
	#superclass : #Object,
	#instVars : [
		'methodTyper',
		'varTyper',
		'blockForVariable',
		'knownTypes',
		'persistence',
		'autoSave',
		'blockForParameter',
		'plannedSave',
		'skipMethods'
	],
	#classInstVars : [
		'default'
	],
	#category : #'UMLGenerator-TypeManager'
}

{ #category : #'instance creation' }
UGTypesManager class >> default [
	^ default
		ifNil: [ default := (self withFile: 'default.typeinfo.ston')
				autoSave;
				yourself ]
]

{ #category : #example }
UGTypesManager class >> example [
	^ UGEnterpriseArchitectUMLGenerator new
		typesManager: self new;
		importFromPackagesNamed: #('Zinc-HTTP')
]

{ #category : #constants }
UGTypesManager class >> methodTypers [
	^ {}
]

{ #category : #constants }
UGTypesManager class >> newDefaultTyper [
	^ UGTyperUnionCombinator
		withAdaptors:
			{UGRBTyperAdaptor new.
			UGRoelTyperAdaptor new}
]

{ #category : #singleton }
UGTypesManager class >> resetDefault [

	<script>
	default := nil
]

{ #category : #'instance creation' }
UGTypesManager class >> withFile: aFileName [
	^ self new
		loadFromFile: aFileName;
		yourself
]

{ #category : #adding }
UGTypesManager >> addType: aTypeOfItem of: anItem [
	aTypeOfItem ifNil: [ ^ aTypeOfItem ].
	knownTypes at: anItem put: aTypeOfItem.
	self planSave.
	^ aTypeOfItem
]

{ #category : #retrieving }
UGTypesManager >> addTypeOfParameter: aParameter from: possibleTypes [

	skipMethods ifTrue: [ ^ UGClass for: Object ].
	^ self
		  addType: (blockForParameter value: possibleTypes)
		  of: aParameter
]

{ #category : #retrieving }
UGTypesManager >> askTypeOfInputParameter: aParameter [

	^ self
		  addTypeOfParameter: aParameter
		  from: (methodTyper possibleTypesOfInputParameter: aParameter)
]

{ #category : #retrieving }
UGTypesManager >> askTypeOfReturnParameter: aParameter [

	^ self
		  addTypeOfParameter: aParameter
		  from: (methodTyper possibleTypesOfReturnParameter: aParameter)
]

{ #category : #retrieving }
UGTypesManager >> askTypeOfVariable: aVariable [
	^ self
		addType: (blockForVariable value: (varTyper possibleTypesOfVariable: aVariable))
		of: aVariable
]

{ #category : #persistence }
UGTypesManager >> autoSave [
	autoSave := true.
]

{ #category : #accessing }
UGTypesManager >> blockForParameter: aBlock [
	blockForParameter := aBlock
]

{ #category : #accessing }
UGTypesManager >> blockForVariable: aBlock [
	blockForVariable := aBlock
]

{ #category : #initialization }
UGTypesManager >> defaultBlockForParameter [
	^ blockForParameter := [ :typeRequest | 
	UIManager default
		request: 'Type of parameter ' , typeRequest item asString
		initialAnswer: 'Object' ]
]

{ #category : #initialization }
UGTypesManager >> defaultBlockForVariable [
	^ blockForVariable := [ :typeRequest | 
	UIManager default
		request: 'Type of variable ' , typeRequest item asString
		initialAnswer: 'Object' ]
]

{ #category : #initialization }
UGTypesManager >> initialize [
	super initialize.
	knownTypes := Dictionary new.
	persistence := UGTypesNoPersistence new.
	skipMethods := false.
	self typerAdaptor: self class newDefaultTyper.
	autoSave := false.
	plannedSave := false.
	self defaultBlockForVariable.
	self defaultBlockForParameter
]

{ #category : #persistence }
UGTypesManager >> knownTypes [
	^ knownTypes
]

{ #category : #persistence }
UGTypesManager >> loadFromFile: aFileName [
	persistence := UGTypesFilePersistence fileName: aFileName.
	knownTypes := persistence loadTypes
]

{ #category : #accessing }
UGTypesManager >> methodTyper [
	^ methodTyper
]

{ #category : #accessing }
UGTypesManager >> methodTyper: aTyperAdaptor [
	methodTyper := aTyperAdaptor
]

{ #category : #persistence }
UGTypesManager >> planSave [
	autoSave
		ifFalse: [ ^ self ].
	plannedSave
		ifTrue: [ ^ self ].
	plannedSave := true.
	[ 5 seconds wait.
	plannedSave := false.
	self save ] fork
]

{ #category : #persistence }
UGTypesManager >> reload [
	^ persistence loadTypes
]

{ #category : #persistence }
UGTypesManager >> save [
	persistence saveTypes: knownTypes
]

{ #category : #persistence }
UGTypesManager >> skipMethods [
	skipMethods := true
]

{ #category : #retrieving }
UGTypesManager >> typeOf: anItem [

	^ knownTypes at: anItem ifAbsent: [ anItem acceptVisitor: self ]
]

{ #category : #accessing }
UGTypesManager >> typerAdaptor: aTyperAdaptor [
	self varTyper: aTyperAdaptor.
	self methodTyper: aTyperAdaptor
]

{ #category : #accessing }
UGTypesManager >> varTyper [
	^ varTyper
]

{ #category : #accessing }
UGTypesManager >> varTyper: aTyperAdaptor [
	varTyper := aTyperAdaptor
]

{ #category : #visiting }
UGTypesManager >> visitClass: aParameter [

	self error: 'Unable to get type of class'
]

{ #category : #visiting }
UGTypesManager >> visitCollectionClass: aParameter [

	self error: 'Unable to get type of class'
]

{ #category : #visiting }
UGTypesManager >> visitInputMethodParameter: aParameter [
	^ self askTypeOfInputParameter: aParameter
]

{ #category : #visiting }
UGTypesManager >> visitMethod: aMethod [
	^ self error: 'Method itself has no type (return parameter does)'
]

{ #category : #visiting }
UGTypesManager >> visitReturnParameter: aParameter [
	^ self askTypeOfReturnParameter: aParameter
]

{ #category : #visiting }
UGTypesManager >> visitVariable: aVariable [
	^ self askTypeOfVariable: aVariable
]
