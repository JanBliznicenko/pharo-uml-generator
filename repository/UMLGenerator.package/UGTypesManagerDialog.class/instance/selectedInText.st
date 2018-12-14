actions
selectedInText
	| class |
	self markSelectedTypeOk.
	ignoreEvents
		ifTrue: [ ^ self ].
	class := typeField text asClass.
	selectedType := typeCollectionCheck state
		ifTrue: [ UGCollection for: class ]
		ifFalse: [ UGClass for: class ]