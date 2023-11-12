Class {
	#name : #UGRBTyperAdaptor,
	#superclass : #UGTyperAdaptor,
	#instVars : [
		'typers'
	],
	#category : 'UMLGenerator-Typer'
}

{ #category : #'as yet unclassified' }
UGRBTyperAdaptor >> collectionTypesFromTyper: aTyper ofVariable: aUGVariable [
	| possibleCollectionTypes possibleElementTypes collectionType |
	possibleCollectionTypes := self
		filterTypes:
			((aTyper guessTypesFor: aUGVariable variableName)
				collect: #realClass
				thenSelect: [ :each | each includesBehavior: Collection ]).
	possibleCollectionTypes ifEmpty: [ ^ Dictionary new ].
	possibleElementTypes := self
		filterTypes:
			((aTyper guessTypesFor: '-' , aUGVariable variableName , '-')
				collect: #realClass).
	collectionType := self commonSuperclassOf: possibleCollectionTypes.
	possibleElementTypes
		ifEmpty: [ ^ {(Object -> collectionType)} asDictionary ].
	^ (possibleElementTypes collect: [ :each | each -> collectionType ])
		asDictionary
]

{ #category : #private }
UGRBTyperAdaptor >> commonSuperclassOf: classes [
	| currentSuperclasses bestCommonIndex commonHierarchy classesArray |
	classes ifEmpty: [ ^ Object ].
	classes size = 1
		ifTrue: [ ^ classes anyOne ].
	classesArray := classes asArray.
	commonHierarchy := classesArray copyWithoutFirst
		inject: classesArray first withAllSuperclasses reversed
		into: [ :lastHierarchy :realClass | 
			currentSuperclasses := realClass withAllSuperclasses reversed.
			lastHierarchy first == currentSuperclasses first
				ifFalse: [ ^ Object ].
			bestCommonIndex := 1.
			1 to: (lastHierarchy size min: currentSuperclasses size) do: [ :i | 
				(lastHierarchy at: i) == (currentSuperclasses at: i)
					ifTrue: [ bestCommonIndex := i ] ].
			lastHierarchy first: bestCommonIndex ].
	^ commonHierarchy last
]

{ #category : #private }
UGRBTyperAdaptor >> createRawCollectionTypeDictionaryFrom: aTypeDictionary [
	^ (aTypeDictionary keys
		collect: [ :variable | 
			variable
				->
					(self
						possibleTypesOfVariable: (UGVariable named: '-' , variable variableName , '-' in: variable containingClass)) ])
		asDictionary
]

{ #category : #initialization }
UGRBTyperAdaptor >> initialize [
	super initialize.
	typers := IdentityDictionary new
]

{ #category : #testing }
UGRBTyperAdaptor >> isCollectionTyper [
	^ true
]

{ #category : #testing }
UGRBTyperAdaptor >> isVarTyper [
	^ true
]

{ #category : #api }
UGRBTyperAdaptor >> possibleTypesOfVariable: aUGVariable [
	| typer |
	typer := self typerOf: aUGVariable containingClass.
	^ UGTypePossibilities
		for: aUGVariable
		types: (self simpleTypesFromTyper: typer ofVariable: aUGVariable)
		collectionTypes: (self collectionTypesFromTyper: typer ofVariable: aUGVariable)
]

{ #category : #'as yet unclassified' }
UGRBTyperAdaptor >> simpleTypesFromTyper: aTyper ofVariable: aUGVariable [
	^ self
		filterTypes:
			((aTyper guessTypesFor: aUGVariable variableName)
				collect: #realClass
				thenReject: [ :each | each includesBehavior: Collection ]) asSet
]

{ #category : #private }
UGRBTyperAdaptor >> typerOf: aClass [
	^ typers at: aClass ifAbsentPut: [ RBRefactoryTyper new runOn: aClass ]
]
