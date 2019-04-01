adding
addClasses: aClassesCollection
	focusedPackages
		ifEmpty: [ focusedPackages := aClassesCollection
				collect: [ :each | each package ]
				as: Set ].
	aClassesCollection do: [ :each | self addClass: each ].
	self addGeneralizations