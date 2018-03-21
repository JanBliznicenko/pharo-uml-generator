private
addPackage: aPackage
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackage name;
		yourself.
	model packagedElements add: umlPackage.
	^ umlPackage