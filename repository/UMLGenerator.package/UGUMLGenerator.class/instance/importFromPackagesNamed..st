public - importer
importFromPackagesNamed: aCollectionOfStrings
	^ self
		importFromClasses: (aCollectionOfStrings flatCollect: [ :each | each asPackage classes ])