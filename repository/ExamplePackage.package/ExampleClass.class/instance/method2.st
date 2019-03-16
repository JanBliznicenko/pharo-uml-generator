accessing
method2
	| var3 |
	var1 := var2 ifNil: [ 1 ].
	var2 := 4.
	var3 := var1 * var2.
	var3 > 4
		ifTrue: [ ^ self ].
	var2 := var3 / 2.
	^ var2