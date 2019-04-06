api
possibleTypesOfParameter: aParameter
	^ self possibleTypesFromBlock: [ :adaptor | adaptor possibleTypesOfParameter: aParameter ]