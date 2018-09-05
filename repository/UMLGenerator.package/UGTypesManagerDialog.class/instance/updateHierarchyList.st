actions
updateHierarchyList
	selectedType := optionsList selectedItem.
	self ignoreEvents.
	self setTypeField: selectedType.
	hierarchyList
		items: (selectedType ifNil: [ #() ] ifNotNil: [ :item | item withAllSuperclasses ]).
	hierarchyList setSelectedIndex: hierarchyList listSize.
	self allowEvents