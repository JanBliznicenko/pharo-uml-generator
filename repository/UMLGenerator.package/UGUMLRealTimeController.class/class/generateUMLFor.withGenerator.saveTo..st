uml - generation
generateUMLFor: aPackageName withGenerator: aGeneratorClass saveTo: aFile
	instance ifNotNil: [ instance clearAfterRealTimeInferer. ].
	instance := self new.
	instance analyzedPackage: aPackageName;
		generator: aGeneratorClass new;
		generateAndSaveTo: aFile.
	instance := nil.