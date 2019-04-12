adding
addParameter: anUgParameter to: umlMethod
	| typeUGClass upperBound umlParameter |
	typeUGClass := self typeOf: anUgParameter.
	umlParameter := anUgParameter isOut
		ifTrue: [ self newReturnParameter ]
		ifFalse: [ OPUMLParameter new direction: OPUMLParameterDirectionKind in ].
	upperBound := (typeUGClass isNotNil
		and: [ typeUGClass isCollectionClass ])
		ifTrue: [ self
				addCollectionSpecificsOf: typeUGClass collectionRealClass
				to: umlParameter.
			OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	typeUGClass ifNotNil: [ self addClass: typeUGClass realClass ].
	umlParameter
		lowerValue: (OPUMLLiteralInteger new value: 0);
		upperValue: upperBound;
		name: anUgParameter itemName;
		type:
			(typeUGClass
				ifNil: [ umlClasses at: Object ]
				ifNotNil: [ umlClasses at: typeUGClass realClass ]).
	umlMethod ownedParameters add: umlParameter