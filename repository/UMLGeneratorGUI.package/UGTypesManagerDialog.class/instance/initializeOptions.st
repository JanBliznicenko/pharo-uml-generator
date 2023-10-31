initialization
initializeOptions
	optionsList := self instantiate: ListModel.
	optionsList displayBlock: [ :each | each asString ].
	optionsList whenSelectionChanged: [ :item | self updateHierarchyList ]