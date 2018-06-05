testing
isClassVariable
	^ isShared or: [ self containingClass isMeta ]