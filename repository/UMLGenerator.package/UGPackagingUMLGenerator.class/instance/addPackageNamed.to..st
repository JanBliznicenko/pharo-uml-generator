private
addPackageNamed: aPackageName to: anEncompassingPackage
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackageName;
		yourself.
	anEncompassingPackage packagedElements add: umlPackage.
	^ umlPackage