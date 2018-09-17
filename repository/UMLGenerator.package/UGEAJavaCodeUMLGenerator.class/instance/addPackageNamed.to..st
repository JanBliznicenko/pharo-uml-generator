private
addPackageNamed: aPackageName to: anEncompassingPackage
	^ super addPackageNamed: (self packageNameFrom: aPackageName) to: anEncompassingPackage