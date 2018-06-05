adding
addVariable: aVariable to: umlClass
	| umlAttribute |
	umlAttribute := OPUMLProperty new.
	umlAttribute
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralInteger new value: 1);
		type: (umlClasses at: (typesManager typeOf: aVariable));
		isStatic: aVariable isShared;
		visibility: OPUMLVisibilityKind protected.
	umlClass ownedAttributes add: umlAttribute