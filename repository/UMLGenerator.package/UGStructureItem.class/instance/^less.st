comparing
< anotherItem
	^ self class asString < anotherItem class asString
		or: [ self itemName < anotherItem itemName ]