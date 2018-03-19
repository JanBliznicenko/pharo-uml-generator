as yet unclassified
simpleTypeDictionaryOfClass: aClass
	| currentVariable |
	^ (aClass instanceVariables
		collect: [ :eachVariable | 
			currentVariable := UGVariable named: eachVariable in: aClass.
			currentVariable -> (self simpleTypeOfVariable: currentVariable) ]) asDictionary