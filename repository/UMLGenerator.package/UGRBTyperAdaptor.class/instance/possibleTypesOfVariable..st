api
possibleTypesOfVariable: aUEVariable
	| typer |
	typer := self typerOf: aUEVariable containingClass.
	^ UGTypePossibilities
		for: aUEVariable
		types: (self typesFromTyper: typer ofVariableName: aUEVariable variableName)
		collectionTypes: (self typesFromTyper: typer ofVariableName: '-' , aUEVariable variableName , '-')