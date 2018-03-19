public - importer
importFromPackageNamed: aPackageName
	| model importer |
	model := OPUMLModel new.
	model name: aPackageName.
	importer := UGUMLImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addFromPackageNamed: aPackageName;
		runWithProgress.
	self processClassSide: model.
	self processPragmasFor: model.
	^ model