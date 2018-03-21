public - importer
umlPackageOf: aClass
	| package |
	packaging
		ifFalse: [ ^ model ].	"if packaging is turned off, add everything to single model without any intermediate package"
	package := aClass package.
	^ model packagedElements
		detect: [ :any | any name = package name ]
		ifNone: [ self addPackage: package ]