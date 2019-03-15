adding
addClass: aClass
	| umlPackage umlClass |
	umlClasses
		at: aClass
		ifPresent: [ :existingUmlClass | ^ umlClasses at: aClass ].
	aClass isTrait
		ifTrue: [ ^ self ].
	self flag: #todo.	"traits are ignored"
	aClass isMeta
		ifTrue: [ ^ self addClass: aClass soleInstance ].
	umlPackage := self umlPackageOf: aClass.
	umlClass := self umlClassFrom: aClass.
	umlPackage packagedElements add: umlClass.
	umlClasses at: aClass put: umlClass.
	(focusedPackages includes: aClass package)
		ifFalse: [ ^ umlClass ].
	self addGeneralizationOf: aClass.
	self addVariablesOf: aClass.
	self addMethodsOf: aClass.
	^ umlClass