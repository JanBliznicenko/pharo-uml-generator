converting
calculateTyper: aTyper named: aTyperName
	| typesManager typerAdaptor typesFinalizer generator |
	typesManager := UGTypesManager
		withFile:
			self packageName
				,
					(variablesOnly
						ifTrue: [ '-vars-' ]
						ifFalse: [ '-' ]) , aTyperName , '-types.ston'.
	typerAdaptor := aTyper.
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	variablesOnly
		ifTrue: [ typesManager skipMethods ].
	typesFinalizer := UGAutoTypesManagerFinalizer new
		typesManager: typesManager.
	generator := UGEnterpriseArchitectUMLGenerator new
		typesManager: typesFinalizer.
	generator importFromPackagesNamed: {self packageName}.
	foundCounts
		add:
			(typesManager knownTypes associations
				count:
					[ :each | each value realClass ~= Object or: [ each value isCollectionClass ] ]).
	itemCount
		ifNil: [ itemCount := typesManager knownTypes size ]
		ifNotNil: [ itemCount ~= typesManager knownTypes size
				ifTrue: [ self error: 'ItemCount varies across typers' ] ]