private
infererOf: aPackage
	^ inferers
		at: aPackage
		ifAbsentPut: [ | inferer |
			inferer := J2Inferer withNotifier: J2NullNotifier new.
			aPackage classes
				do: [ :e | inferer enqueueClass: e ]
				displayingProgress: [ :e | e name ].
			inferer runAndWait.
			inferer ]