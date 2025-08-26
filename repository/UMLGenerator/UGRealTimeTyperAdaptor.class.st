Class {
	#name : 'UGRealTimeTyperAdaptor',
	#superclass : 'UGTyperAdaptor',
	#instVars : [
		'typer'
	],
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'initialization' }
UGRealTimeTyperAdaptor >> initialize [
	super initialize.
	typer := UGRealTimeTyper default
]

{ #category : 'testing' }
UGRealTimeTyperAdaptor >> isCollectionTyper [
	^ true
]

{ #category : 'testing' }
UGRealTimeTyperAdaptor >> isMethodTyper [
	^ true
]

{ #category : 'testing' }
UGRealTimeTyperAdaptor >> isVarTyper [
	^ true
]

{ #category : 'api' }
UGRealTimeTyperAdaptor >> possibleTypesOfInputParameter: aUGParameter [

	^ self possibleTypesOfParameter: aUGParameter
]

{ #category : 'api' }
UGRealTimeTyperAdaptor >> possibleTypesOfParameter: aUGParameter [

	^ typer possibleTypesOf: aUGParameter
]

{ #category : 'api' }
UGRealTimeTyperAdaptor >> possibleTypesOfReturnParameter: aUGParameter [

	^ self possibleTypesOfParameter: aUGParameter
]

{ #category : 'api' }
UGRealTimeTyperAdaptor >> possibleTypesOfVariable: aUGVariable [
	^ typer possibleTypesOf: aUGVariable
]

{ #category : 'accessing' }
UGRealTimeTyperAdaptor >> typer: aRealTimeTyper [
	typer := aRealTimeTyper
]
