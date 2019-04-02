adding
addAsAssociationVariable: aVariable to: umlClass
	| umlClassProperty umlAssociationProperty ugClass upperBound umlAssociation |
	umlClassProperty := OPUMLProperty new.
	umlAssociationProperty := OPUMLProperty new.
	umlAssociation := OPUMLAssociation new.
	ugClass := self typeOf: aVariable.
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlClassProperty
		name: aVariable itemName;
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		isStatic: aVariable isClassSide;
		visibility: OPUMLVisibilityKind protected;
		owningClass: umlClass;
		association: umlAssociation;
		type: (umlClasses at: ugClass realClass).
	umlAssociationProperty
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: '*');
		owningAssociation: umlAssociation;
		association: umlAssociation;
		type: umlClass.
	umlAssociation name: umlClass name asString , '_' , aVariable variableName.
	umlAssociation memberEnds
		add: umlClassProperty;
		add: umlAssociationProperty.
	umlAssociation navigableOwnedEnds add: umlAssociationProperty.
	umlClass ownedAttributes add: umlClassProperty.
	(self umlPackageOfUmlClass: umlClass) packagedElements add: umlAssociation