public - importer
umlPackageOf: aClass
	| package tag packages umlPackage |
	package := aClass package.
	tag := package classTagForClass: aClass.
	packages := encompassingPackage packagedElements
		select: [ :each | each isKindOf: OPUMLPackage ].
	umlPackage := packages
		detect: [ :any | any name = package name ]
		ifNone: [ self addPackage: package ].
	tag isRoot
		ifTrue: [ ^ umlPackage ].
	^ umlPackage packagedElements
		detect:
			[ :any | (any isKindOf: OPUMLPackage) and: [ any name = (package name , '-' , tag name) ] ]
		ifNone: [ self addTag: tag to: umlPackage ]