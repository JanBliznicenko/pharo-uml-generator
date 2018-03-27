initialization
initialize
	super initialize.
	packaging := true.
	umlClasses := Dictionary new.
	model := OPUMLModel new.
	model name: 'Generated UML'.
	encompassingPackage := model.
	packaging
		ifFalse: [ ^ self ].
	encompassingPackage := OPUMLPackage new.
	encompassingPackage name: 'Generated UML'.
	model packagedElements add: encompassingPackage