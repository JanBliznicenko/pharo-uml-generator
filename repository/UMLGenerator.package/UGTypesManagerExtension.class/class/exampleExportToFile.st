example
exampleExportToFile
	| generator model |
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: self new.
	model := generator importFromPackagesNamed: {'Announcements-Core'}.
	generator saveXmlTo: 'Announcements-Core.xmi'.
	^ model