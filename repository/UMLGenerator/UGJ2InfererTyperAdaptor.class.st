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
	^ inferers
		at: aPackage
		ifAbsentPut: [ | inferer |
			inferer := J2Inferer withNotifier: J2NullNotifier new.
			aPackage definedClasses
				reject: [ :each | each isTrait ]
				thenDo: [ :e | inferer enqueueClass: e ].
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
UGJ2InfererTyperAdaptor >> possibleTypesOfParameter: aUGParameter [

	| method types possibleClasses classes |
	self flag: #hackBecauseOfJ2InfiniteLoopBug.
	(aUGParameter itemName = 'anEvent' and: [
		 aUGParameter method itemName = 'announce:' ]) ifTrue: [
		^ UGTypePossibilities for: aUGParameter ].
	method := ((self infererOf: aUGParameter package) typeInfoFor:
		           aUGParameter containingClass realClass) methodTypeFor:
		          aUGParameter compiledMethod.
	possibleClasses := (aUGParameter isOut
		                    ifTrue: [ method returnValue ]
		                    ifFalse: [
			                    method parameters detect: [ :any |
				                    any variableName = aUGParameter itemName ] ])
		                   possibleClasses.
	classes := possibleClasses classes.
	types := classes collect: #analysedClass.
	types remove: UndefinedObject ifAbsent: [  ]. "
	self
		haltIf: [ types
				anySatisfy: [ :any | any = Collection or: [ any inheritsFrom: Collection ] ] ]."
	^ UGTypePossibilities
		  for: aUGParameter
		  types: types
		  collectionTypes: Dictionary new
]

{ #category : #api }
UGJ2InfererTyperAdaptor >> possibleTypesOfVariable: aUGVariable [
	^ UGTypePossibilities
		for: aUGVariable
		types:
			((((self infererOf: aUGVariable package)
				typeInfoFor: aUGVariable realContainingClass)
				instanceVariable: aUGVariable itemName) possibleClasses classes
				collect: #analysedClass)
		collectionTypes: Dictionary new
]
