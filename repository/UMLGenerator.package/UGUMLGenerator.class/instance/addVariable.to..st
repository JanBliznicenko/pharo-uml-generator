adding
addVariable: aVariable to: umlClass
	| umlAttribute ugClass upperBound |
	umlAttribute := OPUMLProperty new.
	ugClass := nil.
	doType
		ifTrue: [ ugClass := (typesManager typeOf: aVariable)
				ifNil: [ doType := false.
					nil ] ].
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlAttribute
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isShared;
		visibility: OPUMLVisibilityKind protected.
	umlAttribute type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]).
	umlClass ownedAttributes add: umlAttribute