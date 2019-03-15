adding
addClass: aClass
	aClass isTrait
		ifTrue: [ ^ self ].
	self flag: #todo.	"traits are ignored"
	^ (super addClass: aClass)
		package: (self umlPackageOf: aClass);
		yourself