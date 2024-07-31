Class {
	#name : #UGJ2InfererTyperAdaptor,
	#superclass : #UGTyperAdaptor,
	#instVars : [
		'inferers'
	],
	#category : #'UMLGenerator-Typer'
}

{ #category : #private }
UGJ2InfererTyperAdaptor >> infererOf: aPackage [

	^ inferers at: aPackage ifAbsentPut: [
		  | inferer |
		  inferer := J2Inferer withNotifier: J2NullNotifier new.
		  ((J2InferenceManager findTransitiveRelatedClassesTo:
			    aPackage definedClasses asSet) reject: [ :each | each isTrait ])
			  do: [ :e | inferer enqueueClass: e ].
		  inferer runAndWait.
		  inferer ]
]

{ #category : #initialization }
UGJ2InfererTyperAdaptor >> initialize [
	super initialize.
	inferers := Dictionary new
]

{ #category : #testing }
UGJ2InfererTyperAdaptor >> isMethodTyper [
	^ true
]

{ #category : #testing }
UGJ2InfererTyperAdaptor >> isVarTyper [
	^ true
]

{ #category : #api }
UGJ2InfererTyperAdaptor >> possibleTypesOfInputParameter: aUGParameter [

	self flag: #hackBecauseOfJ2InfiniteLoopBug.
	(aUGParameter itemName = 'anEvent' and: [
		 aUGParameter method itemName = 'announce:' ]) ifTrue: [
		^ UGTypePossibilities emptyFor: aUGParameter ].
	^ self
		  possibleTypesOfParameter: aUGParameter
		  byJ2VariableBlock: [ :method |
			  method parameters detect: [ :any |
				  any variableName = aUGParameter itemName ] ]
]

{ #category : #api }
UGJ2InfererTyperAdaptor >> possibleTypesOfParameter: aUGParameter byJ2VariableBlock: aBlock [

	| method types possibleClasses classes |
	method := ((self infererOf: aUGParameter package) typeInfoFor:
		           aUGParameter containingClass realClass) methodTypeFor:
		          aUGParameter compiledMethod.
	possibleClasses := (aBlock value: method) possibleClasses.
	classes := possibleClasses classes.
	types := classes collect: #analysedClass.
	types remove: UndefinedObject ifAbsent: [  ].
	^ UGTypePossibilities for: aUGParameter types: types
]

{ #category : #api }
UGJ2InfererTyperAdaptor >> possibleTypesOfReturnParameter: aUGParameter [

	^ self
		  possibleTypesOfParameter: aUGParameter
		  byJ2VariableBlock: [ :method | method returnValue ]
]

{ #category : #api }
UGJ2InfererTyperAdaptor >> possibleTypesOfVariable: aUGVariable [

	^ UGTypePossibilities
		  for: aUGVariable
		  types: ((((self infererOf: aUGVariable package) typeInfoFor:
				     aUGVariable realContainingClass) instanceVariable:
				    aUGVariable itemName) possibleClasses classes collect:
				   #analysedClass)
]
