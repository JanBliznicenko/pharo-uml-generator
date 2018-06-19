actions
updateHierarchyList
	selectedType := optionsList selectedItem.
	self ignoreEvents.
	typeField text: (selectedType ifNil: [ '' ] ifNotNil: [ selectedType itemName ]).
	hierarchyList
		items: (selectedType ifNil: [ #() ] ifNotNil: [ :item | item withAllSuperclasses ]).
	hierarchyList setSelectedIndex: hierarchyList listSize.
	self allowEvents