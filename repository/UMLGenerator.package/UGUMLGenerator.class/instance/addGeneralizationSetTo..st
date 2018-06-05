public - importer
addGeneralizationSetTo: aSuperclass
	| set |
	set := OPUMLGeneralizationSet new
		name: 'Subclasses of ' , aSuperclass name;
		isDisjoint: true.
	self addGeneralizationsTo: aSuperclass toSet: set.
	encompassingPackage packagedElements add: set