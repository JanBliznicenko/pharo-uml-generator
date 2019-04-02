accessing
possibleTypes: aCollectionOfTypes
	possibleTypes := (aCollectionOfTypes
		reject: [ :each | each == UndefinedObject ]
		thenCollect: [ :each | self replacementOfClass: each ]) asSet