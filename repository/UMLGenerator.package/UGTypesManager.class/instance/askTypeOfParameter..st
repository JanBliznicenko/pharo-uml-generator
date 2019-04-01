retrieving
askTypeOfParameter: aParameter
	^ self
		addType:
			(blockForParameter
				value:
					(UGTypePossibilities
						withAll: (self varTypers collect: [ :each | each possibleTypesOfParameter: aParameter ])))
		of: aParameter