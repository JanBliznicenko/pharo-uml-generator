instance creation
withAll: aCollectionOfTypePossibilities
	| item |
	item := aCollectionOfTypePossibilities anyOne item.
	self assert: (aCollectionOfTypePossibilities allSatisfy: [ :each | each item = item ]).
	^ self
		for: item
		types: (aCollectionOfTypePossibilities flatCollect: [ :each | each possibleTypes ])
		collectionTypes: (aCollectionOfTypePossibilities flatCollect: [ :each | each possibleCollectionTypes ])