Class {
	#name : #UGTyperAdaptorCombinator,
	#superclass : #UGTyperAdaptor,
	#instVars : [
		'adaptors'
	],
	#category : 'UMLGenerator-Typer'
}

{ #category : #'instance creation' }
UGTyperAdaptorCombinator class >> withAdaptors: aCollection [
	^ self new
		adaptors: aCollection;
		yourself
]

{ #category : #accessing }
UGTyperAdaptorCombinator >> adaptors: aCollection [
	adaptors := aCollection asArray
]

{ #category : #testing }
UGTyperAdaptorCombinator >> isCollectionTyper [
	^ adaptors anySatisfy: [ :any | any isCollectionTyper ]
]

{ #category : #testing }
UGTyperAdaptorCombinator >> isMethodTyper [
	^ adaptors anySatisfy: [ :any | any isMethodTyper ]
]

{ #category : #testing }
UGTyperAdaptorCombinator >> isVarTyper [
	^ adaptors anySatisfy: [ :any | any isVarTyper ]
]

{ #category : #api }
UGTyperAdaptorCombinator >> possibleTypesOfParameter: aParameter [
	^ self possibleTypesFromBlock: [ :adaptor | adaptor possibleTypesOfParameter: aParameter ]
]

{ #category : #api }
UGTyperAdaptorCombinator >> possibleTypesOfVariable: aVariable [
	^ self
		possibleTypesFromBlock: [ :adaptor | adaptor possibleTypesOfVariable: aVariable ]
]
