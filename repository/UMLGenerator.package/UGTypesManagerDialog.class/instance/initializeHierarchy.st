initialization
initializeHierarchy
	hierarchyList := self instantiate: ListModel.
	hierarchyList displayBlock: [ :each | each asString ].
	hierarchyList whenSelectionChanged: [ :item | self selectedInHierarchy ]