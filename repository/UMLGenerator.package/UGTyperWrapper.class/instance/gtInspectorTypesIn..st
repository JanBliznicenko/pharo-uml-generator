gt-inspector-extension
gtInspectorTypesIn: composite
	<gtInspectorPresentationOrder: 32>
	^ composite table
		title: [ 'types' ];
		display: [ self typeDictionary associations sorted ];
		column: 'variable' evaluated: [ :each | each key ];
		column: 'types' evaluated: [ :each | each value ];
		when: [ typeDictionary isNotNil ];
		send: #value