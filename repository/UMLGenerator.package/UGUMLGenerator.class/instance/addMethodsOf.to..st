public - importer
addMethodsOf: realClass to: umlClass
	realClass methods do: [ :eachMethod | self addMethod: eachMethod to: umlClass ].
	realClass class methods do: [ :eachMethod | self addClassMethod: eachMethod to: umlClass ].
	(realClass superclass ~~ Object
		and: [ realClass superclass ~~ ProtoObject
				and: [ (umlClasses includesKey: realClass superclass) not ] ])
		ifTrue: [ self addMethodsOf: realClass superclass to: umlClass ]