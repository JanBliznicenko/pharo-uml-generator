accessing
varTypers
	^ varTypers ifNil: [ varTypers := typerAdapters select: #isVarTyper ]