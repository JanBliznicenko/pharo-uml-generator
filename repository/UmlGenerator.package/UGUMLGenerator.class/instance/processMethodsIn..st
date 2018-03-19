as yet unclassified
processMethodsIn: aClass
	(aClass methods
		select: [ :each | each name = 'initialize' ])
		do: [ :each | 
			each removeFromModel.
			aClass methods remove: each ].
	aClass methods
		do: [ :each | 
			each compiledMethod pragmas
				detect: [ :pragma | pragma keyword = 'UGMethod:' ]
				ifFound: [ :pragma | 
					| parsed |
					parsed := self halt new method: pragma arguments first.
					each parameters: parsed parameters asArray
					"each declaredType: parsed declaredType."
					"each multiplicity: parsed multiplicity" ] ]