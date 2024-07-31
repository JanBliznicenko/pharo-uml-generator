Class {
	#name : #UGTyperUnionCombinator,
	#superclass : #UGTyperAdaptorCombinator,
	#category : #'UMLGenerator-Typer'
}

{ #category : #private }
UGTyperUnionCombinator >> canImmediatelyAnswer: possibleTypes [

	^ false
]

{ #category : #private }
UGTyperUnionCombinator >> combine: collectionOfTypePossibilities [

	^ collectionOfTypePossibilities
		  inject: (UGTypePossibilities emptyFor:
				   collectionOfTypePossibilities anyOne item)
		  into: [ :combination :each | combination , each ]
]
