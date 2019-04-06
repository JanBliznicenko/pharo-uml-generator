private
commonSuperclassOf: classes
	| currentSuperclasses bestCommonIndex commonHierarchy classesArray |
	classes ifEmpty: [ ^ Object ].
	classes size = 1
		ifTrue: [ ^ classes anyOne ].
	classesArray := classes asArray.
	commonHierarchy := classesArray copyWithoutFirst
		inject: classesArray first withAllSuperclasses reversed
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