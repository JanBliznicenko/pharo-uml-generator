gt-inspector-extension
gtInspectorSimpleTypesIn: composite
	<gtInspectorPresentationOrder: 31>
	^ composite table
		title: [ 'simple types' ];
		display: [ self simpleTypeDictionary associations sorted ];
		column: 'variable' evaluated: [ :each | each key ];
		column: 'types' evaluated: [ :each | each value ];
		when: [ simpleTypeDictionary isNotNil ]