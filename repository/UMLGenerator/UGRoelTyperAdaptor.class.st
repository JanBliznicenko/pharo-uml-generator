Class {
	#name : #UGRoelTyperAdaptor,
	#superclass : #UGTyperAdaptor,
	#instVars : [
		'extractedTypesByClasses'
	],
	#category : #'UMLGenerator-Typer'
}

{ #category : #api }
UGRoelTyperAdaptor >> extractedTypesOfClass: aClass [

	^ extractedTypesByClasses
		  at: aClass
		  ifAbsentPut: [
		  (TypeCollector typeInstvarsOfClass: aClass) asDictionary ]
]

{ #category : #initialization }
UGRoelTyperAdaptor >> initialize [

	super initialize.
	extractedTypesByClasses := IdentityDictionary new
]

{ #category : #testing }
UGRoelTyperAdaptor >> isMethodTyper [
	^ true
]

{ #category : #testing }
UGRoelTyperAdaptor >> isVarTyper [
	^ true
]

{ #category : #api }
UGRoelTyperAdaptor >> possibleTypesOfInputParameter: aUGParameter [

	aUGParameter itemName = 'return' ifTrue: [
		self error: 'Input parameter with name "return"' ].
	^ self possibleTypesOfParameter: aUGParameter withAttemptedNames: {
			  aUGParameter itemName.
			  ('tmp' , (aUGParameter compiledMethod argumentNames indexOf:
				    aUGParameter itemName) asString) }
]

{ #category : #api }
UGRoelTyperAdaptor >> possibleTypesOfParameter: aUGParameter withAttemptedNames: aCollectionOfParameterNames [

	| types extractedTypesByNamesInMethods baseName extractedTypes |
	extractedTypesByNamesInMethods := self extractedTypesOfClass:
		                                  aUGParameter containingClass.
	baseName := '_' , aUGParameter methodName , '>>'.

	extractedTypes := extractedTypesByNamesInMethods at:
		                  ((aCollectionOfParameterNames collect: [ :eachName |
			                    baseName , eachName ]) detect: [ :anyName |
			                   extractedTypesByNamesInMethods includesKey:
				                   anyName ]).
	types := extractedTypes types asSet.
	^ UGTypePossibilities for: aUGParameter types: types
]

{ #category : #api }
UGRoelTyperAdaptor >> possibleTypesOfReturnParameter: aUGParameter [

	^ self
		  possibleTypesOfParameter: aUGParameter
		  withAttemptedNames: #( return )
]

{ #category : #api }
UGRoelTyperAdaptor >> possibleTypesOfVariable: aUGVariable [

	| types |
	aUGVariable isShared ifTrue: [
		^ UGTypePossibilities emptyFor: aUGVariable ].
	types := ((self extractedTypesOfClass: aUGVariable containingClass)
		          at: aUGVariable variableName) types asSet.
	^ UGTypePossibilities for: aUGVariable types: types
]
