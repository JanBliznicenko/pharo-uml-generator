accessing
typeDictionary
	typeDictionary ifNil: [ typeDictionary := self createVarTypeDictionary ].
	^ typeDictionary