adding
addCollectionSpecificsOf: collectionRealClass to: umlElement
	(self class isOrderedCollectionClass: collectionRealClass)
		ifNotNil: [ :isOrdered | umlElement isOrdered: isOrdered ].
	(self class isUniqueCollectionClass: collectionRealClass)
		ifNotNil: [ :isUnique | umlElement isUnique: isUnique ].
	^ umlElement