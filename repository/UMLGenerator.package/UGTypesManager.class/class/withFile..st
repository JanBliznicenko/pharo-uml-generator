instance creation
withFile: aFileName
	^ self new
		loadFromFile: aFileName;
		yourself