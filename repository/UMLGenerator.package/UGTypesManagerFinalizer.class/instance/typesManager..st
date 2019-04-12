accessing
typesManager: aTypesManager
	aTypesManager blockForVariable: [ :typePossibilities | self typeFor: typePossibilities ].
	aTypesManager blockForParameter: [ :typePossibilities | self typeFor: typePossibilities ].
	typesManager := aTypesManager