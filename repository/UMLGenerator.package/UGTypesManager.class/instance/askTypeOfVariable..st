retrieving
askTypeOfVariable: aVariable
	^ self
		addType: (blockForVariable value: (varTyper possibleTypesOfVariable: aVariable))
		of: aVariable