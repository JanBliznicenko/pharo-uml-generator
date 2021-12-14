uml - generation
finishSilentUmlGenerationWithGenerator: aGeneratorClass saveTo: aFile
	instance ifNil: [ self notify: 'startSilentUmlGenerationFor: has to be called first.'. ^ self. ].
	instance 	generator: aGeneratorClass new;
		silentGenerateAndSaveTo: aFile.
	instance := nil.