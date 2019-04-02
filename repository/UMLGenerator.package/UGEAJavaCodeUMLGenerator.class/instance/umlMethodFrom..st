adding
umlMethodFrom: aMethod
	^ (super umlMethodFrom: aMethod)
		name: (self methodNameFrom: aMethod selector);
		yourself