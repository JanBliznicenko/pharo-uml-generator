adding
addClass: aClass
	^ (super addClass: aClass)
		package: (self umlPackageOf: aClass);
		yourself