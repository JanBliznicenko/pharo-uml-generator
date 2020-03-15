example
exampleCode
	| generator model typesManager typerAdaptor typesFinalizer |
	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.
	
	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	'Zinc-HTTP' asPackage classes do: #recompile.
	
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.
	
	"this is the time to run tests/scenarios to log types"
	self notify: 'This is time to run tests/scenarios to log types for realtime type inferer.', String cr, 'Run the tests/scenarios and then click Proceed'.
	
	"save types into following file"
	typesManager := UGTypesManager withFile: 'default.typeinfo-all-backups.ston'.
	"use following typer(s)"
	typerAdaptor := UGTyperBackupsCombinator
		withAdaptors:
			{UGRealTimeTyperAdaptor new.
			UGRoelTyperAdaptor new.
			UGRBTyperAdaptor new}.
	"setup types manager"			
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	"use finalizer for getting final types from all the ones found by typers"
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.
	"use the proper generator for the target tool (each one requires little differences in the model)"
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: typesFinalizer.
	
	"generate model for the following packages"
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	"save the xmi model into following file"
	generator saveXmlTo: 'Zinc-HTTP-EA.xmi'.
	
	^ model