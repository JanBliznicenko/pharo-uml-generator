adding
addVariable: aVariable to: umlClass
	(doType and: [ (typesManager typeOf: aVariable) isNotNil ])
		ifTrue: [ ^ self addAsAssociationVariable: aVariable to: umlClass ].
	^ self addAsPropertyVariable: aVariable to: umlClass