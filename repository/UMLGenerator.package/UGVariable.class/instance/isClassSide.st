testing
isClassSide
	^ isShared or: [ self containingClass isMeta ]