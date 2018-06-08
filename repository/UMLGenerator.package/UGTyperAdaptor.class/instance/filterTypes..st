private
filterTypes: aCollectionOfClasses
	| invalidClasses replacements |
	invalidClasses := self class invalidClasses.
	replacements := self class replacements.
	^ aCollectionOfClasses
		reject: [ :each | invalidClasses includes: each ]
		thenCollect: [ :each | replacements at: each ifAbsent: [ each ] ]