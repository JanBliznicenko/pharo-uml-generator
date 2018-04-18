instance creation
named: aString in: aClass
	^ self new
		itemName: aString;
		containingClass: aClass;
		yourself