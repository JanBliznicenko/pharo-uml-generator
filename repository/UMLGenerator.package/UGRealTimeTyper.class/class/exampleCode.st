as yet unclassified
exampleCode
	| generator model |
	UGRealTimeTyper default uninstallLinks.
	UGRealTimeTyper resetDefault.
	
	'Zinc-HTTP' asPackage classes do: #recompile.
	
	UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.
	
	UGTypesManager resetDefault.
	UGTypesManager default typerAdaptor: UGRealTimeTyperAdaptor new.
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: UGAutoTypesManager new.
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	generator saveXmlTo: 'Zinc-HTTP.xmi'.
	^ model