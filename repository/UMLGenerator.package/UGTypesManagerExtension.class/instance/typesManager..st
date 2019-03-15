accessing
typesManager: aTypesManager
	aTypesManager
		blockForVariable: [ :typePossibilities | self typeFor: typePossibilities ].
	typesManager := aTypesManager