adding
addType: aTypeOfItem of: anItem
	aTypeOfItem ifNil: [ ^ aTypeOfItem ].
	knownTypes at: anItem put: aTypeOfItem.
	autoSave
		ifTrue: [ self save ].
	^ aTypeOfItem