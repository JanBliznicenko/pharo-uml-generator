initialization
defaultBlockForVariable
	^ blockForVariable := [ :typeRequest | 
	UIManager default
		request: 'Type of variable ' , typeRequest item asString
		initialAnswer: 'Object' ]