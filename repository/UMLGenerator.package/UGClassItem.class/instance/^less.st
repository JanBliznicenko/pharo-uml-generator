comparing
< anotherItem
	containingClass package = anotherItem containingClass package
		ifFalse: [ ^ containingClass package name < anotherItem containingClass package name ].
	containingClass = anotherItem containingClass
		ifFalse: [ ^ containingClass name < anotherItem containingClass name ].
	^ variableName < anotherItem itemName