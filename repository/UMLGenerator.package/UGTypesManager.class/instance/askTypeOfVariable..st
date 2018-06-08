retrieving
askTypeOfVariable: aVariable
	^ self
		addType:
			(blockForVariable
				value:
					(UGTypePossibilities
						for: aVariable
						types: (varTypers flatCollect: [ :each | each possibleTypesOfVariable: aVariable ])
						collectionTypes: (varTypers flatCollect: [ :each | each typeOfCollectionVariable: aVariable ])))
		of: aVariable