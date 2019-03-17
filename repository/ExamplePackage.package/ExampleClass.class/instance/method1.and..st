accessing
method1: anArgument and: secondArgument
	| var3 |
	var1 := var2 ifNil: [ 1 ].
	var2 := anArgument.
	var3 := var1 * var2.
	var3 > 4
		ifTrue: [ ^ self ].
	var2 := var3 / secondArgument.
	^ var2
	