initialization
initialize
	super initialize.
	typePossibilitiesDictionary := Dictionary new.
	links := OrderedCollection new.
	linkedPackages := Set new.
	self
		createAssignmentLinkBlock;
		createArgumentsLinkBlock;
		createReturnLinkBlock;
		createReturnSelfLinkBlock