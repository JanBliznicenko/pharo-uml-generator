Class {
	#name : #UGStatisticsCollector,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'itemCount',
		'foundCounts',
		'variablesOnly',
		'times'
	],
	#category : #'UMLGenerator-Statistics'
}

{ #category : #example }
UGStatisticsCollector class >> collectPackage: aPackageName relevantPackagesPattern: aPackagesPattern variableCountsStream: variableCountsStream countsStream: countsStream timesStream: timesStream [

	| runtimeBlock |
	runtimeBlock := [
	                | exampleMethods |
	                exampleMethods := (RPackage organizer packages
		                                   select: [ :eachPackage |
		                                   eachPackage name matchesRegex:
			                                   aPackagesPattern ])
		                                  flatCollect: [ :eachPackage |
			                                  eachPackage classes flatCollect: [
				                                  :eachClass |
				                                  eachClass class methods select: [
					                                  :any |
					                                  any numArgs = 0 and: [
						                                  any selector beginsWith:
							                                  'example' ] ] ] ].
	                [ :job |
	                exampleMethods withIndexDo: [ :each :index |
			                job
				                current: index - 1 / exampleMethods size;
				                title:
					                'Executing example ' , index asString , ' / '
					                , exampleMethods size asString.

			                each
				                valueWithReceiver: each classBinding value
				                arguments: #(  ).
			                self inform: 'Executed ' , each asString ] ] asJob
		                title: 'Executing examples';
		                run.
	                self inform: (TestRunner new
			                 packageSearchUpdate: aPackagesPattern;
			                 selectAllPackages;
			                 runAll;
			                 result) asString ].

	self
		collectPackage: aPackageName
		variableCountsStream: variableCountsStream
		countsStream: countsStream
		timesStream: timesStream
		codeForRealTimeGathering: runtimeBlock
]

{ #category : #example }
UGStatisticsCollector class >> collectPackage: aPackageName variableCountsStream: variableCountsStream countsStream: countsStream timesStream: timesStream codeForRealTimeGathering: aBlock [
	"removes current metalinks (stops current types logging)"

	| collectorForVariables collectorForAll testingTime |
	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	aPackageName asPackage recompileAndIncludeTraitMethods.

	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: aPackageName.

	"this is the time to run tests/scenarios to log types"
	testingTime := Time microsecondsToRun: aBlock.

	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.

	"executing the main part and saving into a stream"
	collectorForVariables := self new.
	collectorForVariables
		variablesOnly;
		packageName: aPackageName.

	collectorForAll := self new.
	collectorForAll packageName: aPackageName.

	collectorForAll latexTableRowWithCountsTo: countsStream.
	collectorForVariables latexTableRowWithCountsTo: variableCountsStream.
	collectorForVariables addTimeToRealTime: testingTime.
	collectorForVariables latexTableRowWithTimesTo: timesStream
]

{ #category : #example }
UGStatisticsCollector class >> exampleRoassalAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'Roassal3'
			 relevantPackagesPattern: 'Roassal3'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s ]) inspect
]

{ #category : #example }
UGStatisticsCollector class >> exampleXMLParserAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'XML-Parser'
			 relevantPackagesPattern: 'XML'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s ]) inspect
]

{ #category : #example }
UGStatisticsCollector class >> exampleZincAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'Zinc-HTTP'
			 relevantPackagesPattern: 'Zinc'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s ]) inspect
]

