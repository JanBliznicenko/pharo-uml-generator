Class {
	#name : #UGStatisticsCollector,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'itemCount',
		'foundCounts',
		'variablesOnly'
	],
	#category : #'UMLGenerator-Statistics'
}

{ #category : #example }
UGStatisticsCollector class >> example [

	| packageName |
	packageName := 'Zinc-HTTP'.

	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	packageName asPackage classes do: #recompile.

	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: packageName.

	"this is the time to run tests/scenarios to log types"
	self notify:
		'This is time to run tests/scenarios to log types for realtime type inferer.'
		, String cr , 'Run the tests/scenarios and then click Proceed'.

	"save types into following file"
	(UGStatisticsCollector new
		 variablesOnly;
		 packageName: packageName;
		 asLatexTables) , String lf , 
	(UGStatisticsCollector new
		 packageName: packageName;
		 asLatexTables).

	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	packageName asPackage classes do: #recompile.
]

{ #category : #converting }
UGStatisticsCollector >> asLatexTables [
	^ String
		streamContents: [ :s | 
			s << self packageName << ' & ' << self itemCount asString.
			self
				foundCountsDo: [ :each | 
					s << ' & ' << each asString << ' ('.
					each * 100 / self itemCount printOn: s showingDecimalPlaces: 1.
					s << ' \%)' ].
			s << ' \\' ]
]

{ #category : #converting }
UGStatisticsCollector >> calculate [
	{(#roel -> UGRoelTyperAdaptor new).
	(#rb -> UGRBTyperAdaptor new).
	(#j2 -> UGJ2InfererTyperAdaptor new).
	(#realtime -> UGRealTimeTyperAdaptor new).
	(#combined
		->
			(UGTyperBackupsCombinator
				withAdaptors:
					{UGRealTimeTyperAdaptor new.
					UGRoelTyperAdaptor new.
					UGRBTyperAdaptor new.
					UGJ2InfererTyperAdaptor new}))}
		do: [ :pair | self calculateTyper: pair value named: pair key ]
]

{ #category : #converting }
UGStatisticsCollector >> calculateTyper: aTyper named: aTyperName [
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
]

{ #category : #converting }
UGStatisticsCollector >> foundCountsDo: aBlock [
	foundCounts ifNil: [ self calculate ].
	^ foundCounts do: aBlock
]

{ #category : #initialization }
UGStatisticsCollector >> initialize [
	super initialize.
	variablesOnly := false.
	foundCounts := OrderedCollection new
]

{ #category : #converting }
UGStatisticsCollector >> itemCount [
	itemCount ifNil: [ self calculate ].
	^ itemCount
]

{ #category : #converting }
UGStatisticsCollector >> packageName [
	^ packageName
]

{ #category : #accessing }
UGStatisticsCollector >> packageName: aString [ 
	packageName := aString
]

{ #category : #accessing }
UGStatisticsCollector >> variablesOnly [
	variablesOnly := true
]
