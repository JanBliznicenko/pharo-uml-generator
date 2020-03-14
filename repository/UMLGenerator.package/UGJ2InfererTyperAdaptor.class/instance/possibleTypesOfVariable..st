api
possibleTypesOfVariable: aUGVariable
	^ UGTypePossibilities
		for: aUGVariable
		types:
			(((self inferer typeInfoFor: aUGVariable containingClass realClass)
				instanceVariable: aUGVariable itemName) possibleClasses classes
				collect: #analysedClass)
		collectionTypes: Dictionary new