{ #category : #example }
UGStatisticsCollector class >> exampleZincManual [

	| testingBlock |
	testingBlock := [
	                self notify:
		                'This is time to run tests/scenarios to log types for realtime type inferer.'
		                , String cr
		                , 'Run the tests/scenarios and then click Proceed' ].
	(String streamContents: [ :s |
		 self
			 collectPackage: 'Zinc-HTTP'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s
			 codeForRealTimeGathering: testingBlock ]) inspect
]

{ #category : #adding }
UGStatisticsCollector >> addTimeToRealTime: aTimeInMicroseconds [

	times at: #realtime ifPresent: [ :current |
		current ifNotNil: [ times at: #realtime put: current + aTimeInMicroseconds ] ].

	times at: #combined ifPresent: [ :current |
		current ifNotNil: [ times at: #combined put: current + aTimeInMicroseconds ] ]
]

{ #category : #converting }
UGStatisticsCollector >> calculate [

	| inferers |
	inferers := {
		            (#roel -> UGRoelTyperAdaptor new).
		            (#rb -> UGRBTyperAdaptor new).
		            (#j2 -> UGJ2InfererTyperAdaptor new).
		            (#realtime -> UGRealTimeTyperAdaptor new).
		            (#combined -> (UGTyperBackupsCombinator withAdaptors: {
				              UGRealTimeTyperAdaptor new.
				              UGRoelTyperAdaptor new.
				              UGRBTyperAdaptor new.
				              UGJ2InfererTyperAdaptor new })) }.
	[ :job |
	inferers withIndexDo: [ :pair :index |
			job title:
					'Running type inferer ' , index asString , ' / ' , inferers size asString
					, ' - ' , pair key.
			job current: index - 1 / inferers size.
			self calculateTyper: pair value named: pair key ] ] asJob
		title: 'Running type inferers';
		run
]

{ #category : #converting }
UGStatisticsCollector >> calculateTyper: aTyper named: aTyperName [

	| typesManager typerAdaptor typesFinalizer generator |
	typesManager := UGTypesManager withFile:
		                self packageName , (variablesOnly
			                 ifTrue: [ '-vars-' ]
			                 ifFalse: [ '-' ]) , aTyperName , '-types.ston'.
	typerAdaptor := aTyper.
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	variablesOnly ifTrue: [ typesManager skipMethods ].
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager:
		                  typesManager.
	generator := UGEnterpriseArchitectUMLGenerator new typesManager:
		             typesFinalizer.
	generator startTimeMeasuring.
	generator importFromPackagesNamed: { self packageName }.
	foundCounts
		at: aTyperName
		put: (typesManager knownTypes associations count: [ :each |
				 each value realClass ~= Object or: [
					 each value isCollectionClass ] ]).
	times at: aTyperName put: typesFinalizer measuredTime.
	itemCount
		ifNil: [ itemCount := typesManager knownTypes size ]
		ifNotNil: [
			itemCount ~= typesManager knownTypes size ifTrue: [
				self error: 'ItemCount varies across typers' ] ]
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
	foundCounts := OrderedDictionary new.
	times := OrderedDictionary new
]

{ #category : #converting }
UGStatisticsCollector >> itemCount [
	itemCount ifNil: [ self calculate ].
	^ itemCount
]

{ #category : #converting }
UGStatisticsCollector >> latexTableRowWithCounts [

	^ String streamContents: [ :s | self latexTableRowWithCountsTo: s ]
]

{ #category : #converting }
UGStatisticsCollector >> latexTableRowWithCountsTo: s [

	s << self packageName << ' & ' << self itemCount asString.
	self foundCountsDo: [ :each |
		| percentage |
		s << ' & ' << each asString << ' ('.
		percentage := each * 100 / self itemCount.
		percentage < 1.0
			ifTrue: [ s << '$<$1' ]
			ifFalse: [ percentage printOn: s showingDecimalPlaces: 0 ].
		s << ' \%)' ].
	s << ' \\'.
	s lf
]

{ #category : #converting }
UGStatisticsCollector >> latexTableRowWithTimes [

	^ String streamContents: [ :s | self latexTableRowWithTimesTo: s ]
]

{ #category : #converting }
UGStatisticsCollector >> latexTableRowWithTimesTo: s [

	s << self packageName << ' & ' << self itemCount asString.
	self timesDo: [ :each |
		s << ' & '.
		each ifNil: [ s << '!!! unknown !!!' ] ifNotNil: [ :time |
			| ms |
			ms := time / 1000.
			ms < 1.0
				ifTrue: [ s << '$<$1' ]
				ifFalse: [ ms printOn: s showingDecimalPlaces: 0 ] ].
		s << ' ms' ].
	s << ' \\'
]

{ #category : #converting }
UGStatisticsCollector >> packageName [
	^ packageName
]

{ #category : #accessing }
UGStatisticsCollector >> packageName: aString [ 
	packageName := aString
]

{ #category : #converting }
UGStatisticsCollector >> timesDo: aBlock [

	times ifNil: [ self calculate ].
	^ times do: aBlock
]

{ #category : #accessing }
UGStatisticsCollector >> variablesOnly [
	variablesOnly := true
]
