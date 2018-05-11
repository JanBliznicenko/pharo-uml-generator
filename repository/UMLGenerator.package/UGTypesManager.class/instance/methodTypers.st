accessing
methodTypers
	^ methodTypers
		ifNil: [ methodTypers := self class methodTypers collect: [ :each | typerWrappers at: each ] ]