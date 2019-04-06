api
possibleTypesOfVariable: aVariable
	^ self
		possibleTypesFromBlock: [ :adaptor | adaptor possibleTypesOfVariable: aVariable ]