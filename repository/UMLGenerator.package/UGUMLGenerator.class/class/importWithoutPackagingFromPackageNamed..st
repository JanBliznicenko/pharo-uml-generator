public - importer
importWithoutPackagingFromPackageNamed: aString
	^ self new
		noPackaging;
		importFromPackageNamed: aString