public - importer
addVariablesOf: realClass to: umlClass
	realClass instanceVariables
		do: [ :eachVariable | self addInstanceVariable: eachVariable to: umlClass ].
	realClass classVarNames
		do: [ :eachVariable | self addClassVariable: eachVariable to: umlClass ].
	realClass class instanceVariables
		do: [ :eachVariable | self addClassInstanceVariable: eachVariable to: umlClass ].
	(realClass superclass ~~ Object
		and: [ realClass superclass ~~ ProtoObject
				and: [ (umlClasses includesKey: realClass superclass) not ] ])
		ifTrue: [ self addVariablesOf: realClass superclass to: umlClass ]