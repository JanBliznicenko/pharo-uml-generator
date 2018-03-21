public - importer
importWithoutPackagingFromPackagesNamed: aCollectionOfStrings
	^ self new
		noPackaging;
		importFromPackagesNamed: aCollectionOfStrings