accessing
collectionTypeDictionary
	collectionTypeDictionary ifNil: [ collectionTypeDictionary := self createCollectionTypeDictionary ].
	^ collectionTypeDictionary