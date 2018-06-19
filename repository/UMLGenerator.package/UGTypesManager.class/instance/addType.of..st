retrieving
addType: aTypeOfItem of: anItem
	aTypeOfItem ifNil: [ ^ aTypeOfItem ].
	^ knownTypes at: anItem put: aTypeOfItem