private
addVariable: aSelector to: umlClass classSide: aBoolean
	| umlAttribute |
	umlAttribute := OPUMLProperty new.
	umlAttribute
		name: aSelector;
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		isStatic: aBoolean.
	umlClass ownedAttributes add: umlAttribute