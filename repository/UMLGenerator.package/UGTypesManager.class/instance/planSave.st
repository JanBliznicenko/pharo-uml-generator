persistence
planSave
	autoSave
		ifFalse: [ ^ self ].
	plannedSave
		ifTrue: [ ^ self ].
	plannedSave := true.
	[ 5 seconds wait.
	plannedSave := false.
	self save ] fork