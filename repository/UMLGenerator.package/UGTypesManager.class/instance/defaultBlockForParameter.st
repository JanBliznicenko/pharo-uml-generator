initialization
defaultBlockForParameter
	^ blockForParameter := [ :typeRequest | 
	UIManager default
		request: 'Type of parameter ' , typeRequest item asString
		initialAnswer: 'Object' ]