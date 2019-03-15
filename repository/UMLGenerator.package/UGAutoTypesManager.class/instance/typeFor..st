retrieving
typeFor: typePossibilities
	| ugClasses |
	ugClasses := typePossibilities asUGClasses
		reject: [ :each | each isRealClassCollection | (each realClass == Object) ].
	ugClasses ifEmpty: [ ^ UGClass for: Object ].
	^ UGClass for: (self commonSuperclassOf: ugClasses)