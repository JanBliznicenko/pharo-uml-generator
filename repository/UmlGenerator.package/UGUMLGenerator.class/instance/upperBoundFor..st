generator - attribute
upperBoundFor: aPragma
	aPragma arguments second
		ifNotEmpty: [ :range | 
			range size = 1
				ifTrue: [ range first = '*'
						ifTrue: [ ^ OPUMLLiteralUnlimitedNatural new value: '*' ]
						ifFalse: [ ^ range first ] ]
				ifFalse: [ range second = '*'
						ifTrue: [ ^ OPUMLLiteralUnlimitedNatural new value: '*' ]
						ifFalse: [ ^ range second ] ] ].
	^ 1