converting
possibleCollectionTypesAsUGClasses
	| ugCollections |
	ugCollections := OrderedCollection new.
	possibleCollectionTypes
		keysAndValuesDo:
			[ :eachClass :eachCollectionClass | ugCollections add: (UGCollection type: eachCollectionClass with: eachClass) ].
	^ ugCollections