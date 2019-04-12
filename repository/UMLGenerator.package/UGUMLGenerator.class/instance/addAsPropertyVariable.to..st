adding
addAsPropertyVariable: aVariable to: umlClass
	| umlProperty typeUGClass upperBound |
	umlProperty := OPUMLProperty new.
	typeUGClass := self typeOf: aVariable.
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlProperty.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		type:
			(typeUGClass
				ifNil: [ umlClasses at: Object ]
				ifNotNil: [ umlClasses at: typeUGClass realClass ]).
	umlClass ownedAttributes add: umlProperty