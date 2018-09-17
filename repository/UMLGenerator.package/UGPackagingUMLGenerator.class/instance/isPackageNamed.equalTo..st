testing
isPackageNamed: packageName equalTo: umlPackage
	^ (umlPackage isKindOf: OPUMLPackage) and: [ umlPackage name = packageName ]