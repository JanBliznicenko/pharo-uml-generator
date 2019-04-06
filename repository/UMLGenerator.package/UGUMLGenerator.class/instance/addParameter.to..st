adding
addParameter: anUgParameter to: umlMethod
	| ugClass upperBound |
	ugClass := self typeOf: anUgParameter.
	upperBound := (ugClass isNotNil and: [ ugClass isCollectionClass ])
		ifTrue: [ OPUMLLiteralUnlimitedNatural new value: '*' ]
		ifFalse: [ OPUMLLiteralInteger new value: 1 ].
	ugClass ifNotNil: [ self addClass: ugClass realClass ].
	umlMethod ownedParameters
		add:
			((anUgParameter isOut
				ifTrue: [ self newReturnParameter ]
				ifFalse: [ OPUMLParameter new direction: OPUMLParameterDirectionKind in ])
				lowerValue: (OPUMLLiteralInteger new value: 0);
				upperValue: upperBound;
				name: anUgParameter itemName;
				type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]))