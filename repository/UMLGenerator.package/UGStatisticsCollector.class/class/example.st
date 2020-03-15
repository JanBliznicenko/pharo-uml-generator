example
example
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.
	
	"this is the time to run tests/scenarios to log types"
	self notify: 'This is time to run tests/scenarios to log types for realtime type inferer.', String cr, 'Run the tests/scenarios and then click Proceed'.
	
	"save types into following file"
	(UGStatisticsCollector new 
	variablesOnly;
	packageName: 'Zinc-HTTP';
	asLatexTables), 
	String cr, 
	(UGStatisticsCollector new
	packageName: 'Zinc-HTTP';
	asLatexTables).
	
	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.