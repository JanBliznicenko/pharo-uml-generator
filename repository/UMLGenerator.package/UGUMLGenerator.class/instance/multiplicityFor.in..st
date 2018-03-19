generator - attribute
multiplicityFor: aSymbol in: aClass
	| pragma |
	(aClass includesSelector: aSymbol)
		ifFalse: [ OPUMLMultiplicityElement new ].
	pragma := (aClass >> aSymbol) pragmas
		detect: [ :each | each keyword = #UGType:multiplicity: ]
		ifNone: [ OPUMLMultiplicityElement new ].
	^ OPUMLMultiplicityElement new
		lowerValue: (self lowerBoundFor: pragma);
		upperValue: (self upperBoundFor: pragma);
		yourself