instance creation
named: aString in: aMethod
	^ self new
		itemName: aString;
		method: aMethod;
		yourself