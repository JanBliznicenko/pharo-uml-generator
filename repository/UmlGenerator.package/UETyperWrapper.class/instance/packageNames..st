accessing
packageNames: aCollectionOfStrings
	self packages: (aCollectionOfStrings collect: [ :each | each asPackage ])