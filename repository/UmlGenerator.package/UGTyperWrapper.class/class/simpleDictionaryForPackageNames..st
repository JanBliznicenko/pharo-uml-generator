instance creation
simpleDictionaryForPackageNames: aStringCollection
	^ self new
		packageNames: aStringCollection;
		simpleTypeDictionary