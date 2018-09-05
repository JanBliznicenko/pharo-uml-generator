adding
addParametersOf: aMethod to: umlMethod
	| ugMethod |
	ugMethod := UGMethod named: umlMethod name in: aMethod methodClass.
	aMethod argumentNames
		do: [ :each | 
			self
				addParameter: (UGInputMethodParameter named: each in: ugMethod)
				to: umlMethod ].
	self addParameter: (UGReturnParameter in: ugMethod) to: umlMethod