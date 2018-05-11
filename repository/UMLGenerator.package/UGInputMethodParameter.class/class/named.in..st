instance creation
named: aString in: aMethod
	^ self new
		method: aMethod;
		itemName: aString;
		yourself