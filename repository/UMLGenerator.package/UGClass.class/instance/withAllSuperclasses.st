accessing class hierarchy
withAllSuperclasses
	^ realClass withAllSuperclasses reversed collect: [ :each | self class for: each ]