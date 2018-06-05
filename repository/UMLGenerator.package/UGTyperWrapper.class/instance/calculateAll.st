actions
calculateAll
	[ :job | 
	job current: 0.
	self typeDictionary.
	job increment.
	self methodTypeDictionary.
	job increment.
	self collectionTypeDictionary.
	job increment ] asJob
		title: 'Collecting type suggestions...';
		min: 0;
		max: 3;
		run