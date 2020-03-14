accessing
inferer
	^ inferer
		ifNil: [ inferer := J2InferenceManager inferAllInstalation ]