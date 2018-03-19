generator - attribute
attributeTypeNameFor: aSymbol in: aClass
	(aClass includesSelector: aSymbol)
		ifTrue: [ (aClass >> aSymbol) pragmas
				detect: [ :each | each keyword = #UGType:multiplicity: | (each keyword = #UGType:) ]
				ifFound: [ :pragma | ^ pragma arguments first ] ].
	^ #Object