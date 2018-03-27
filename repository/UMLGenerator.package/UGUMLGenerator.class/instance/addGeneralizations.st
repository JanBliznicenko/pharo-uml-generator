public - importer
addGeneralizations
	umlClasses keysDo: [ :realClass | self addSuperclassOf: realClass ].
	umlClasses keysDo: [ :realClass | self addGeneralizationSetTo: realClass ]