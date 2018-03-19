generator - method
methodParametersFor: aSelector in: aClass
	| parameters returnParameter |
	parameters := (aClass >> aSelector) argumentNames
		collect: [ :each | OPUMLParameter new name: each ].
	returnParameter := OPUMLParameter new
		name: 'return';
		direction: OPUMLParameterDirectionKind return.
	^ parameters , {returnParameter}