persistence
planSave
	autoSave
		ifFalse: [ ^ self ].
	plannedSave
		ifTrue: [ ^ self ].
	plannedSave := true.
	[ 10 seconds wait.
	plannedSave := false.
	self save ] fork