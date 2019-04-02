accessing
typerClasses: aCollection
	self typerAdapters: (aCollection collect: [ :each | each new ])