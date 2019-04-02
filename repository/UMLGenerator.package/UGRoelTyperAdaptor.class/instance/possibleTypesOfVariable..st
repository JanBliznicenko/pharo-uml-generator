api
possibleTypesOfVariable: aUGVariable
	aUGVariable isShared
		ifTrue: [ ^ UGTypePossibilities
				for: aUGVariable
				types: Set new
				collectionTypes: Dictionary new ].
	^ UGTypePossibilities
		for: aUGVariable
		types:
			(TypeCollector
				typeInstvar: aUGVariable variableName asSymbol
				ofClassWithLookup: aUGVariable containingClass) types asSet
		collectionTypes: Dictionary new