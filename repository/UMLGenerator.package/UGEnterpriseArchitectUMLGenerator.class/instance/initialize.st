initialization
initialize
	super initialize.
	encompassingPackage := OPUMLPackage new.
	encompassingPackage name: 'Generated UML'.
	model packagedElements add: encompassingPackage