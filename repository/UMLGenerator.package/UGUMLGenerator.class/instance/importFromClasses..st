public - importer
importFromClasses: aClassesCollection
	(aClassesCollection includes: Object)
		ifTrue: [ self halt ].
	(aClassesCollection includes: Object class)
		ifTrue: [ self halt ].
	self addClasses: aClassesCollection.
	self addGeneralizations.
	self addMethods.
	self addAttributes.
	^ model