comparing
< anotherItem
	realClass package = anotherItem realClass package
		ifFalse: [ ^ realClass package name < anotherItem realClass package name ].
	realClass = anotherItem realClass
		ifFalse: [ ^ realClass name < anotherItem realClass name ].
	^ super < anotherItem