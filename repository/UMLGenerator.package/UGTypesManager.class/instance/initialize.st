initialization
initialize
	super initialize.
	knownTypes := Dictionary new.
	persistence := UGTypesNoPersistence new.
	self typerAdaptor: self class newDefaultTyper.
	autoSave := false.
	plannedSave := false.
	self defaultBlockForVariable.
	self defaultBlockForParameter