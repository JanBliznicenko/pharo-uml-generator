testing
isOrderedCollectionClass: collectionRealClass
	classOrdering
		ifNil: [ classOrdering := ({(Bag -> false).
			(DependentsArray -> true).
			(DoubleLinkedList -> true).
			(FLLargeIdentityHashedCollection -> false).
			(HashedCollection -> false).
			(Heap -> false).
			(OrderedDictionary -> true).
			(RelationSet -> false).
			(SequenceableCollection -> true).
			(SmallDictionary -> false).
			(StandardOrderedDictionary -> true).
			(WeakRegistry -> false).
			(WideCharacterSet -> false)}
				flatCollect: [ :eachPair | eachPair key withAllSubclasses collect: [ :each | each -> eachPair value ] ]) asDictionary ].
	^ classOrdering
		at: collectionRealClass
		ifAbsent: [ nil ]