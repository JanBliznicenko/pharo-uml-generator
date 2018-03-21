initialization
initialize
	super initialize.
	packaging := true.
	umlClasses := Dictionary new.
	model := OPUMLModel new.
	model name: 'Generated UML'