instance creation
open
	self openDialogWithSpec.
	self window
		okAction: [ self checkSelectedType ];
		cancelAction: [ self deselect ];
		maximize;
		modalRelativeTo: self currentWorld.
	^ self