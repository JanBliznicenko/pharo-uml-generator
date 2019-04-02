adding
addAsPropertyVariable: aVariable to: umlClass
	| umlProperty ugClass upperBound |
	umlProperty := OPUMLProperty new.
	ugClass := self typeOf: aVariable.
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]).
	umlClass ownedAttributes add: umlProperty