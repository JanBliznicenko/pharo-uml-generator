as yet unclassified
simpleTypeDictionaryOfClass: aClass
	| currentVariable |
	^ (aClass instanceVariables
		collect: [ :eachVariable | 
			currentVariable := UEVariable named: eachVariable in: aClass.
			currentVariable -> (self simpleTypeOfVariable: currentVariable) ]) asDictionary