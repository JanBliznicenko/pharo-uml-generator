adding
addClass: aClass
	| umlPackage umlClass |
	(aClass isMeta and: [ (umlClasses includesKey: aClass soleInstance) not ])
		ifTrue: [ ^ self addClass: aClass soleInstance ].
	umlPackage := self umlPackageOf: aClass.
	umlClass := OPUMLClass new name: aClass name.
	umlPackage packagedElements add: umlClass.
	umlClasses at: aClass put: umlClass.
	^ umlClass