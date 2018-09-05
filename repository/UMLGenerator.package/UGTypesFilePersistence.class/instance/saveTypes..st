persistence
saveTypes: aDictionary
	| s |
	file exists
		ifTrue: [ file delete ].
	s := file writeStream.
	STON put: aDictionary onStreamPretty: s.
	s close