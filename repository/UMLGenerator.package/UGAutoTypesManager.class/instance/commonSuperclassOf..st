retrieving
commonSuperclassOf: ugClasses
	| realClasses currentSuperclasses bestCommonIndex commonHierarchy |
	ugClasses ifEmpty: [ ^ Object ].
	realClasses := ugClasses collect: #realClass.
	realClasses size = 1
		ifTrue: [ ^ realClasses first ].
	commonHierarchy := realClasses copyWithoutFirst
		inject: realClasses first withAllSuperclasses reversed
		into: [ :lastHierarchy :realClass | 
			currentSuperclasses := realClass withAllSuperclasses reversed.
			lastHierarchy first == currentSuperclasses first
				ifFalse: [ ^ Object ].
			bestCommonIndex := 1.
			1 to: (lastHierarchy size min: currentSuperclasses size) do: [ :i | 
				(lastHierarchy at: i) == (currentSuperclasses at: i)
					ifTrue: [ bestCommonIndex := i ] ].
			lastHierarchy first: bestCommonIndex ].
	^ commonHierarchy last