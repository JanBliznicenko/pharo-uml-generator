as yet unclassified
typesOfVariable: aUEVariable
	^ ((self typerOf: aUEVariable containingClass) guessTypesFor: aUEVariable variableName)
		collect: #realClass