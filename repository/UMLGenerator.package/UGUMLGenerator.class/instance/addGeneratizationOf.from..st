public - importer
addGeneratizationOf: aClass from: aUmlClass
	| superClass umlSuperClass generalization |
	superClass := aClass superclass.
	(superClass == Object or: [ superClass == Object class ])
		ifTrue: [ ^ self ].
	umlSuperClass := umlClasses at: superClass ifAbsent: [ self addClass: superClass ].
	generalization := OPUMLGeneralization new
		general: umlSuperClass;
		specific: aUmlClass.
	model packagedElements add: generalization