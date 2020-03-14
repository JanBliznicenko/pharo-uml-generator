adding
addVariablesOf: realClass to: umlClass
	realClass instVarNames
		do: [ :eachVariable | 
			self
				addVariable: (UGVariable named: eachVariable in: realClass)
				to: umlClass ].
	realClass classVarNames , realClass class instVarNames
		do: [ :eachVariable | 
			self
				addVariable: (UGVariable named: eachVariable in: realClass) shared
				to: umlClass ].
	((self rootClasses includes: realClass superclass)
		or: [ umlClasses includesKey: realClass superclass ])
		ifFalse: [ self addVariablesOf: realClass superclass to: umlClass ]