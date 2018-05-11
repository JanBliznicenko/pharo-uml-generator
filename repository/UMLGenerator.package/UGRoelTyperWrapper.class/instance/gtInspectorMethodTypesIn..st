gt-inspector-extension
gtInspectorMethodTypesIn: composite
	<gtInspectorPresentationOrder: 31>
	^ composite table
		title: [ 'method types' ];
		display: [ self methodTypeDictionary associations sorted ];
		column: 'variable' evaluated: [ :each | each key ];
		column: 'types' evaluated: [ :each | each value ];
		when: [ methodTypeDictionary isNotNil ]