Class {
	#name : #UGTyperAdaptorCombinator,
	#superclass : #Object,
	#instVars : [
		'adaptors'
	],
	#category : #'UMLGenerator-Typer'
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

{ #category : #private }
UGTyperAdaptorCombinator >> canImmediatelyAnswer: typePossibilities [

	^ self subclassResponsibility
]

{ #category : #private }
UGTyperAdaptorCombinator >> combine: collectionOfTypePossibilities [

	^ self subclassResponsibility
]

{ #category : #private }
UGTyperAdaptorCombinator >> possibleTypesFromBlock: aBlock [

	| collectionOfTypePossibilities |
	adaptors ifEmpty: [ self error: 'No TyperAdaptor available' ].
	collectionOfTypePossibilities := adaptors collect: [ :each |
		                                 | adaptorTypePossibilities |
		                                 adaptorTypePossibilities := self
			                                                             processAdaptorTypes:
			                                                             (aBlock
				                                                              value:
				                                                              each).
		                                 (self canImmediatelyAnswer:
			                                  adaptorTypePossibilities)
			                                 ifTrue: [
			                                 ^ adaptorTypePossibilities ].
		                                 adaptorTypePossibilities ].
	^ self combine: collectionOfTypePossibilities
]

{ #category : #api }
UGTyperAdaptorCombinator >> possibleTypesOfInputParameter: aUGParameter [

	^ self possibleTypesFromBlock: [ :adaptor |
		  adaptor possibleTypesOfInputParameter: aUGParameter ]
]

{ #category : #api }
UGTyperAdaptorCombinator >> possibleTypesOfReturnParameter: aUGParameter [

	^ self possibleTypesFromBlock: [ :adaptor |
		  adaptor possibleTypesOfReturnParameter: aUGParameter ]
]

{ #category : #api }
UGTyperAdaptorCombinator >> possibleTypesOfVariable: aVariable [
	^ self
		possibleTypesFromBlock: [ :adaptor | adaptor possibleTypesOfVariable: aVariable ]
]

{ #category : #private }
UGTyperAdaptorCombinator >> processAdaptorTypes: typePossibilities [

	^ typePossibilities
]
