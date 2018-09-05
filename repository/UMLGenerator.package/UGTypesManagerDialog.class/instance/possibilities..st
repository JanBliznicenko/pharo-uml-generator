retrieving
possibilities: aPossibilities
	typePossibilities := aPossibilities.
	self
		title: 'Type manager for ' , aPossibilities item kindName , ' ' , aPossibilities item asString.
	optionsList items: typePossibilities asUGClasses.
	aPossibilities size = 1
		ifTrue: [ optionsList setIndex: 1 ].
	accessesModel
		messages:
			(SystemNavigation default
				allAccessesTo: aPossibilities item itemName
				from: aPossibilities item containingClass);
		autoSelect: aPossibilities item itemName