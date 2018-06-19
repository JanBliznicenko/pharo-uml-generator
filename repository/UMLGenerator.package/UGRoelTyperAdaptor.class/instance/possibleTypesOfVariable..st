api
possibleTypesOfVariable: aUEVariable
	aUEVariable isShared
		ifTrue: [ ^ UGTypePossibilities
				for: aUEVariable
				types: Set new
				collectionTypes: Set new ].
	^ UGTypePossibilities
		for: aUEVariable
		types:
			(TypeCollector
				typeInstvar: aUEVariable variableName asSymbol
				ofClassWithLookup: aUEVariable containingClass) types asSet
		collectionTypes: Set new