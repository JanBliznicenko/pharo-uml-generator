Class {
	#name : #UGAutoTypesManagerFinalizer,
	#superclass : #UGTypesManagerFinalizer,
	#category : 'UMLGenerator-TypeManager'
}

{ #category : #retrieving }
UGAutoTypesManagerFinalizer >> commonSuperclassOf: classes [
	| currentSuperclasses bestCommonIndex commonHierarchy classesArray |
	classesArray := classes asArray reject: #isNil.
	classesArray ifEmpty: [ ^ Object ].
	classesArray size = 1
		ifTrue: [ ^ classesArray anyOne ].
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

{ #category : #retrieving }
UGAutoTypesManagerFinalizer >> typeFor: typePossibilities [
	| possibleTypes possibleCollectionTypes |
	possibleTypes := typePossibilities possibleTypes.
	possibleCollectionTypes := typePossibilities possibleCollectionTypes.
	(possibleCollectionTypes anySatisfy: [ :any | any realClass ~= Object ])
		ifTrue: [ ^ UGCollection
				type: (self commonSuperclassOf: possibleCollectionTypes values)
				with: (self commonSuperclassOf: possibleCollectionTypes keys) ].
	possibleTypes ifEmpty: [ ^ UGClass for: Object ].
	^ UGClass for: (self commonSuperclassOf: possibleTypes)
]
