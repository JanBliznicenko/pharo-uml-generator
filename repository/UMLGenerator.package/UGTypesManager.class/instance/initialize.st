initialization
initialize
	super initialize.
	knownTypes := Dictionary new.
	persistence := UGTypesNoPersistence new.
	self typerClasses: self class defaultTyperClasses.
	autoSave := false.
	plannedSave := false.
	self defaultBlockForVariable.
	self defaultBlockForParameter