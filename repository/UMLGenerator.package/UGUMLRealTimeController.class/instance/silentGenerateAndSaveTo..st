uml - generation
silentGenerateAndSaveTo: aFile
	"save types into following file"
	typesManager := UGTypesManager withFile: self class typeInfo.
	"use following typer(s)"
	typerAdaptor := UGTyperBackupsCombinator withAdaptors: {UGRealTimeTyperAdaptor new. UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new }.
	"setup types manager"
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	"use finalizer for getting final types from all the ones found by typers"
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.
	"use the proper generator for the target tool (each one requires little differences in the model)"
	generator typesManager: typesFinalizer.
	"generate model for the following packages"
	generator importFromPackagesNamed: { analyzedPackage }.
	"save the xmi model into following file"
	generator saveXmlTo: aFile.
	"Remove links from realtime interferer usage."
	self clearAfterRealTimeInferer.