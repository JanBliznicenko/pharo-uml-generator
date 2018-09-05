initialization
setTypeFieldWithoutEvents: aClassItem
	self ignoreEvents.
	self setTypeField: aClassItem.
	self allowEvents