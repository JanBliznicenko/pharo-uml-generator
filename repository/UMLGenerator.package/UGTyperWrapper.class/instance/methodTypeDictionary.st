accessing
methodTypeDictionary
	methodTypeDictionary ifNil: [ methodTypeDictionary := self createMethodTypeDictionary ].
	^ methodTypeDictionary