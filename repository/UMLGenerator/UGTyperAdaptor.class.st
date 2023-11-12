Class {
	#name : #UGTyperAdaptor,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : 'UMLGenerator-Typer'
}

{ #category : #accessing }
UGTyperAdaptor class >> invalidClassNames [
	^ Set
		with: #GHObjectGhost
		with: #Mock
		with: #GHClassGhost
		with: #GHObjectGhostStub
]

{ #category : #accessing }
UGTyperAdaptor class >> invalidClasses [
	^ self invalidClassNames
		select: [ :each | Smalltalk globals includesKey: each ]
		thenCollect: [ :each | Smalltalk globals at: each ]
]

{ #category : #accessing }
UGTyperAdaptor class >> replacements [
	^ {(ProtoObject -> Object)} asDictionary
]

{ #category : #private }
UGTyperAdaptor >> filterTypes: aCollectionOfClasses [
	| invalidClasses replacements |
	invalidClasses := self class invalidClasses.
	replacements := self class replacements.
	^ aCollectionOfClasses
		reject: [ :each | invalidClasses includes: each ]
		thenCollect: [ :each | replacements at: each ifAbsent: [ each ] ]
]

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
UGTyperAdaptor >> possibleTypesOfParameter: aUGParameter [
	self isMethodTyper
		ifFalse: [ ^ UGTypePossibilities for: aUGParameter ].
	^ self subclassResponsibility
]

{ #category : #api }
UGTyperAdaptor >> possibleTypesOfVariable: aVariable [
	self isVarTyper
		ifFalse: [ ^ UGTypePossibilities for: aVariable ].
	^ self subclassResponsibility
]
