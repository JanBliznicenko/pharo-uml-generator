retrieving
askTypeOfVariable: aVariable
	^ self
		addType:
			(blockForVariable
				value:
					(UGTypePossibilities
						withAll: (self varTypers collect: [ :each | each possibleTypesOfVariable: aVariable ])))
		of: aVariable