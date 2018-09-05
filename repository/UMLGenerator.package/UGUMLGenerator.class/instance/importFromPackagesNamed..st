public - importer
importFromPackagesNamed: aCollectionOfStrings
	| packages |
	packages := aCollectionOfStrings collect: #asPackage as: Set.
	focusedPackages := packages asSet.
	^ self importFromClasses: (packages flatCollect: #classes)