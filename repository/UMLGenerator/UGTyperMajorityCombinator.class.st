Class {
	#name : 'UGTyperMajorityCombinator',
	#superclass : 'UGTyperAdaptorCommonSuperclassCombinator',
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'private' }
UGTyperMajorityCombinator >> canImmediatelyAnswer: typePossibilities [

	^ false
]

{ #category : 'private' }
UGTyperMajorityCombinator >> combine: collectionOfTypePossibilities [

	| types collectionElementTypes |
	types := collectionOfTypePossibilities
		         flatCollect: [ :each | each possibleTypes ]
		         as: Bag.
	types removeKey: Object ifAbsent: [  ].
	collectionElementTypes := collectionOfTypePossibilities
		                          flatCollect: [ :each |
		                          each possibleCollectionElementTypes ]
		                          as: Bag.
	collectionElementTypes removeKey: Object ifAbsent: [  ].
	^ UGTypePossibilities
		  for: collectionOfTypePossibilities anyOne item
		  types: { (types sortedCounts
				   ifEmpty: [ Object ]
				   ifNotEmpty: [ :sortedCounts | sortedCounts first value ]) }
		  collectionElementTypes: { (collectionElementTypes sortedCounts
				   ifEmpty: [ Object ]
				   ifNotEmpty: [ :sortedCounts | sortedCounts first value ]) }
]
