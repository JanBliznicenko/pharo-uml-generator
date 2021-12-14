initialization
initialize
	typesManager := UGTypesManager withFile: self class typeInfo.
	typerAdaptor := UGTyperBackupsCombinator withAdaptors: {UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new.}.
	typesManager autoSave;
		typerAdaptor: typerAdaptor.
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.