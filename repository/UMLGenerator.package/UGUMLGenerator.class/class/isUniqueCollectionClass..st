testing
isUniqueCollectionClass: collectionRealClass
	classUniqueness
		ifNil: [ classUniqueness := ({(Bag -> false).
			(DependentsArray -> false).
			(DoubleLinkedList -> false).
			(FLLargeIdentityHashedCollection -> false).
			(Dictionary -> false).
			(Set -> true).
			(Heap -> false).
			(OrderedDictionary -> false).
			(RelationSet -> true).
			(Interval -> true).
			(SmallDictionary -> false).
			(StandardOrderedDictionary -> false).
			(WeakRegistry -> false).
			(WideCharacterSet -> true)}
				,
					((SequenceableCollection subclasses copyWithout: Interval)
						collect: [ :each | each -> false ])
				flatCollect:
					[ :eachPair | eachPair key withAllSubclasses collect: [ :each | each -> eachPair value ] ])
				asDictionary ].
	^ classUniqueness at: collectionRealClass ifAbsent: [ nil ]