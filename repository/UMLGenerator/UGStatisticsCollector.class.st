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
	runtimeBlock := [ self executeAllCodeOf: aPackagesPattern ].

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
	[ :job |
	job title: 'Collecting statistics - preparing metalinks'.

	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	aPackageName asPackage recompileAndIncludeTraitMethods.

	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: aPackageName.

	job current: 5.
	job title: 'Collecting statistics - punning executable code'.

	"this is the time to run tests/scenarios to log types"
	testingTime := Time microsecondsToRun: aBlock.

	job current: 30.
	job title: 'Collecting statistics - uninstalling metalinks'.

	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.

	"executing the main part and saving into a stream"
	collectorForVariables := self new.
	collectorForVariables
		variablesOnly;
		packageName: aPackageName.

	collectorForAll := self new.
	collectorForAll packageName: aPackageName.

	job current: 35.
	job title: 'Collecting statistics - for all items'.

	collectorForAll latexTableRowWithCountsTo: countsStream.

	job current: 70.
	job title: 'Collecting statistics - for variables only'.

	collectorForVariables latexTableRowWithCountsTo: variableCountsStream.

	job current: 95.
	job title: 'Collecting statistics - printing resulting times'.

	collectorForVariables addTimeToRealTime: testingTime.
	collectorForVariables latexTableRowWithTimesTo: timesStream ] asJob
		title: 'Collecting statistics';
		run
]

{ #category : #example }
UGStatisticsCollector class >> exampleMultipleAutomated [

	'tableOfVariableCounts.tex' asFileReference
		ensureDelete;
		writeStreamDo: [ :variableCountsStream |
			'tableOfAllCounts.tex' asFileReference
				ensureDelete;
				writeStreamDo: [ :countsStream |
					'tableOfTimes.tex' asFileReference
						ensureDelete;
						writeStreamDo: [ :timesStream |
							| packagePairs |
							packagePairs := {
								                ('Fuel-Core' -> '.*Fuel.*').
								                ('Metacello-Core' -> '.*Metacello.*').
								                ('Monticello' -> '.*Monticello.*').
								                ('Commander2' -> '.*Commander2.*').
								                ('Tool-Diff' -> '.*Tool-Diff.*').
								                ('XML-Parser' -> '.*XML.*').
								                ('Zinc-HTTP' -> '.*Zinc.*').
								                ('Athens-Cairo' -> '.*Athens.*').
								                ('TraitsV2' -> '.*TraitsV2.*').
								                ('ProfilerUI' -> '.*ProfilerUI.*').
								                ('OSWindow-Core' -> '.*OSWindow.*') }.
							[ :job |
							packagePairs withIndexDo: [ :eachPair :index |
									job current: index - 1.
									job title: 'Running statistics collectors on ' , eachPair key.
									self
										collectPackage: eachPair key
										relevantPackagesPattern: eachPair value
										variableCountsStream: variableCountsStream
										countsStream: countsStream
										timesStream: timesStream.
									variableCountsStream flush.
									countsStream flush.
									timesStream flush ] ] asJob
								min: 0;
								max: packagePairs size;
								title: 'Running statistics collectors';
								run ];
						readStreamDo: [ :s | s upToEnd inspect ] ];
				readStreamDo: [ :s | s upToEnd inspect ] ];
		readStreamDo: [ :s | s upToEnd inspect ]
]

{ #category : #example }
UGStatisticsCollector class >> exampleRoassalAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'Roassal3'
			 relevantPackagesPattern: '.*Roassal3.*'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s ]) inspect
]

{ #category : #example }
UGStatisticsCollector class >> exampleXMLParserAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'XML-Parser'
			 relevantPackagesPattern: '.*XML.*'
			 variableCountsStream: s
			 countsStream: s
			 timesStream: s ]) inspect
]

{ #category : #example }
UGStatisticsCollector class >> exampleZincAutomated [

	(String streamContents: [ :s |
		 self
			 collectPackage: 'Zinc-HTTP'
			 relevantPackagesPattern: '.*Zinc.*'
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

{ #category : #example }
UGStatisticsCollector class >> executeAllCodeOf: aPackagesPattern [

	| originalWindows |
	originalWindows := Smalltalk currentWorld systemWindows asSet.
	self executeExamplesOf: aPackagesPattern.
	self executeTestsOf: aPackagesPattern.
	(Smalltalk currentWorld systemWindows asSet difference:
		 originalWindows) do: #delete
]

{ #category : #example }
UGStatisticsCollector class >> executeExamplesOf: aPackagesPattern [

	| exampleMethods excludedMethods |
	excludedMethods := { (RSLayout class >> #exampleBasic) }.
	exampleMethods := (RPackage organizer packages select: [ :eachPackage |
		                   eachPackage name matchesRegex: aPackagesPattern ])
		                  flatCollect: [ :eachPackage |
			                  eachPackage definedClasses flatCollect: [
				                  :eachClass |
				                  (eachClass class methods difference:
					                   excludedMethods) select: [ :any |
					                  any ~= excludedMethods and: [
						                  any numArgs = 0 and: [
							                  any selector beginsWith: 'example' ] ] ] ] ].
	[ :job |
	exampleMethods withIndexDo: [ :each :index |
			job current: index - 1.
			job title: 'Executing example ' , index asString , ' / '
					, exampleMethods size asString.

			each
				valueWithReceiver: each classBinding value instanceSide
				arguments: #(  ) ] ] asJob
		min: 0;
		max: exampleMethods size;
		title: 'Executing examples';
		run.
	exampleMethods ifNotEmpty: [
		self inform:
			'Executed ' , exampleMethods size asString , ' examples' ]
]

{ #category : #example }
UGStatisticsCollector class >> executeTestsOf: aPackagesPattern [

	| packages testClass |
	packages := RPackage organizer packages select: [ :eachPackage |
		            eachPackage name matchesRegex: aPackagesPattern ].
	packages ifEmpty: [
		self error: 'There is no package matching ' , aPackagesPattern ].
	testClass := TestRunner new baseClass.
	(packages anySatisfy: [ :anyPackage |
		 anyPackage definedClasses anySatisfy: [ :anyClass |
			 anyClass inheritsFrom: testClass ] ]) ifFalse: [
		self inform:
			'There are no tests in packages matching ' , aPackagesPattern.
		^ self ].

	self inform: (TestRunner new
			 packageSearchUpdate: aPackagesPattern;
			 selectAllPackages;
			 runAll;
			 result) asString
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
			job current: index - 1.
			job title: 'Running type inferer ' , index asString , ' / '
					, inferers size asString , ' - ' , pair key.
			self calculateTyper: pair value named: pair key ] ] asJob
		title: 'Running type inferers';
		min: 0;
		max: inferers size;
		run
]

{ #category : #converting }
UGStatisticsCollector >> calculateTyper: aTyperAdaptor named: aTyperName [

	| typesManager typesFinalizer generator |
	typesManager := UGTypesManager new.
	typesManager typerAdaptor: aTyperAdaptor.
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
	s lf.
	s << '\Xhline{0.5\arrayrulewidth}'.
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
	s << ' \\'.
	s lf.
	s << '\Xhline{0.5\arrayrulewidth}'.
	s lf
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
