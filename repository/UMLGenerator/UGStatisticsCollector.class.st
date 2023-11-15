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
UGStatisticsCollector class >> collectPackage: aPackageName relevantPackagesPattern: aPackagesPattern variableCountsStream: variableCountsStream countsStream: countsStream timesStream: timesStream coverageStream: coverageStream [
	"removes current metalinks (stops current types logging)"

	| collectorForVariables collectorForAll testingTime originalWindows testCoverage examples package |
	package := aPackageName asPackage.
	[ :job |
	job title: 'Collecting statistics - preparing metalinks'.

	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	package recompileAndIncludeTraitMethods.

	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: aPackageName.

	job current: 5.
	job title: 'Collecting statistics - running executable code'.

	"this is the time to run tests/scenarios to log types"
	originalWindows := Smalltalk currentWorld systemWindows asSet.

	examples := 0.
	testCoverage := 0.

	testingTime := Time microsecondsToRun: [
			               examples := self executeExamplesOf: aPackagesPattern.

			               testCoverage := self
				                               executeTestsOf: aPackagesPattern
				                               for: package ].

	(Smalltalk currentWorld systemWindows asSet difference:
			 originalWindows) do: #delete.
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
	job title: 'Collecting statistics - for variables only'.

	collectorForVariables latexTableRowWithCountsTo: variableCountsStream.
	variableCountsStream flush.

	job current: 55.
	job title: 'Collecting statistics - printing coverage and times'.

	collectorForVariables addTimeToRealTime: testingTime.
	collectorForVariables latexTableRowWithTimesTo: timesStream.
	timesStream flush.
	collectorForVariables
		latexTableRowWithCoverage: testCoverage
		examples: examples
		to: coverageStream.
	coverageStream flush.

	job current: 60.
	job title: 'Collecting statistics - for all items'.

	collectorForAll latexTableRowWithCountsTo: countsStream.
	countsStream flush ] asJob
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
							'tableOfCoverage.tex' asFileReference
								ensureDelete;
								writeStreamDo: [ :coverageStream |
									| packagePairs |
									packagePairs := {
										                ('Metacello-Core' -> '.*Metacello.*').
										                ('Fuel-Core' -> '.*Fuel.*').
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
											job title:
													'Running statistics collectors on ' , eachPair key.
											self
												collectPackage: eachPair key
												relevantPackagesPattern: eachPair value
												variableCountsStream: variableCountsStream
												countsStream: countsStream
												timesStream: timesStream
												coverageStream: coverageStream ] ] asJob
										min: 0;
										max: packagePairs size;
										title: 'Running statistics collectors';
										run ];
								readStreamDo: [ :s | s upToEnd inspect ] ];
						readStreamDo: [ :s | s upToEnd inspect ] ];
				readStreamDo: [ :s | s upToEnd inspect ] ];
		readStreamDo: [ :s | s upToEnd inspect ]
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
			'Executed ' , exampleMethods size asString , ' examples' ].
	^ exampleMethods size
]

{ #category : #example }
UGStatisticsCollector class >> executeTestsOf: aPackagesPattern for: aPackage [

	| packages testClass result methods runner collector coverage percentsOfCoverage |
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
		^ 0 ].

	methods := aPackage methods.

	runner := TestRunner new
		          packageSearchUpdate: aPackagesPattern;
		          selectAllPackages;
		          resetResult.

	collector := CoverageCollector new.
	collector methods: methods.
	coverage := collector runOn: [
		            runner runSuite: runner suiteForAllSelected ].

	percentsOfCoverage := 100
	                      -
	                      (100 * coverage uncoveredMethods size
	                       // methods size).

	result := runner result.

	self inform: 'Executed tests with coverage '
		, percentsOfCoverage asInteger asString , ' % for '
		, aPackagesPattern , ': ' , result asString , ''.

	^ percentsOfCoverage
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
UGStatisticsCollector >> latexTableRowWithCoverage: aCoverageInPercents examples: anAmountOfExamples to: s [

	s << self packageName << ' & ' << self itemCount asString << ' & '
	<< aCoverageInPercents asInteger asString << ' \% & '
	<< anAmountOfExamples asString.
	{
		(times at: #realtime).
		(times at: #combined) } do: [ :each |
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
