adding
addAsAssociationVariable: aVariable to: umlClass
	| umlClassProperty umlAssociationProperty typeUGClass upperBound umlAssociation |
	umlClassProperty := OPUMLProperty new.
	umlAssociationProperty := OPUMLProperty new.
	umlAssociation := OPUMLAssociation new.
	typeUGClass := self typeOf: aVariable.
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlClassProperty.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlClassProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		association: umlAssociation;
		type: (umlClasses at: typeUGClass realClass).
	umlAssociationProperty
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		owningAssociation: umlAssociation;
		association: umlAssociation;
		type: umlClass.
	umlAssociation
		name: umlClass name asString , '_' , aVariable variableName.
	umlAssociation memberEnds
		add: umlClassProperty;
		add: umlAssociationProperty.
	umlAssociation navigableOwnedEnds add: umlAssociationProperty.
	umlClass ownedAttributes add: umlClassProperty.
	(self umlPackageOfUmlClass: umlClass) packagedElements
		add: umlAssociation