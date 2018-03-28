public - importer
importFromClasses: aClassesCollection
	self addClasses: aClassesCollection.
	self addGeneralizations.
	self addClass: Object.
	self addVariables.
	self addMethods.
	^ model