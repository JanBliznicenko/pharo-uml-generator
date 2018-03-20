public - importer
umlPackageOf: aClass
	| package |
	package := aClass package.
	^ model packagedElements
		detect: [ :any | any name = package name ]
		ifNone: [ self addPackage: package ]