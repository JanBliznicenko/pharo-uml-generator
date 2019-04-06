api
possibleTypesFromBlock: aBlock
	adaptors ifEmpty: [ self error: 'no TyperAdaptor available' ].
	^ adaptors allButFirst
		inject: (aBlock value: adaptors first)
		into: [ :possibleTypes :eachAdaptor | possibleTypes , (aBlock value: eachAdaptor) ]