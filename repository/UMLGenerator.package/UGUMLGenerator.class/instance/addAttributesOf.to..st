public - importer
addAttributesOf: realClass to: umlClass
	realClass instanceVariables
		do: [ :eachVariable | self addInstanceVariable: eachVariable to: umlClass ].
	realClass classVarNames
		do: [ :eachVariable | self addClassVariable: eachVariable to: umlClass ].
	realClass class instanceVariables
		do: [ :eachVariable | self addClassInstanceVariable: eachVariable to: umlClass ].
	(realClass superclass ~~ Object
		and: [ (umlClasses includesKey: realClass superclass) not ])
		ifTrue: [ self addAttributesOf: realClass superclass to: umlClass ]