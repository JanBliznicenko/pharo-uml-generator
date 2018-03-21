public - importer
umlPackageOf: aClass
	"for now, there are no packages - all elements added to the same model"
	
	^ model
	"| package |
	
	package := aClass package.
	^ model packagedElements
		detect: [ :any | any name = package name ]
		ifNone: [ self addPackage: package ]"