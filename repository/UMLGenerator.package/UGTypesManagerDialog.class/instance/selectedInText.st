actions
selectedInText
	ignoreEvents
		ifTrue: [ ^ self ].
	selectedType := UGClass for: typeField text asClass