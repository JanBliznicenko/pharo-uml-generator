accessing
simpleTypeDictionary
	simpleTypeDictionary ifNil: [ simpleTypeDictionary := self createSimpleTypeDictionary ].
	^ simpleTypeDictionary