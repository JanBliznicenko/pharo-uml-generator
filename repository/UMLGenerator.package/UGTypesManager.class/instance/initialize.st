initialization
initialize
	super initialize.
	blockForVariable := [ :variable | UIManager default request: 'Type of variable ' , variable asString initialAnswer: 'Object' ]