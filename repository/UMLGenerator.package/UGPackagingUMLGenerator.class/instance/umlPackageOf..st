public - importer
umlPackageOf: aClass
	| package |
	package := aClass package.
	^ encompassingPackage packagedElements
		detect: [ :any | (any isKindOf: OPUMLPackage) and: [ any name = package name ] ]
		ifNone: [ self addPackage: package ]