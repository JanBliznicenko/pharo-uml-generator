api
possibleTypesOfVariable: aUEVariable
	^ UGTypePossibilities
		for: aUEVariable
		types:
			(TypeCollector
				typeInstvar: aUEVariable variableName asSymbol
				ofClassWithLookup: aUEVariable containingClass) types asSet
		collectionTypes: {}