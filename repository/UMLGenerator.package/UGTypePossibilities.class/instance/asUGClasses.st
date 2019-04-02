converting
asUGClasses
	| ugCollections |
	ugCollections := OrderedCollection new.
	possibleCollectionTypes
		keysAndValuesDo: [ :eachClass :eachCollectionClass | 
			ugCollections
				add: (UGCollection type: eachCollectionClass with: eachClass) ].
	^ ugCollections
		,
			(possibleTypes
				collect: [ :each | UGClass for: each ]
				as: OrderedCollection)