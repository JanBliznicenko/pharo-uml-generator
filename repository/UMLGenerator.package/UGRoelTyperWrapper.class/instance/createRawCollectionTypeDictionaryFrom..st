private
createRawCollectionTypeDictionaryFrom: aTypeDictionary
	self notify: 'Collection type inferring not supported - returning empty dictionary'.
	^ Dictionary new