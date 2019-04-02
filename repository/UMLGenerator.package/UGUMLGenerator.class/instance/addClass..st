adding
addClass: aClass
	| umlPackage umlClass |
	umlClasses at: aClass ifPresent: [ :existingUmlClass | ^ umlClasses at: aClass ].
	aClass isTrait
		ifTrue: [ ^ self ].
	aClass isMeta
		ifTrue: [ ^ self addClass: Class ].
	self flag: #todo.	"traits are ignored"
	umlPackage := self umlPackageOf: aClass.
	umlClass := self umlClassFrom: aClass.
	umlPackage packagedElements add: umlClass.
	umlClasses at: aClass put: umlClass.
	(focusedPackages includes: aClass package)
		ifFalse: [ ^ umlClass ].
	self addSuperclassOf: aClass.
	(aClass class methods isNotEmpty or: [ aClass class instanceVariables isNotEmpty ])
		ifTrue: [ self addClass: aClass class ].
	self addVariablesOf: aClass.
	self addMethodsOf: aClass.
	self addedClass: aClass.
	^ umlClass