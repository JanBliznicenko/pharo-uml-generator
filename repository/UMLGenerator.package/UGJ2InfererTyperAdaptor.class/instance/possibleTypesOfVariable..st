api
possibleTypesOfVariable: aUGVariable
	^ UGTypePossibilities
		for: aUGVariable
		types:
			((((self infererOf: aUGVariable package)
				typeInfoFor: aUGVariable realContainingClass)
				instanceVariable: aUGVariable itemName) possibleClasses classes
				collect: #analysedClass)
		collectionTypes: Dictionary new