conversions
packageNameFrom: aString
	^ aString asString
		replace: [ :char | 
			char = $-
				ifTrue: [ $. ]
				ifFalse: [ char ] ]