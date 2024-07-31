Class {
	#name : #UGTyperAdaptor,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'UMLGenerator-Typer'
}

{ #category : #testing }
UGTyperAdaptor >> isCollectionTyper [
	^ false
]

{ #category : #testing }
UGTyperAdaptor >> isMethodTyper [
	^ false
]

{ #category : #testing }
UGTyperAdaptor >> isVarTyper [
	^ false
]

{ #category : #api }
UGTyperAdaptor >> possibleTypesOfInputParameter: aUGParameter [

	^ self subclassResponsibility
]

{ #category : #api }
UGTyperAdaptor >> possibleTypesOfReturnParameter: aUGParameter [

	^ self subclassResponsibility
]

{ #category : #api }
UGTyperAdaptor >> possibleTypesOfVariable: aVariable [

	^ self subclassResponsibility
]
