instance creation
type: collectionClass with: realClass
	^ (self for: realClass)
		collectionRealClass: collectionClass;
		yourself