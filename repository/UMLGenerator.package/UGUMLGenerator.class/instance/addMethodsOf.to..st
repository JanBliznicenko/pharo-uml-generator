public - importer
addMethodsOf: realClass to: umlClass
	realClass methods do: [ :eachMethod | self addMethod: eachMethod to: umlClass ].
	((self rootClasses includes: realClass superclass)
		or: [ umlClasses includesKey: realClass superclass ])
		ifFalse: [ self addMethodsOf: realClass superclass to: umlClass ]