Class {
	#name : 'UGCollection',
	#superclass : 'UGClass',
	#instVars : [
		'collectionRealClass'
	],
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'instance creation' }
UGCollection class >> type: collectionClass with: realClass [
	^ (self for: realClass)
		collectionRealClass: collectionClass;
		yourself
]

{ #category : 'instance creation' }
UGCollection class >> with: realClass [
	^ self for: realClass
]

{ #category : 'comparing' }
UGCollection >> < anotherItem [
	realClass package = anotherItem realClass package
		ifFalse: [ ^ realClass package name < anotherItem realClass package name ].
	realClass = anotherItem realClass
		ifFalse: [ ^ realClass name < anotherItem realClass name ].
	^ super < anotherItem
]

{ #category : 'visiting' }
UGCollection >> acceptVisitor: aVisitor [
	aVisitor visitCollectionClass: self
]

{ #category : 'accessing' }
UGCollection >> collectionRealClass [
	^ collectionRealClass
]

{ #category : 'accessing' }
UGCollection >> collectionRealClass: aClass [
	collectionRealClass := aClass
]

{ #category : 'accessing' }
UGCollection >> elementRealClass [

	^ self realClass
]

{ #category : 'testing' }
UGCollection >> isCollectionClass [
	^ true
]

{ #category : 'printing' }
UGCollection >> printName [
	| name |
	name := '*' , self itemName.
	collectionRealClass ifNil: [ ^ name ].
	^ name , '*' , collectionRealClass name
]

{ #category : 'as yet unclassified' }
UGCollection >> replacedByRealClass: aClass [
	^ self class type: collectionRealClass with: aClass
]
