adding
umlMethodFrom: aMethod
	^ OPUMLOperation new
		name: (self methodNameFrom: aMethod selector);
		yourself