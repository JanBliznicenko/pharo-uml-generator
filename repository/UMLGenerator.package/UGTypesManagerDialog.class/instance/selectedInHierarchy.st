actions
selectedInHierarchy
	ignoreEvents
		ifTrue: [ ^ self ].
	hierarchyList selectedItem ifNil: [ ^ self ].
	self setTypeFieldWithoutEvents: hierarchyList selectedItem itemName.
	selectedType := hierarchyList selectedItem