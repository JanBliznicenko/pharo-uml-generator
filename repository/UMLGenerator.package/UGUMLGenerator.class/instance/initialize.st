initialization
initialize
	super initialize.
	umlClasses := Dictionary new.
	model := OPUMLModel new.
	model name: 'Generated UML'