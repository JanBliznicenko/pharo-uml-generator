private
addPackageNamed: aPackageName to: anEncompassingPackage
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackageName;
		nestingPackage: anEncompassingPackage;
		yourself.
	anEncompassingPackage packagedElements add: umlPackage.
	^ umlPackage