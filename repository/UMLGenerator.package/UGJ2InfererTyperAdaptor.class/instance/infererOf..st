private
infererOf: aPackage
	^ inferers
		at: aPackage
		ifAbsentPut: [ | inferer |
			inferer := J2Inferer withNotifier: J2NullNotifier new.
			aPackage classes
				reject: [ :each | each isTrait ]
				thenDo: [ :e | inferer enqueueClass: e ].
			inferer runAndWait.
			inferer ]