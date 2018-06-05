private
createVarTypeDictionary
	| rawTypes |
	^ [ :job | 
	job current: 0.
	rawTypes := self createRawVarTypeDictionary.
	job increment.
	self filterTypeDictionary: rawTypes ] asJob
		title: 'Collecting types of variables...';
		min: 0;
		max: 2;
		run