adding
addVariable: aVariable to: umlClass
	(doType
		and: [ | typeClass |
			typeClass := typesManager typeOf: aVariable.
			typeClass isNotNil and: [ focusedPackages includes: typeClass package ] ])
		ifTrue: [ ^ self addAsAssociationVariable: aVariable to: umlClass ].
	^ self addAsPropertyVariable: aVariable to: umlClass