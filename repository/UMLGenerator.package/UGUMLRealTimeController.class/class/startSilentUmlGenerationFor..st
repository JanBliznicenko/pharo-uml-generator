uml - generation
startSilentUmlGenerationFor: aPackageName
	instance ifNotNil: [ instance clearAfterRealTimeInferer. ].
	instance := self new.
	instance analyzedPackage: aPackageName;
		prepareForRealTimeInferer.