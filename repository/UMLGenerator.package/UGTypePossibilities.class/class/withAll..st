instance creation
withAll: aCollectionOfTypePossibilities
	| item collectionTypes |
	item := aCollectionOfTypePossibilities anyOne item.
	self assert: (aCollectionOfTypePossibilities allSatisfy: [ :each | each item = item ]).
	collectionTypes := Dictionary new.
	aCollectionOfTypePossibilities
		do: [ :each | collectionTypes addAll: each possibleCollectionTypes ].
	^ self
		for: item
		types: (aCollectionOfTypePossibilities flatCollect: [ :each | each possibleTypes ])
		collectionTypes: collectionTypes