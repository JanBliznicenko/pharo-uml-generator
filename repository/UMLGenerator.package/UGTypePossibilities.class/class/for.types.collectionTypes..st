instance creation
for: anItem types: aCollectionOfTypes collectionTypes: aDictionaryOfCollectionTypes
	^ self new
		item: anItem;
		possibleTypes: aCollectionOfTypes;
		possibleCollectionTypes: aDictionaryOfCollectionTypes;
		yourself