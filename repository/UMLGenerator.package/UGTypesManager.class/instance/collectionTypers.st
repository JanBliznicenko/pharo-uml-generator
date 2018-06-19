accessing
collectionTypers
	^ collectionTypers
		ifNil: [ collectionTypers := self class collectionTypers
				collect: [ :each | typerAdapters at: each ] ]