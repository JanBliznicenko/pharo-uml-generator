accessing
realClass: aClass
	aClass = True
		ifTrue: [ self halt ].
	realClass := aClass.
	itemName := aClass asString