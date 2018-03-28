adding
addVariable: aSelector to: umlClass classSide: aBoolean
	| umlAttribute |
	umlAttribute := OPUMLProperty new.
	umlAttribute
		name: aSelector;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralInteger new value: 1);
		isStatic: aBoolean;
		visibility: OPUMLVisibilityKind protected.
	umlClass ownedAttributes add: umlAttribute