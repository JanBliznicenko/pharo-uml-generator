private
createRawVarTypeDictionary
	^ self
		createRawTypeDictionaryWith: [ :eachClass | self varTypeDictionaryOfClass: eachClass ]