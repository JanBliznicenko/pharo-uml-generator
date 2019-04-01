adding
addVariablesOf: realClass to: umlClass
	realClass instanceVariables
		do:
			[ :eachVariable | self addVariable: (UGVariable named: eachVariable in: realClass) to: umlClass ].
	((self rootClasses includes: realClass superclass)
		or: [ umlClasses includesKey: realClass superclass ])
		ifFalse: [ self addVariablesOf: realClass superclass to: umlClass ]