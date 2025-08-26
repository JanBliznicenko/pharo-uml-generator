Class {
	#name : 'UGClass',
	#superclass : 'UGStructureItem',
	#instVars : [
		'realClass'
	],
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'instance creation' }
UGClass class >> for: realClass [
	^ self new
		realClass: realClass;
		yourself
]

{ #category : 'comparing' }
UGClass >> < anotherItem [
	realClass package = anotherItem realClass package
		ifFalse: [ ^ realClass package name < anotherItem realClass package name ].
	realClass = anotherItem realClass
		ifFalse: [ ^ realClass name < anotherItem realClass name ].
	^ super < anotherItem
]

{ #category : 'visiting' }
UGClass >> acceptVisitor: aVisitor [
	aVisitor visitClass: self
]

{ #category : 'testing' }
UGClass >> isCollectionClass [
	^ false
]

{ #category : 'accessing' }
UGClass >> itemName [
	^ realClass asString
]

{ #category : 'accessing' }
UGClass >> itemName: aName [
	self shouldNotImplement
]

{ #category : 'accessing' }
UGClass >> kindName [
	^ 'class'
]

{ #category : 'accessing' }
UGClass >> package [
	^ self realClass package
]

{ #category : 'printing' }
UGClass >> printContext [
	^ realClass package name
]

{ #category : 'accessing' }
UGClass >> realClass [
	^ realClass
]

{ #category : 'accessing' }
UGClass >> realClass: aClass [
	aClass = True
		ifTrue: [ self halt ].
	realClass := aClass.
	itemName := aClass asString
]

{ #category : 'as yet unclassified' }
UGClass >> replacedByRealClass: aClass [
	^ self class for: aClass
]

{ #category : 'accessing class hierarchy' }
UGClass >> withAllSuperclasses [
	^ realClass withAllSuperclasses reversed collect: [ :each | self class for: each ]
]
