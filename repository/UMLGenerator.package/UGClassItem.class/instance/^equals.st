comparing
= anotherItem
	^ (anotherItem respondsTo: #containingClass) and: [ containingClass = anotherItem containingClass and: [ super = anotherItem ] ]