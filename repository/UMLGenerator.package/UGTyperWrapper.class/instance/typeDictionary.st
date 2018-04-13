accessing
typeDictionary
	typeDictionary ifNil: [ typeDictionary := self createTypeDictionary ].
	^ typeDictionary