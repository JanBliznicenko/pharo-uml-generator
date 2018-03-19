as yet unclassified
typesOfVariable: aUEVariable
	^ (TypeCollector
		typeInstvar: aUEVariable variableName
		ofClassWithLookup: aUEVariable containingClass) types