accessing
createRawCollectionTypeDictionary
	| collectionsDictionary |
	collectionsDictionary := self typeDictionary
		select:
			[ :types | types anySatisfy: [ :any | any = Collection or: [ any inheritsFrom: Collection ] ] ].
	^ self createRawCollectionTypeDictionaryFrom: collectionsDictionary