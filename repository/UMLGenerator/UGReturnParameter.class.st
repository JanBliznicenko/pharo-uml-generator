Class {
	#name : 'UGReturnParameter',
	#superclass : 'UGMethodParameter',
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'visiting' }
UGReturnParameter >> acceptVisitor: aVisitor [
	^ aVisitor visitReturnParameter: self
]

{ #category : 'initialization' }
UGReturnParameter >> initialize [
	super initialize.
	itemName := 'return'
]

{ #category : 'testing' }
UGReturnParameter >> isOut [
	^ true
]

{ #category : 'accessing' }
UGReturnParameter >> itemName: aName [
	self shouldNotImplement
]

{ #category : 'constants' }
UGReturnParameter >> kindName [
	^ 'return parameter'
]
