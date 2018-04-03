adding
addMethod: aMethod to: umlClass classSide: aBoolean
	| umlMethod |
	(self shouldOmitAccessor: aMethod)
		ifTrue: [ ^ self halt ].
	umlMethod := OPUMLOperation new.
	umlMethod
		name: aMethod selector;
		isStatic: aBoolean.
	self addVisibilityOf: aMethod to: umlMethod.
	self addParametersOf: aMethod to: umlMethod.
	umlClass ownedOperations add: umlMethod