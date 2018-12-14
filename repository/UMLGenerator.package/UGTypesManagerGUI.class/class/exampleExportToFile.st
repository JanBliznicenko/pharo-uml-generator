example
exampleExportToFile
	| umlModel xmiString |
	umlModel := UGEnterpriseArchitectUMLGenerator new
		typesManager: self new;
		importFromPackagesNamed: {'Announcements-Core'}.
	xmiString := OPUMLXMIWriter toString: umlModel.
	'Announcements-Core.xmi' asFileReference writeStreamDo: [ :stream | stream << xmiString ].
	^ xmiString