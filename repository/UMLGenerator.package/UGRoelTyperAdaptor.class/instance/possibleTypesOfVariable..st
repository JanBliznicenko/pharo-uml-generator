api
possibleTypesOfVariable: aUGVariable
	aUGVariable isShared
		ifTrue: [ ^ UGTypePossibilities
				for: aUGVariable
				types: Set new
				collectionTypes: Set new ].
	^ UGTypePossibilities
		for: aUGVariable
		types:
			(TypeCollector
				typeInstvar: aUGVariable variableName asSymbol
				ofClassWithLookup: aUGVariable containingClass) types asSet
		collectionTypes: Set new