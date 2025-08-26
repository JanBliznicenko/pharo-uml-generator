Class {
	#name : 'UGRBTyperAdaptor',
	#superclass : 'UGTyperAdaptor',
	#instVars : [
		'typers'
	],
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'accessing' }
UGRBTyperAdaptor class >> invalidClassNames [
	^ Set
		with: #GHObjectGhost
		with: #Mock
		with: #GHClassGhost
		with: #GHObjectGhostStub
]

{ #category : 'accessing' }
UGRBTyperAdaptor class >> invalidClasses [
	^ self invalidClassNames
		select: [ :each | Smalltalk globals includesKey: each ]
		thenCollect: [ :each | Smalltalk globals at: each ]
]

{ #category : 'accessing' }
UGRBTyperAdaptor class >> replacements [
	^ {(ProtoObject -> Object)} asDictionary
]

{ #category : 'private' }
UGRBTyperAdaptor >> filterTypes: aCollectionOfClasses [
	| invalidClasses replacements |
	invalidClasses := self class invalidClasses.
	replacements := self class replacements.
	^ aCollectionOfClasses
		reject: [ :each | invalidClasses includes: each ]
		thenCollect: [ :each | replacements at: each ifAbsent: [ each ] ]
]

{ #category : 'initialization' }
UGRBTyperAdaptor >> initialize [
	super initialize.
	typers := IdentityDictionary new
]

{ #category : 'testing' }
UGRBTyperAdaptor >> isCollectionTyper [
	^ true
]

{ #category : 'testing' }
UGRBTyperAdaptor >> isVarTyper [
	^ true
]

{ #category : 'api' }
UGRBTyperAdaptor >> possibleTypesOfInputParameter: aUGParameter [

	^ UGTypePossibilities emptyFor: aUGParameter
]

{ #category : 'api' }
UGRBTyperAdaptor >> possibleTypesOfReturnParameter: aUGParameter [

	^ UGTypePossibilities emptyFor: aUGParameter
]

{ #category : 'api' }
UGRBTyperAdaptor >> possibleTypesOfVariable: aUGVariable [

	| typer types collectionElementTypes |
	typer := self typerOf: aUGVariable containingClass.
	types := self filterTypes:
		         ((typer guessTypesFor: aUGVariable variableName)
			          collect: #realClass
			          as: Set).
	collectionElementTypes := self filterTypes:
		                          ((typer guessTypesFor:
			                            '-' , aUGVariable variableName , '-')
			                           collect: #realClass
			                           as: Set).
	^ UGTypePossibilities
		  for: aUGVariable
		  types: types
		  collectionElementTypes: collectionElementTypes
]

{ #category : 'private' }
UGRBTyperAdaptor >> typerOf: aClass [
	^ typers at: aClass ifAbsentPut: [ RBRefactoryTyper new runOn: aClass ]
]
