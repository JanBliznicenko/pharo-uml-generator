adding
addClass: aClass
	| umlPackage umlClass |
	umlPackage := self umlPackageOf: aClass.
	umlClass := OPUMLClass new name: aClass name.
	umlPackage packagedElements add: umlClass.
	umlClasses at: aClass put: umlClass.
	^ umlClass