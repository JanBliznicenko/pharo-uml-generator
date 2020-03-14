api
possibleTypesOfParameter: aUGParameter
	self isMethodTyper
		ifFalse: [ ^ UGTypePossibilities for: aUGParameter ].
	^ self subclassResponsibility