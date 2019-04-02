accessing
addPossibleType: aClass
	aClass == UndefinedObject ifTrue: [ ^ self ].
	possibleTypes add: (self replacementOfClass: aClass)