retrieving
typeFor: typePossibilities
	| ugClasses |
	ugClasses := typePossibilities asUGClasses.
	typePossibilities isPossibleCollection
		ifTrue: [ ugClasses := ugClasses reject: [ :each | each isRealClassCollection ] ].
	ugClasses ifEmpty: [ ^ UGClass for: Object ].
	^ UGClass for: (self commonSuperclassOf: ugClasses)