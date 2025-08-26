Class {
	#name : 'UGStructureItem',
	#superclass : 'Object',
	#instVars : [
		'itemName'
	],
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'comparing' }
UGStructureItem >> < anotherItem [
	^ self class asString < anotherItem class asString
		or: [ self itemName < anotherItem itemName ]
]

{ #category : 'comparing' }
UGStructureItem >> = anotherItem [
	^ self class = anotherItem class and: [ self itemName = anotherItem itemName ]
]

{ #category : 'visiting' }
UGStructureItem >> acceptVisitor: aVisitor [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
UGStructureItem >> hash [
	^ self class hash bitXor: self itemName hash
]

{ #category : 'initialization' }
UGStructureItem >> initialize [
	super initialize.
	itemName := ''
]

{ #category : 'accessing' }
UGStructureItem >> itemName [
	^ itemName
]

{ #category : 'accessing' }
UGStructureItem >> itemName: aName [
	itemName := aName
]

{ #category : 'as yet unclassified' }
UGStructureItem >> kindName [
	^ self subclassResponsibility
]

{ #category : 'printing' }
UGStructureItem >> printContext [
	^ self subclassResponsibility
]

{ #category : 'printing' }
UGStructureItem >> printName [
	^ self itemName
]

{ #category : 'printing' }
UGStructureItem >> printOn: aStream [
	aStream << self printWithContext
]

{ #category : 'printing' }
UGStructureItem >> printWithContext [
	^ self printContext , '>' , self printName
]
