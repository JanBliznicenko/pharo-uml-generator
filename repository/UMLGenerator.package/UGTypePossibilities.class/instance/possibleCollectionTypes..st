accessing
possibleCollectionTypes: aDictionaryOfTypes
	possibleCollectionTypes := (aDictionaryOfTypes associations
		collect: [ :each | (self replacementOfClass: each key) -> (self replacementOfClass: each value) ]
		thenReject: [ :each | each key == UndefinedObject ]) asDictionary