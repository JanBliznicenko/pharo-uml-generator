retrieving
askTypeOfParameter: aParameter
	skipMethods
		ifTrue: [ ^ UGClass for: Object ].
	^ self
		addType:
			(blockForParameter
				value: (methodTyper possibleTypesOfParameter: aParameter))
		of: aParameter