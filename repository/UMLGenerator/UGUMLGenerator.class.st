Class {
	#name : #UGUMLGenerator,
	#superclass : #Object,
	#instVars : [
		'focusedPackages',
		'model',
		'umlClasses',
		'encompassingPackage',
		'includeAccessors',
		'typesManager',
		'doType',
		'rootClasses'
	],
	#classInstVars : [
		'classOrdering',
		'classUniqueness'
	],
	#category : #'UMLGenerator-Generator'
}

{ #category : #'public - importer' }
UGUMLGenerator class >> importFromClasses: aCollection [
	^ self new importFromClasses: aCollection
]

{ #category : #'public - importer' }
UGUMLGenerator class >> importFromPackageNamed: aString [
	^ self new importFromPackagesNamed: {aString}
]

{ #category : #'public - importer' }
UGUMLGenerator class >> importFromPackagesNamed: aCollectionOfStrings [
	^ self new importFromPackagesNamed: aCollectionOfStrings
]

{ #category : #testing }
UGUMLGenerator class >> isOrderedCollectionClass: collectionRealClass [
	classOrdering
		ifNil: [ classOrdering := ({(Bag -> false).
			(DependentsArray -> true).
			(DoubleLinkedList -> true).
			(FLLargeIdentityHashedCollection -> false).
			(HashedCollection -> false).
			(Heap -> false).
			(OrderedDictionary -> true).
			(RelationSet -> false).
			(SequenceableCollection -> true).
			(SmallDictionary -> false).
			(StandardOrderedDictionary -> true).
			(WeakRegistry -> false).
			(WideCharacterSet -> false)}
				flatCollect: [ :eachPair | eachPair key withAllSubclasses collect: [ :each | each -> eachPair value ] ]) asDictionary ].
	^ classOrdering
		at: collectionRealClass
		ifAbsent: [ nil ]
]

{ #category : #testing }
UGUMLGenerator class >> isUniqueCollectionClass: collectionRealClass [
	classUniqueness
		ifNil: [ classUniqueness := ({(Bag -> false).
			(DependentsArray -> false).
			(DoubleLinkedList -> false).
			(FLLargeIdentityHashedCollection -> false).
			(Dictionary -> false).
			(Set -> true).
			(Heap -> false).
			(OrderedDictionary -> false).
			(RelationSet -> true).
			(Interval -> true).
			(SmallDictionary -> false).
			(StandardOrderedDictionary -> false).
			(WeakRegistry -> false).
			(WideCharacterSet -> true)}
				,
					((SequenceableCollection subclasses copyWithout: Interval)
						collect: [ :each | each -> false ])
				flatCollect:
					[ :eachPair | eachPair key withAllSubclasses collect: [ :each | each -> eachPair value ] ])
				asDictionary ].
	^ classUniqueness at: collectionRealClass ifAbsent: [ nil ]
]

{ #category : #adding }
UGUMLGenerator >> addAsAssociationVariable: aVariable to: umlClass [
	| umlClassProperty umlAssociationProperty typeUGClass upperBound umlAssociation |
	umlClassProperty := OPUMLProperty new.
	umlAssociationProperty := OPUMLProperty new.
	umlAssociation := OPUMLAssociation new.
	typeUGClass := self typeOf: aVariable.
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlClassProperty.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlClassProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		association: umlAssociation;
		type: (umlClasses at: typeUGClass realClass).
	umlAssociationProperty
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		owningAssociation: umlAssociation;
		association: umlAssociation;
		type: umlClass.
	umlAssociation
		name: umlClass name asString , '_' , aVariable variableName.
	umlAssociation memberEnds
		add: umlClassProperty;
		add: umlAssociationProperty.
	umlAssociation navigableOwnedEnds add: umlAssociationProperty.
	umlClass ownedAttributes add: umlClassProperty.
	(self umlPackageOfUmlClass: umlClass) packagedElements
		add: umlAssociation
]

{ #category : #adding }
UGUMLGenerator >> addAsPropertyVariable: aVariable to: umlClass [
	| umlProperty typeUGClass upperBound |
	umlProperty := OPUMLProperty new.
	typeUGClass := self typeOf: aVariable.
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlProperty.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		type:
			(typeUGClass
				ifNil: [ umlClasses at: Object ]
				ifNotNil: [ umlClasses at: typeUGClass realClass ]).
	umlClass ownedAttributes add: umlProperty
]

{ #category : #adding }
UGUMLGenerator >> addClass: aClass [
	| umlPackage umlClass |
	umlClasses
		at: aClass
		ifPresent: [ :existingUmlClass | ^ umlClasses at: aClass ].
	aClass isTrait
		ifTrue: [ ^ self ].
	aClass isMeta
		ifTrue: [ ^ self addClass: Class ].
	self flag: #todo.	"traits are ignored"
	umlPackage := self umlPackageOf: aClass.
	umlClass := self umlClassFrom: aClass.
	umlPackage packagedElements add: umlClass.
	umlClasses at: aClass put: umlClass.
	(focusedPackages includes: aClass package)
		ifFalse: [ ^ umlClass ].
	self addSuperclassOf: aClass.
	(aClass class methods isNotEmpty
		or: [ aClass class instVarNames isNotEmpty ])
		ifTrue: [ self addClass: aClass class ].
	self addVariablesOf: aClass.
	self addMethodsOf: aClass.
	^ umlClass
]

{ #category : #adding }
UGUMLGenerator >> addClasses: aClassesCollection [
	focusedPackages
		ifEmpty: [ focusedPackages := aClassesCollection
				collect: [ :each | each package ]
				as: Set ].
	aClassesCollection do: [ :each | self addClass: each ].
	self addGeneralizations
]

{ #category : #adding }
UGUMLGenerator >> addCollectionSpecificsOf: collectionRealClass to: umlElement [
	(self class isOrderedCollectionClass: collectionRealClass)
		ifNotNil: [ :isOrdered | umlElement isOrdered: isOrdered ].
	(self class isUniqueCollectionClass: collectionRealClass)
		ifNotNil: [ :isUnique | umlElement isUnique: isUnique ].
	^ umlElement
]

{ #category : #adding }
UGUMLGenerator >> addGeneralizationSetTo: aSuperclass [
	| set subclasses |
	subclasses := aSuperclass subclasses
		select: [ :eachSubclass | umlClasses includesKey: eachSubclass ].
	subclasses ifEmpty: [ ^ self ].
	set := OPUMLGeneralizationSet new
		name: 'Subclasses of ' , aSuperclass name;
		isDisjoint: true;
		generalizations:
			(subclasses
				collect: [ :eachSubclass | 
					OPUMLGeneralization new
						general: (umlClasses at: aSuperclass);
						specific: (umlClasses at: eachSubclass);
						yourself ]).
	encompassingPackage packagedElements add: set
]

{ #category : #adding }
UGUMLGenerator >> addGeneralizations [
	umlClasses keysDo: [ :each | self addGeneralizationSetTo: each ]
]

{ #category : #adding }
UGUMLGenerator >> addGeneralizationsTo: aSuperclass toSet: aGeneralizationSet [
	aSuperclass subclasses
		select: [ :eachSubclass | umlClasses includesKey: eachSubclass ]
		thenDo: [ :eachSubclass | 
			aGeneralizationSet generalizations
				add:
					(OPUMLGeneralization new
						general: (umlClasses at: aSuperclass);
						specific: (umlClasses at: eachSubclass);
						yourself) ]
]

{ #category : #adding }
UGUMLGenerator >> addMethod: aMethod to: umlClass [
	| umlMethod |
	(self shouldOmitAccessor: aMethod)
		ifTrue: [ ^ self ].
	umlMethod := self umlMethodFrom: aMethod.
	self addVisibilityOf: aMethod to: umlMethod.
	self addParametersOf: aMethod to: umlMethod.
	umlClass ownedOperations add: umlMethod
]

{ #category : #adding }
UGUMLGenerator >> addMethodsOf: realClass [
	self addMethodsOf: realClass to: (umlClasses at: realClass)
]

{ #category : #adding }
UGUMLGenerator >> addMethodsOf: realClass to: umlClass [
	realClass methods,	realClass class methods
		do: [ :eachMethod | self addMethod: eachMethod to: umlClass ].
	((self rootClasses includes: realClass superclass)
		or: [ umlClasses includesKey: realClass superclass ])
		ifFalse: [ self addMethodsOf: realClass superclass to: umlClass ]
]

{ #category : #adding }
UGUMLGenerator >> addParameter: anUgParameter to: umlMethod [
	| typeUGClass upperBound umlParameter |
	typeUGClass := self typeOf: anUgParameter.
	umlParameter := anUgParameter isOut
		ifTrue: [ self newReturnParameter ]
		ifFalse: [ OPUMLParameter new direction: OPUMLParameterDirectionKind in ].
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlParameter.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlParameter
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		name: anUgParameter itemName;
		type:
			(typeUGClass
				ifNil: [ umlClasses at: Object ]
				ifNotNil: [ umlClasses at: typeUGClass realClass ]).
	umlMethod ownedParameters add: umlParameter
]

{ #category : #adding }
UGUMLGenerator >> addParametersOf: aMethod to: umlMethod [
	| ugMethod |
	ugMethod := UGMethod named: umlMethod name in: aMethod methodClass.
	aMethod argumentNames
		do: [ :each | 
			self
				addParameter: (UGInputMethodParameter named: each in: ugMethod)
				to: umlMethod ].
	self addParameter: (UGReturnParameter in: ugMethod) to: umlMethod
]

{ #category : #adding }
UGUMLGenerator >> addSuperclassOf: aClass [
	| superClass |
	superClass := aClass superclass.
	(self rootClasses includes: superClass)
		ifTrue: [ ^ self ].
	^ umlClasses at: superClass ifAbsent: [ self addClass: superClass ]
]

{ #category : #adding }
UGUMLGenerator >> addVariable: aVariable to: umlClass [

	(doType and: [
		 | typeClass |
		 typeClass := self typeOf: aVariable.
		 typeClass isNotNil and: [
			 focusedPackages includes: typeClass package ] ]) ifTrue: [
		^ self addAsAssociationVariable: aVariable to: umlClass ].
	^ self addAsPropertyVariable: aVariable to: umlClass
]

{ #category : #adding }
UGUMLGenerator >> addVariablesOf: realClass [
	self addVariablesOf: realClass to: (umlClasses at: realClass)
]

{ #category : #adding }
UGUMLGenerator >> addVariablesOf: realClass to: umlClass [
	realClass instVarNames
		do: [ :eachVariable | 
			self
				addVariable: (UGVariable named: eachVariable in: realClass)
				to: umlClass ].
	realClass classVarNames , realClass class instVarNames
		do: [ :eachVariable | 
			self
				addVariable: (UGVariable named: eachVariable in: realClass) shared
				to: umlClass ].
	((self rootClasses includes: realClass superclass)
		or: [ umlClasses includesKey: realClass superclass ])
		ifFalse: [ self addVariablesOf: realClass superclass to: umlClass ]
]

{ #category : #private }
UGUMLGenerator >> addVisibilityOf: aMethod to: umlMethod [
	| protocol |
	protocol := aMethod protocol.
	umlMethod
		visibility:
			(((protocol beginsWith: 'private')
				or: [ (protocol endsWith: 'private')
						or: [ (protocol beginsWith: 'protected') or: [ protocol endsWith: 'protected' ] ] ])
				ifTrue: [ OPUMLVisibilityKind protected ]
				ifFalse: [ OPUMLVisibilityKind public ])
]

{ #category : #'public - importer' }
UGUMLGenerator >> importFromClasses: aClassesCollection [
	self addClass: Object.
	self addClasses: aClassesCollection.
	^ model
]

{ #category : #'public - importer' }
UGUMLGenerator >> importFromPackagesNamed: aCollectionOfStrings [
	| packages |
	packages := aCollectionOfStrings collect: #asPackage as: Set.
	focusedPackages := packages asSet.
	self importFromClasses: (packages flatCollect: #classes).
	^ model
]

{ #category : #initialization }
UGUMLGenerator >> initialize [
	super initialize.
	includeAccessors := true.
	umlClasses := Dictionary new.
	model := OPUMLModel new.
	model name: 'Generated UML'.
	encompassingPackage := model.
	typesManager := UGTypesManager default.
	doType := true.
	focusedPackages := Set new.
]

{ #category : #profiling }
UGUMLGenerator >> measuredTime [

	^ typesManager measuredTime
]

{ #category : #adding }
UGUMLGenerator >> newReturnParameter [
	^ OPUMLParameter new direction: OPUMLParameterDirectionKind return
]

{ #category : #accessing }
UGUMLGenerator >> omitAccessors [
	includeAccessors := false
]

{ #category : #private }
UGUMLGenerator >> rootClasses [
	^ rootClasses
		ifNil: [ rootClasses := {Object.
			ProtoObject.
			ClassDescription.
			Class.
			Metaclass} asSet.
			rootClasses
				addAll: (rootClasses collect: #class);
				yourself ]
]

{ #category : #accessing }
UGUMLGenerator >> saveXmlTo: aFileName [

	aFileName asFileReference
		ensureDelete;
		writeStreamDo: [ :s |
			OPXMIWriter write: (self umlXmiWriter new write: model) toStream: s ]
]

{ #category : #private }
UGUMLGenerator >> shouldOmitAccessor: aMethod [
	| protocol varNames selector |
	includeAccessors
		ifTrue: [ ^ false ].
	protocol := aMethod protocol.
	((protocol beginsWith: 'access') or: [ protocol endsWith: 'accessing' ])
		ifFalse: [ ^ false ].
	varNames := aMethod methodClass allInstVarNames asSet, aMethod methodClass allClassVarNames asSet.
	selector := aMethod selector.
	selector last = $:
		ifTrue: [ selector := selector allButLast ].
	^ varNames includes: selector
]

{ #category : #profiling }
UGUMLGenerator >> startTimeMeasuring [

	typesManager startTimeMeasuring
]

{ #category : #adding }
UGUMLGenerator >> typeOf: anItem [
	| ugClass |
	doType
		ifFalse: [ ^ nil ].
	ugClass := typesManager typeOf: anItem.
	ugClass
		ifNil: [ doType := false.
			^ nil ].
	ugClass realClass isMeta
		ifTrue: [ ^ ugClass copy
				realClass: Class;
				yourself ].
	^ ugClass
]

{ #category : #accessing }
UGUMLGenerator >> typesManager: aManager [
	typesManager := aManager
]

{ #category : #adding }
UGUMLGenerator >> umlClassFrom: aClass [
	^ OPUMLClass new
		name: aClass name;
		visibility: OPUMLVisibilityKind public;
		yourself
]

{ #category : #adding }
UGUMLGenerator >> umlMethodFrom: aMethod [
	^ OPUMLOperation new
		name: aMethod selector;
		isStatic: aMethod methodClass isMeta;
		yourself
]

{ #category : #private }
UGUMLGenerator >> umlPackageOf: aClass [
	^ encompassingPackage
]

{ #category : #private }
UGUMLGenerator >> umlPackageOfUmlClass: aUmlClass [
	^ encompassingPackage
]

{ #category : #hooks }
UGUMLGenerator >> umlXmiWriter [
	^ OPUMLXMIWriter
]
