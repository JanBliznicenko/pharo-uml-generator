as yet unclassified
exampleCode
	| generator model |
	UGRealTimeTyper default uninstallLinks.
UGRealTimeTyper resetDefault.

'Zinc-HTTP' asPackage classes do: #recompile.

UGRealTimeTyper default addLinksToPackageNamed: 'Zinc-HTTP'.

UGRealTimeTyper default inspect.

UGTypesManager resetDefault.
UGTypesManager default typerAdapters: {UGRealTimeTyperAdaptor new}.
generator := UGEnterpriseArchitectUMLGenerator new typesManager: UGAutoTypesManager new.
model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
generator saveXmlTo: 'Zinc-HTTP.xmi'.
^model