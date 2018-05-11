instance creation
packageNames: aCollectionOfStrings
	typerWrappers := self class typerClasses
		collect: [ :each | each forPackageNames: aCollectionOfStrings ]