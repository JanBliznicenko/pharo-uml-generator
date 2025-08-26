Class {
	#name : 'UGTyperChainingCombinator',
	#superclass : 'UGTyperAdaptorCommonSuperclassCombinator',
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'private' }
UGTyperChainingCombinator >> canImmediatelyAnswer: typePossibilities [

	^ typePossibilities isFullyKnown
]

{ #category : 'private' }
UGTyperChainingCombinator >> combine: collectionOfTypePossibilities [

	^ collectionOfTypePossibilities
		  detect: [ :any | any isFullyKnown ]
		  ifNone: [
			  collectionOfTypePossibilities
				  detect: [ :any | any isFullyUnknown not ]
				  ifNone: [ collectionOfTypePossibilities first ] ]
]
