Class {
	#name : #UGTypesManagerFinalizer,
	#superclass : #Object,
	#instVars : [
		'typesManager'
	],
	#category : #'UMLGenerator-TypeManager'
}

{ #category : #example }
UGTypesManagerFinalizer class >> example [
	^ UGEnterpriseArchitectUMLGenerator new
		typesManager: self new;
		importFromPackagesNamed: #('Zinc-HTTP')
]

{ #category : #example }
UGTypesManagerFinalizer class >> exampleExportToFile [
	| generator model |
	generator := UGEnterpriseArchitectUMLGenerator new typesManager: self new.
	model := generator importFromPackagesNamed: {'Zinc-HTTP'}.
	generator saveXmlTo: 'Zinc-HTTP.xmi'.
	^ model
]

{ #category : #singleton }
UGTypesManagerFinalizer class >> resetDefault [
	UGTypesManager resetDefault.
	self new
]

{ #category : #initialization }
UGTypesManagerFinalizer >> initialize [
	super initialize.
	self typesManager: UGTypesManager default
]

{ #category : #profiling }
UGTypesManagerFinalizer >> measuredTime [

	^ typesManager measuredTime
]

{ #category : #profiling }
UGTypesManagerFinalizer >> startTimeMeasuring [

	typesManager startTimeMeasuring
]

{ #category : #retrieving }
UGTypesManagerFinalizer >> typeFor: typePossibilities [
	^ self subclassResponsibility
]

{ #category : #retrieving }
UGTypesManagerFinalizer >> typeOf: anItem [
	^ typesManager typeOf: anItem
]

{ #category : #accessing }
UGTypesManagerFinalizer >> typesManager: aTypesManager [
	aTypesManager blockForVariable: [ :typePossibilities | self typeFor: typePossibilities ].
	aTypesManager blockForParameter: [ :typePossibilities | self typeFor: typePossibilities ].
	typesManager := aTypesManager
]
