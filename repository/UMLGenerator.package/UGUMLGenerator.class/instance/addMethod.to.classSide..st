adding
addMethod: aMethod to: umlClass classSide: aBoolean
	| umlMethod |
	(self shouldOmitAccessor: aMethod)
		ifTrue: [ ^ self ].
	umlMethod := self umlMethodFrom: aMethod.
	umlMethod isStatic: aBoolean.
	self addVisibilityOf: aMethod to: umlMethod.
	self addParametersOf: aMethod to: umlMethod.
	umlClass ownedOperations add: umlMethod