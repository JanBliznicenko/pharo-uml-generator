adding
addParametersOf: aMethod to: umlMethod
	aMethod argumentNames do: [ :each | self addParameter: each to: umlMethod ].
	self addReturnParameterTo: umlMethod