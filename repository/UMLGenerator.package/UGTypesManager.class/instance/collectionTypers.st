accessing
collectionTypers
	^ collectionTypers ifNil: [ collectionTypers := typerAdapters select: #isCollectionTyper ]