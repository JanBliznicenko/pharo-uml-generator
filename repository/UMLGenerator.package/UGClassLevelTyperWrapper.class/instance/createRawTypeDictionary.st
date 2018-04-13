accessing
createRawTypeDictionary
	^ packages
		flatCollect: [ :eachPackage | 
			eachPackage classes
				flatCollect: [ :eachClass | self typeDictionaryOfClass: eachClass ]
				as: Dictionary ]
		as: Dictionary