accessing
createRawMethodTypeDictionary
	^ packages
		flatCollect: [ :eachPackage | 
			eachPackage classes
				flatCollect: [ :eachClass | self methodTypeDictionaryOfClass: eachClass ]
				as: Dictionary ]
		as: Dictionary