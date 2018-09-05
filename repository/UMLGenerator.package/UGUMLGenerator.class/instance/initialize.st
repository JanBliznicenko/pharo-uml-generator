initialization
initialize
	super initialize.
	includeAccessors := true.
	umlClasses := Dictionary new.
	model := OPUMLModel new.
	model name: 'Generated UML'.
	encompassingPackage := model.
	typesManager := UGTypesManager default.
	doType := true.
	focusedPackages := Set new.