actions
checkSelectedType
	selectedType ifNotNil: [ ^ true ].
	self markSelectedTypeWrong.
	^ false