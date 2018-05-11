private
varTypeDictionaryOfClass: aClass
	| currentVariable |
	^ (aClass instanceVariables
		collect: [ :eachVariable | 
			currentVariable := UGVariable named: eachVariable in: aClass.
			currentVariable -> (self possibleTypesOfVariable: currentVariable) ]) asDictionary