Class {
	#name : #UGVariable,
	#superclass : #UGClassItem,
	#instVars : [
		'isShared'
	],
	#category : 'UMLGenerator-Structure'
}

{ #category : #visiting }
UGVariable >> acceptVisitor: aVisitor [
	^ aVisitor visitVariable: self
]

{ #category : #initialization }
UGVariable >> initialize [
	super initialize.
	isShared := false
]

{ #category : #testing }
UGVariable >> isClassSide [
	^ isShared or: [ super isClassSide ]
]

{ #category : #accessing }
UGVariable >> isShared [
	^ isShared
]

{ #category : #constants }
UGVariable >> kindName [
	^ 'variable'
]

{ #category : #accessing }
UGVariable >> shared [
	isShared := true
]

{ #category : #accessing }
UGVariable >> variableName [
	^ self itemName
]

{ #category : #accessing }
UGVariable >> variableName: aString [
	self itemName: aString
]
