adding
addParameter: anUgParameter to: umlMethod
	| ugClass upperBound |
	ugClass := nil.
	doType
		ifTrue: [ ugClass := (typesManager typeOf: anUgParameter)
				ifNil: [ doType := false.
					nil ] ].
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlMethod ownedParameters
		add:
			((anUgParameter isOut
				ifTrue: [ OPUMLParameter new direction: OPUMLParameterDirectionKind return ]
				ifFalse: [ OPUMLParameter new
						direction: OPUMLParameterDirectionKind in;
						lowerValue: (OPUMLLiteralInteger new value: 0);
						upperValue: upperBound ])
				name: anUgParameter itemName;
				uuid: 'EAID_RT000000' , (UUID new asString allButFirst: 8);
				visibility: OPUMLVisibilityKind public;
				type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]))