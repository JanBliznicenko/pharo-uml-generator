retrieving
typeFor: typePossibilities
	| possibleTypes possibleCollectionTypes |
	possibleTypes := typePossibilities possibleTypes.
	possibleCollectionTypes := typePossibilities possibleCollectionTypes.
	(possibleCollectionTypes anySatisfy: [ :any | any realClass ~= Object ])
		ifTrue: [ ^ UGCollection
				type: (self commonSuperclassOf: possibleCollectionTypes values)
				with: (self commonSuperclassOf: possibleCollectionTypes keys) ].
	possibleTypes ifEmpty: [ ^ UGClass for: Object ].
	^ UGClass for: (self commonSuperclassOf: possibleTypes)