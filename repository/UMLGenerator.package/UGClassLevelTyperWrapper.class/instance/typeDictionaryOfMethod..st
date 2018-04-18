as yet unclassified
typeDictionaryOfMethod: aMethod
	| currentVariable |
	^ (aMethod instanceVariables
		collect: [ :eachVariable | 
			currentVariable := UGVariable named: eachVariable in: aMethod.
			currentVariable -> (self possibleTypesOfVariable: currentVariable) ]) asDictionary