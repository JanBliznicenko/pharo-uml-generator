public - importer
umlPackageOf: aClass
	| package |
	packaging
		ifFalse: [ ^ encompassingPackage ].	"if packaging is turned off, add everything to single model without any intermediate package"
	package := aClass package.
	^ encompassingPackage packagedElements
		detect: [ :any | (any isKindOf: OPUMLPackage) and: [ any name = package name ] ]
		ifNone: [ self addPackage: package ]