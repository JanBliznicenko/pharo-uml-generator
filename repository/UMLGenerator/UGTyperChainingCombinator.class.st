Class {
	#name : #UGTyperChainingCombinator,
	#superclass : #UGTyperAdaptorCommonSuperclassCombinator,
	#category : #'UMLGenerator-Typer'
}

{ #category : #private }
UGTyperChainingCombinator >> canImmediatelyAnswer: typePossibilities [

	| mainType collectionElementType |
	mainType := typePossibilities possibleTypes anyOne.
	mainType == Object ifTrue: [ ^ false ].
	(UGTypePossibilities shouldTypeAsCollection: mainType) ifFalse: [
		^ true ].
	collectionElementType := typePossibilities
		                         possibleCollectionElementTypes anyOne.
	^ collectionElementType ~= Object
]

{ #category : #private }
UGTyperChainingCombinator >> combine: collectionOfTypePossibilities [

	^ collectionOfTypePossibilities
		  detect: [ :any | any includesObjectType not ]
		  ifNone: [ ^ collectionOfTypePossibilities first ]
]
