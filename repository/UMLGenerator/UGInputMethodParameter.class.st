Class {
	#name : 'UGInputMethodParameter',
	#superclass : 'UGMethodParameter',
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'instance creation' }
UGInputMethodParameter class >> named: aString in: aMethod [
	^ self new
		method: aMethod;
		itemName: aString;
		yourself
]

{ #category : 'visiting' }
UGInputMethodParameter >> acceptVisitor: aVisitor [
	^ aVisitor visitInputMethodParameter: self
]

{ #category : 'constants' }
UGInputMethodParameter >> kindName [
	^ 'method parameter'
]
