adding
addSuperclassOf: aClass
	| superClass |
	superClass := aClass superclass.
	(self rootClasses includes: superClass)
		ifTrue: [ ^ self ].
	^ umlClasses at: superClass ifAbsent: [ self addClass: superClass ]