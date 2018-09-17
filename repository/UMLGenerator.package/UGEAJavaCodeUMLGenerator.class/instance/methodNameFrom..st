conversions
methodNameFrom: aString
	methodNameReplacements
		ifNil: [ methodNameReplacements := {('<' -> 'isLessThan').
			('>' -> 'isMoreThan').
			('<=' -> 'isLessOrEqualTo').
			('>=' -> 'isMoreOrEqualTo').
			('=' -> 'isEqualTo').
			('~=' -> 'isDifferentTo').
			(',' -> 'concatenate').
			('+' -> 'plus').
			('-' -> 'minus').
			('*' -> 'times').
			('/' -> 'dividedBy').
			('<<' -> 'nextPut').
			('>>' -> 'readInto')} asDictionary ].
	^ methodNameReplacements
		at: aString
		ifAbsent: [ (aString last = $:
				ifTrue: [ aString allButLast ]
				ifFalse: [ aString asString ])
				replace: [ :char | 
					char = $:
						ifTrue: [ $_ ]
						ifFalse: [ char ] ] ]