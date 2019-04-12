example
exampleExportToFile
	| generator model |
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: self new.
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	generator saveXmlTo: 'Zinc-HTTP.xmi'.
	^ model