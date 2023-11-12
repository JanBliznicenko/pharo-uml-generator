Class {
	#name : #UGTyperBackupsCombinator,
	#superclass : #UGTyperAdaptorCombinator,
	#category : 'UMLGenerator-Typer'
}

{ #category : #api }
UGTyperBackupsCombinator >> possibleTypesFromBlock: aBlock [
	| possiblePartialTypes |
	adaptors ifEmpty: [ self error: 'no TyperAdaptor available' ].
	possiblePartialTypes := UGTypePossibilities new.
	adaptors
		do: [ :each | 
			| possibleTypes |
			possibleTypes := aBlock value: each.
			possibleTypes isNotFullyKnown
				ifFalse: [ ^ possibleTypes ].
			possiblePartialTypes isUnknown
				ifTrue: [ possiblePartialTypes := possibleTypes ] ].
	^ possiblePartialTypes
]
