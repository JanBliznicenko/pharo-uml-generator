private
addMethod: aMethod to: umlClass classSide: aBoolean
	| umlMethod |
	umlMethod := OPUMLOperation new.
	umlMethod
		name: aMethod selector;
		isStatic: aBoolean;
		visibility: OPUMLVisibilityKind public.
	self addParametersOf: aMethod to: umlMethod.
	umlClass ownedOperations add: umlMethod