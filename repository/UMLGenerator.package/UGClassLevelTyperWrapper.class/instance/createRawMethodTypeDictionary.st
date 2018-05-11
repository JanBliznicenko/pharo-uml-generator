private
createRawMethodTypeDictionary
	^ self
		createRawTypeDictionaryWith: [ :eachClass | self methodTypeDictionaryOfClass: eachClass ]