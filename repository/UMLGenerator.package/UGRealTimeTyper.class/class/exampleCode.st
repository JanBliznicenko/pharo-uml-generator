as yet unclassified
exampleCode
	| generator model |
	UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.
	UGRealTimeTyper default inspect.
	UGRealTimeTyper default uninstallLinks.
	UGRealTimeTyper resetDefault.
	'Zinc-HTTP' asPackage classes do: #recompile.
	'OP-UML-Metamodel' asPackage classes do: #recompile.
	'OP-UML-Metamodel' asPackage classes do: #recompile.
	UGTypesManager resetDefault.
	UGTypesManager default typerAdapters: {UGRealTimeTyperAdaptor default}.
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: UGAutoTypesManager new.
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	generator saveXmlTo: 'Zinc-HTTP.xmi'.
	^ model