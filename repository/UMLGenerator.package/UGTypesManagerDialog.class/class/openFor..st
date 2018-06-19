retrieving
openFor: typePossibilities
	| model window |
	model := self new.
	window := model
		possibilities: typePossibilities;
		openDialogWithSpec.
	window
		cancelAction: [ model deselect ];
		maximize;
		modalRelativeTo: self currentWorld.
	^ model