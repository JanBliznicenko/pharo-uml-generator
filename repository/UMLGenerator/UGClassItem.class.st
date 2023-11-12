Class {
	#name : #UGClassItem,
	#superclass : #UGStructureItem,
	#instVars : [
		'containingClass'
	],
	#category : 'UMLGenerator-Structure'
}

{ #category : #'instance creation' }
UGClassItem class >> named: aString in: aClass [
	^ self new
		itemName: aString;
		containingClass: aClass;
		yourself
]

{ #category : #comparing }
UGClassItem >> < anotherItem [
	containingClass package = anotherItem containingClass package
		ifFalse: [ ^ containingClass package name < anotherItem containingClass package name ].
	containingClass = anotherItem containingClass
		ifFalse: [ ^ containingClass name < anotherItem containingClass name ].
	^ super < anotherItem
]

{ #category : #comparing }
UGClassItem >> = anotherItem [
	^ (anotherItem respondsTo: #containingClass) and: [ containingClass = anotherItem containingClass and: [ super = anotherItem ] ]
]

{ #category : #accessing }
UGClassItem >> containingClass [
	^ containingClass
]

{ #category : #accessing }
UGClassItem >> containingClass: aClass [
	containingClass := aClass
]

{ #category : #comparing }
UGClassItem >> hash [
	^ containingClass hash bitXor: super hash
]

{ #category : #initialization }
UGClassItem >> initialize [
	super initialize.
	containingClass := Object
]

{ #category : #testing }
UGClassItem >> isClassSide [
	^ self containingClass isMeta
]

{ #category : #accessing }
UGClassItem >> package [
	^ self containingClass package
]

{ #category : #printing }
UGClassItem >> printContext [
	^ containingClass package name , '>' , containingClass name
]

{ #category : #accessing }
UGClassItem >> realContainingClass [
	self isClassSide
		ifTrue: [ ^ self containingClass realClass class ].
	^ self containingClass class
]
