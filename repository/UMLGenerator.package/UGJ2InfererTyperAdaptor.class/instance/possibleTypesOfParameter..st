api
possibleTypesOfParameter: aUGParameter
	| method types possibleClasses classes |
	method := ((self infererOf: aUGParameter package)
		typeInfoFor: aUGParameter containingClass realClass)
		methodTypeFor: aUGParameter compiledMethod.
	possibleClasses := (aUGParameter isOut
		ifTrue: [ method returnValue ]
		ifFalse: [ method parameters
				detect: [ :any | any variableName = aUGParameter itemName ] ])
		possibleClasses.
	classes := possibleClasses classes.
	types := classes collect: #analysedClass.
	types remove: UndefinedObject ifAbsent: [  ]."
	self
		haltIf: [ types
				anySatisfy: [ :any | any = Collection or: [ any inheritsFrom: Collection ] ] ]."
	^ UGTypePossibilities
		for: aUGParameter
		types: types
		collectionTypes: Dictionary new