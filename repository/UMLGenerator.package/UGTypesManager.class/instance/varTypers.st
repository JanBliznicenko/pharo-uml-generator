accessing
varTypers
	^ varTypers
		ifNil: [ varTypers := self class varTypers collect: [ :each | typerAdapters at: each ] ]