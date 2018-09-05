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
				ifTrue: [ OPUMLParameter new
						name: 'return';
						direction: OPUMLParameterDirectionKind return ]
				ifFalse: [ OPUMLParameter new
						name: anUgParameter itemName;
						direction: OPUMLParameterDirectionKind in ])
				type: (ugClass ifNil: [ umlClasses at: Object ] ifNotNil: [ umlClasses at: ugClass realClass ]);
				lowerValue: (OPUMLLiteralInteger new value: 0);
				upperValue: upperBound)