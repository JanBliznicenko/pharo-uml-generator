api
possibleTypesOfParameter: aUGParameter
	| method types |
	method := ((self infererOf: aUGParameter package)
		typeInfoFor: aUGParameter containingClass realClass)
		methodTypeFor: aUGParameter compiledMethod.
	types := (aUGParameter isOut
		ifTrue: [ method returnValue ]
		ifFalse: [ method parameters
				detect: [ :any | any variableName = aUGParameter itemName ] ])
		possibleClasses classes collect: #analysedClass.
	^ UGTypePossibilities
		for: aUGParameter
		types: types
		collectionTypes: Dictionary new