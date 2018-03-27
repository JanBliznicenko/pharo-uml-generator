public - importer
addGeneralizationSetTo: aSuperclass
	| umlSuperclass set |
	umlSuperclass := umlClasses at: aSuperclass.
	set := OPUMLGeneralizationSet new
		name: 'Subclasses of ' , aSuperclass name;
		isDisjoint: true.
	self addGeneralizationsTo: aSuperclass toSet: set.
	encompassingPackage packagedElements add: set