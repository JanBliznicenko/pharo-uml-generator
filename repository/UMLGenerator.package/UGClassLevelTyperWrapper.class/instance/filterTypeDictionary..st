private
filterTypeDictionary: aDictionary
	| invalidClasses replacements |
	invalidClasses := self class invalidClasses.
	replacements := self class replacements.
	^ aDictionary
		collect: [ :eachTypes | 
			eachTypes
				reject: [ :each | invalidClasses includes: each ]
				thenCollect: [ :each | replacements at: each ifAbsent: [ each ] ] ]