accessing
inputParameters
	^ self compiledMethod argumentNames
		collect: [ :each | UGInputMethodParameter named: each in: self ]