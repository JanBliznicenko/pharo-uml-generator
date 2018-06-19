initialization
setTypeFieldWithoutEvents: aString
	self ignoreEvents.
	typeField text: aString.
	self allowEvents