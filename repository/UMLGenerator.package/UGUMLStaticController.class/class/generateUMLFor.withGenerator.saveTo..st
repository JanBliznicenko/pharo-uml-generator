uml - generation
generateUMLFor: aPackageName withGenerator: aGeneratorClass saveTo: aFile
	| instance |
	instance := self new.
	instance analyzedPackage: aPackageName;
		generator: aGeneratorClass new;
		generateAndSaveTo: aFile.