public - importer
addSuperclassOf: aClass
	| superClass |
	superClass := aClass superclass.
	(superClass == Object or: [ superClass == Object class ])
		ifTrue: [ ^ self ].
	^ umlClasses at: superClass ifAbsent: [ self addClass: superClass ]