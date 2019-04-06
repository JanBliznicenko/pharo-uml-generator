retrieving
askTypeOfParameter: aParameter
	^ self
		addType:
			(blockForParameter
				value: (methodTyper possibleTypesOfParameter: aParameter))
		of: aParameter