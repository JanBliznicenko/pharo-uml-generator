testing
isPackageNamed: packageName equalTo: umlPackage
	^ (umlPackage isKindOf: OPUMLPackage)
		and: [ umlPackage name = (self packageNameFrom: packageName) ]