adding
addMethod: aMethod to: umlClass
	| umlMethod |
	(self shouldOmitAccessor: aMethod)
		ifTrue: [ ^ self ].
	umlMethod := self umlMethodFrom: aMethod.
	self addVisibilityOf: aMethod to: umlMethod.
	self addParametersOf: aMethod to: umlMethod.
	umlClass ownedOperations add: umlMethod