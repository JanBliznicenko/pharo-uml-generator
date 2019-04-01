accessing
methodTypers
	^ methodTypers ifNil: [ methodTypers := typerAdapters select: #isMethodTyper ]