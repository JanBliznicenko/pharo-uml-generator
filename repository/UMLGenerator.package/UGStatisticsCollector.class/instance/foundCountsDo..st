converting
foundCountsDo: aBlock
	foundCounts ifNil: [ self calculate ].
	^ foundCounts do: aBlock