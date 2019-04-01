api
possibleTypesOf: aUGItem
	^ typePossibilitiesDictionary at: aUGItem ifAbsent: [ UGTypePossibilities for: aUGItem ]