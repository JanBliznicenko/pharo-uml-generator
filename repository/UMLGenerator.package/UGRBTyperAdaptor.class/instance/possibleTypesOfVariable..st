api
possibleTypesOfVariable: aUGVariable
	| typer |
	typer := self typerOf: aUGVariable containingClass.
	^ UGTypePossibilities
		for: aUGVariable
		types: (self typesFromTyper: typer ofVariableName: aUGVariable variableName)
		collectionTypes: (self typesFromTyper: typer ofVariableName: '-' , aUGVariable variableName , '-')