scripts
inferAllInstalation
	" J2Scripts inferAllInstalation"

	J2Inferer resetInstance.
	Smalltalk garbageCollect.
	J2Inferer default.

	ProtoObject withAllSubclasses
		do: [ :e | J2Inferer instance enqueueClass: e ]
		displayingProgress: [ :e | e name ].
		
	J2Inferer instance runAndWait.
	
	^ J2Inferer instance