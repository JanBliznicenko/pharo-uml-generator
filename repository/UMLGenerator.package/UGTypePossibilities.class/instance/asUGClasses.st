converting
asUGClasses
	^ (possibleCollectionTypes
		collect: [ :each | UGCollection for: each ]
		as: OrderedCollection)
		, (possibleTypes collect: [ :each | UGClass for: each ] as: OrderedCollection)