accessing
invalidClasses
	^ self invalidClassNames
		select: [ :each | Smalltalk globals includesKey: each ]
		thenCollect: [ :each | Smalltalk globals at: each ]