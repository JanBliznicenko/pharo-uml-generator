adding
addParameter: anUgParameter to: umlMethod
	| ugClass upperBound |
	ugClass := self typeOf: anUgParameter.
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlMethod ownedParameters
		add:
			((anUgParameter isOut
				ifTrue: [ OPUMLParameter new
						direction: OPUMLParameterDirectionKind return;
						uuid: 'EAID_RT000000_' , (UUID new asString allButFirst: 9) ]
				ifFalse: [ OPUMLParameter new
						direction: OPUMLParameterDirectionKind in;
						lowerValue: (OPUMLLiteralInteger new value: 0);
						upperValue: upperBound ])
				name: anUgParameter itemName;
				type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]))