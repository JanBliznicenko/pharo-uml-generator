private
possibleTypesOfVariable: aUEVariable
	^ (TypeCollector
		typeInstvar: aUEVariable variableName
		ofClassWithLookup: aUEVariable containingClass) types