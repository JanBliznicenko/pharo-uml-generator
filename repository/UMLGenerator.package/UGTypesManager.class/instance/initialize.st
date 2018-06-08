initialization
initialize
	super initialize.
	persistence := UGTypesNoPersistence new.
	blockForVariable := [ :typeRequest | 
	UIManager default
		request: 'Type of variable ' , typeRequest item asString
		initialAnswer: 'Object' ]