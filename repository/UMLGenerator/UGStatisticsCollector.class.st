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
UGStatisticsCollector class >> collectPackage: aPackageName relevantPackagesPattern: aPackagesPattern variableCountsStream: variableCountsStream countsStream: countsStream timesStream: timesStream coverageStream: coverageStream thenDo: finishedBlock [
	"removes current metalinks (stops current types logging)"

	| collectorForVariables collectorForAll testingTime testCoverage examples package |
	package := aPackageName asPackage.
	[ :job |
	job title: 'Collecting statistics - removing previous metalinks'.
	UGRealTimeTyper default uninstallLinks.

	"forces metalinks to be removed"
	job current: 1.
	job title: 'Collecting statistics - resetting typer'.
	UGRealTimeTyper resetDefault.

	job current: 2.
	job title: 'Collecting statistics - including trait methods'.
	package includeTraitMethods.

	"adds metalinks (starts logging types)"
	job current: 5.
	job title: 'Collecting statistics - inserting metalinks'.
	UGRealTimeTyper default addLinksToPackageNamed: aPackageName.

	job current: 10.
	job title: 'Collecting statistics - running executable code'.

	"this is the time to run tests/scenarios to log types"

	examples := 0.
	testCoverage := 0.

	Smalltalk garbageCollect.

	testingTime := Time microsecondsToRun: [
			               examples := self executeExamplesOf: aPackagesPattern.

			               testCoverage := self
				                               executeTestsOf: aPackagesPattern
				                               for: package ].
	self timeToCloseExamples wait.

	"removes current metalinks (stops current types logging)"
	job current: 30.
	job title: 'Collecting statistics - removing new metalinks'.
	UGRealTimeTyper default uninstallLinks.

	"executing the main part and saving into a stream"
	job current: 39.
	job title: 'Collecting statistics - preparing collectors'.
	collectorForVariables := self new.
	collectorForVariables
		variablesOnly;
		packageName: aPackageName.

	collectorForAll := self new.
	collectorForAll packageName: aPackageName.

	job current: 40.
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
		run.

	finishedBlock cull: collectorForVariables cull: collectorForAll
]

{ #category : #example }
UGStatisticsCollector class >> example [

	self examplePackages: (LinkedList withAll: {
				 ('Athens-Cairo' -> '.*Athens.*|.*Roassal.*').
				 ('Commander2' -> '.*Commander2.*').
				 ('Metacello-Core' -> '.*Metacello.*').
				 ('OSWindow-Core' -> '.*OSWindow.*').
				 ('ProfilerUI' -> '.*ProfilerUI.*').
				 ('STON-Core' -> '.*STON.*').
				 ('Tool-Diff' -> '.*Tool-Diff.*').
				 ('XML-Parser' -> '.*XML.*|.*XMI.*|.*XPath.*').
				 ('Zinc-HTTP' -> '.*Zinc.*'). })
]

{ #category : #example }
UGStatisticsCollector class >> examplePackage: aPackageName relevantPackagesPattent: aPackagesPattern thenDo: aBlock [

	| dir fileNameExtensions |
	dir := 'C:\Users\Honza\OneDrive - České vysoké učení technické v Praze\PhD\COLA\results'
		       asFileReference.
	fileNameExtensions := '.'
	                      ,
	                      (aPackageName select: #isAlphaNumeric)
		                      asLowercase , '.tex'.
	[
	(dir / ('tableOfVariableCounts' , fileNameExtensions))
		ensureDelete;
		writeStreamDo: [ :variableCountsStream |
			(dir / ('tableOfAllCounts' , fileNameExtensions))
				ensureDelete;
				writeStreamDo: [ :countsStream |
					(dir / ('tableOfTimes' , fileNameExtensions))
						ensureDelete;
						writeStreamDo: [ :timesStream |
							(dir / ('tableOfCoverage' , fileNameExtensions))
								ensureDelete;
								writeStreamDo: [ :coverageStream |
									[ :job |
									self
										collectPackage: aPackageName
										relevantPackagesPattern: aPackagesPattern
										variableCountsStream: variableCountsStream
										countsStream: countsStream
										timesStream: timesStream
										coverageStream: coverageStream
										thenDo: aBlock ] asJob
										title: 'Running statistics collectors on ' , aPackageName;
										run ];
								readStreamDo: [ :s | s upToEnd inspect ] ];
						readStreamDo: [ :s | s upToEnd inspect ] ];
				readStreamDo: [ :s | s upToEnd inspect ] ];
		readStreamDo: [ :s | s upToEnd inspect ] ]
		forkAt: Processor userBackgroundPriority
		named: 'UG Statistics Collector'
]

{ #category : #example }
UGStatisticsCollector class >> examplePackages: aSequenceableCollection [

	self
		examplePackage: aSequenceableCollection first key
		relevantPackagesPattent: aSequenceableCollection first value
		thenDo: [
			aSequenceableCollection size > 1 ifTrue: [
				self examplePackages: aSequenceableCollection copyWithoutFirst ] ]
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
			| originalWindows windowsToDelete |
			job current: index - 1.
			job title: 'Executing example ' , index asString , ' / '
					, exampleMethods size asString.

			originalWindows := Smalltalk currentWorld systemWindows asSet.
			each
				valueWithReceiver: each classBinding value instanceSide
				arguments: #(  ).
			windowsToDelete := Smalltalk currentWorld systemWindows asSet
				                   difference: originalWindows.
			[
			self timeToCloseExamples wait.
			windowsToDelete do: #delete ]
				forkAt: Processor userSchedulingPriority
				named: 'UGStatisticts collection windows deletion' ] ] asJob
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

	| packages testClass result methods runner collector coverage percentsOfCoverage originalWindows |
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

	originalWindows := Smalltalk currentWorld systemWindows asSet.
	coverage := collector runOn: [
		            runner runSuite: runner suiteForAllSelected ].
	(Smalltalk currentWorld systemWindows asSet difference:
		 originalWindows) do: #delete.

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

{ #category : #constants }
UGStatisticsCollector class >> timeToCloseExamples [

	^ 8 seconds
]

{ #category : #adding }
UGStatisticsCollector >> addTimeToRealTime: aTimeInMicroseconds [

	times keys
		select: [ :each |
			(each beginsWith: 'realtime') or: [
				(each beginsWith: 'chain') or: [ each beginsWith: 'major' ] ] ]
		thenDo: [ :eachKey |
			| current |
			current := times at: eachKey.
			current ifNotNil: [
				times at: eachKey put: current + aTimeInMicroseconds ] ]
]

{ #category : #converting }
UGStatisticsCollector >> calculate [

	| inferers |
	inferers := {
		            (#roel -> UGRoelTyperAdaptor new).
		            (#rb -> UGRBTyperAdaptor new).
		            (#j2 -> UGJ2InfererTyperAdaptor new).
		            (#realtime -> UGRealTimeTyperAdaptor new).
		            (#chainedReRoRbJ
		             -> (UGTyperChainingCombinator withAdaptors: {
					              UGRealTimeTyperAdaptor new.
					              UGRoelTyperAdaptor new.
					              UGRBTyperAdaptor new.
					              UGJ2InfererTyperAdaptor new })).
		            (#majority
		             -> (UGTyperMajorityCombinator withAdaptors: {
					              UGRoelTyperAdaptor new.
					              UGRBTyperAdaptor new.
					              UGJ2InfererTyperAdaptor new.
					              UGRealTimeTyperAdaptor new })) }.
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

	| typesManager typesFinalizer generator time |
	typesManager := UGTypesManager new.
	typesManager typerAdaptor: aTyperAdaptor.
	variablesOnly ifTrue: [ typesManager skipMethods ].
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager:
		                  typesManager.
	generator := UGEnterpriseArchitectUMLGenerator new typesManager:
		             typesFinalizer.

	Smalltalk garbageCollect.
	time := Time microsecondsToRun: [
		        generator importFromPackagesNamed: { self packageName } ].
	foundCounts
		at: aTyperName
		put: (typesManager knownTypes associations count: [ :each |
				 each value realClass ~= Object ]).
	times at: aTyperName put: time.
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
		percentage := self itemCount = 0
			              ifTrue: [ 100 ]
			              ifFalse: [ each * 100 / self itemCount ].
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
		(times at: #chainedReRoRbJ) } do: [ :each |
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
			| seconds |
			seconds := time / 1000000.
			seconds < 0.1
				ifTrue: [ s << '$<$0,1' ]
				ifFalse: [
					s
					<<
					((seconds printShowingDecimalPlaces: 1)
						 copyReplaceAll: '.'
						 with: ',') ] ].
		s << ' s' ].
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
