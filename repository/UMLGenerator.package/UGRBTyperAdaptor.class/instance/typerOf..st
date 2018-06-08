private
typerOf: aClass
	^ typers at: aClass ifAbsentPut: [ RBRefactoryTyper new runOn: aClass ]