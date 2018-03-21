public - importer
importFromClasses: aClassesCollection
	self addClasses: aClassesCollection.
	self addGeneralizations.
	self addMethods.
	^ model