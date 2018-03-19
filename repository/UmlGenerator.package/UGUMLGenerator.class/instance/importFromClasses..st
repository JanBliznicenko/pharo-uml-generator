public - importer
importFromClasses: aCollection
	| model importer |
	model := OPUMLModel new.
	importer := UGUMLImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer runCandidateOperator.
	importer
		model: model;
		addClasses: aCollection;
		runWithProgress.
	self processPragmasFor: model.
	self processClassSide: model.
	^ model