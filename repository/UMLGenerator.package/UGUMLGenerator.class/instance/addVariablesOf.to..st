public - importer
addVariablesOf: realClass to: umlClass
	realClass instanceVariables
		do:
			[ :eachVariable | self addVariable: (UGVariable named: eachVariable in: realClass) to: umlClass ].
	realClass classVarNames
		do: [ :eachVariable | 
			self
				addVariable: (UGVariable named: eachVariable in: realClass class) shared
				to: umlClass ].
	realClass class instanceVariables
		do:
			[ :eachVariable | self addVariable: (UGVariable named: eachVariable in: realClass class) to: umlClass ].
	(realClass superclass ~~ Object
		and: [ realClass superclass ~~ ProtoObject
				and: [ (umlClasses includesKey: realClass superclass) not ] ])
		ifTrue: [ self addVariablesOf: realClass superclass to: umlClass ]