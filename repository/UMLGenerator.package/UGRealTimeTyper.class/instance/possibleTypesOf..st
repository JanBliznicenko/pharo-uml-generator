api
possibleTypesOf: aUGItem
	^ typePossibilitiesDictionary at: aUGItem ifAbsentPut: [ UGTypePossibilities for: aUGItem ]