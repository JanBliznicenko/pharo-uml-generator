public - importer
importFromClasses: aClassesCollection
	self addClass: Object.
	self addClasses: aClassesCollection.
	^ model