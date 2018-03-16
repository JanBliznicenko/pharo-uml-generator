as yet unclassified
simpleTypeDictionary
	^ packages
		flatCollect: [ :eachPackage | eachPackage classes flatCollect: [ :eachClass | self simpleTypeDictionaryOfClass: eachClass ] as: Dictionary ]
		as: Dictionary