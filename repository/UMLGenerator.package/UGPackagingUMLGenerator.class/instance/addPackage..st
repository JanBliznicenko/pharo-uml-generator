private
addPackage: aPackage
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackage name;
		yourself.
	encompassingPackage packagedElements add: umlPackage.
	^ umlPackage