instance creation
packageNames: aCollectionOfStrings
	typerAdapters := self class typerClasses collect: [ :each | each default ]