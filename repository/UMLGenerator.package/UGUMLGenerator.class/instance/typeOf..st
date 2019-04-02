adding
typeOf: anItem
	| ugClass |
	doType
		ifFalse: [ ^ nil ].
	ugClass := typesManager typeOf: anItem.
	ugClass
		ifNil: [ doType := false.
			^ nil ].
	ugClass realClass isMeta
		ifTrue: [ ^ ugClass copy
				realClass: Class;
				yourself ].
	^ ugClass