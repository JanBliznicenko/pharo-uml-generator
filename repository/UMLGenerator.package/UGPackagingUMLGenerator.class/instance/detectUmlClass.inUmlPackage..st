private
detectUmlClass: aUmlClass inUmlPackage: aUmlPackage
	| packagedElements |
	packagedElements := aUmlPackage packagedElements.
	(packagedElements includes: aUmlClass)
		ifTrue: [ ^ aUmlPackage ].
	^ (packagedElements
		select: [ :each | each isKindOf: OPUMLPackage ]
		thenCollect: [ :each | self detectUmlClass: aUmlClass inUmlPackage: each ]) detect: [ :any | any isNotNil ] ifNone: [ nil ]