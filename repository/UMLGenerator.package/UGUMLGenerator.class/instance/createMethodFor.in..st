generator - method
createMethodFor: aSelector in: aClass
	(aClass >> aSelector) pragmas
		detect: [ :each | each keyword = #UGMethod: ]
		ifFound: [ :pragma | ^ factory method: pragma arguments first ].
	^ OPUMLOperation new
		name: aSelector;
		parameters: (self methodParametersFor: aSelector in: aClass)