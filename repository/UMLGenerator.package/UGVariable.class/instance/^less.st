comparing
< anotherVariable
	containingClass package = anotherVariable containingClass package
		ifFalse: [ ^ containingClass package name < anotherVariable containingClass package name ].
	containingClass = anotherVariable containingClass
		ifFalse: [ ^ containingClass name < anotherVariable containingClass name ].
	^ variableName < anotherVariable variableName