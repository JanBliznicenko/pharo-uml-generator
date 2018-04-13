gt-inspector-extension
gtInspectorCollectionTypesIn: composite
	<gtInspectorPresentationOrder: 33>
	^ composite table
		title: [ 'collection types' ];
		display: [ self collectionTypeDictionary associations sorted ];
		column: 'variable' evaluated: [ :each | each key ];
		column: 'types' evaluated: [ :each | each value ];
		when: [ collectionTypeDictionary isNotNil ];
		send: #value