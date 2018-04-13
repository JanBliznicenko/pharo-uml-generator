accessing
createSimpleTypeDictionary
	^ self typeDictionary collect: [ :types | types commonClassesSuperclass ]