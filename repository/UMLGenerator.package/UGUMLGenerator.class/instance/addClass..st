adding
addClass: aClass
	| umlPackage umlClass |
	umlPackage := self umlPackageOf: aClass.
	umlClass := OPUMLClass new name: aClass name.
	umlPackage packagedElements: umlPackage packagedElements , {umlClass}