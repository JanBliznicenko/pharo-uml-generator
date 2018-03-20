private
addPackage: aPackage
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackage name;
		yourself.
	model packagedElements: model packagedElements , {umlPackage}.
	^ umlPackage