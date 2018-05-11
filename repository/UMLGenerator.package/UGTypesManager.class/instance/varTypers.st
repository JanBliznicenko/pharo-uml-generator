accessing
varTypers
	^ varTypers
		ifNil: [ varTypers := self class varTypers collect: [ :each | typerWrappers at: each ] ]