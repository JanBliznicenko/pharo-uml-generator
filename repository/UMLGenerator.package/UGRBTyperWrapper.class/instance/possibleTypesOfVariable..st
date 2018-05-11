private
possibleTypesOfVariable: aUEVariable
	^ (((self typerOf: aUEVariable containingClass) guessTypesFor: aUEVariable variableName)
		collect: #realClass) asSet asArray