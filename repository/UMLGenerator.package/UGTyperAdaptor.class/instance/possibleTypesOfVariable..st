api
possibleTypesOfVariable: aVariable
	self isVarTyper
		ifFalse: [ ^ UGTypePossibilities for: aVariable ].
	^ self subclassResponsibility