instance creation
named: aString in: aClass
	^ self new
		variableName: aString;
		containingClass: aClass;
		yourself