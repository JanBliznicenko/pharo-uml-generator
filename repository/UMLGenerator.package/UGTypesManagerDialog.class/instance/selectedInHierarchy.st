actions
selectedInHierarchy
	ignoreEvents
		ifTrue: [ ^ self ].
	hierarchyList selectedItem ifNil: [ ^ self ].
	self setTypeFieldWithoutEvents: hierarchyList selectedItem.
	selectedType := hierarchyList selectedItem