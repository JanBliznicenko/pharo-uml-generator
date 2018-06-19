accessing
methodTypers
	^ methodTypers
		ifNil: [ methodTypers := self class methodTypers collect: [ :each | typerAdapters at: each ] ]