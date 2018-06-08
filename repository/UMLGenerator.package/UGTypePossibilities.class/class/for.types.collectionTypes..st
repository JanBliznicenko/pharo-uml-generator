instance creation
for: anItem types: aCollectionOfTypes collectionTypes: aCollectionOfCollectionTypes
	^ self new
		item: anItem;
		possibleTypes: aCollectionOfTypes;
		possibleCollectionTypes: aCollectionOfCollectionTypes;
		yourself