private
umlPackageOf: aClass
	| package tag packages umlPackage |
	package := aClass package.
	tag := package classTagForClass: aClass.
	packages := encompassingPackage packagedElements
		select: [ :each | each isKindOf: OPUMLPackage ].
	umlPackage := packages
		detect: [ :any | self isPackageNamed: package name equalTo: any ]
		ifNone: [ self addPackage: package ].
	tag isRoot
		ifTrue: [ ^ umlPackage ].
	^ umlPackage packagedElements
		detect: [ :any | self isPackageNamed: tag name equalTo: any ]
		ifNone: [ self addTag: tag to: umlPackage ]