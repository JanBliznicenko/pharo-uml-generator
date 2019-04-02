api
possibleTypesOfVariable: aUGVariable
	| typer |
	typer := self typerOf: aUGVariable containingClass.
	^ UGTypePossibilities
		for: aUGVariable
		types: (self simpleTypesFromTyper: typer ofVariable: aUGVariable)
		collectionTypes: (self collectionTypesFromTyper: typer ofVariable: aUGVariable)