adding
umlClassFrom: aClass
	^ OPUMLClass new
		name: aClass name;
		visibility: OPUMLVisibilityKind public;
		yourself