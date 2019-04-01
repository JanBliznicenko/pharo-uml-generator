comparing
= anotherItem
	^ (anotherItem respondsTo: #method)
		and: [ method = anotherItem method and: [ super = anotherItem ] ]