Class {
	#name : 'UGMethodItem',
	#superclass : 'UGStructureItem',
	#instVars : [
		'method',
		'containingClass'
	],
	#category : 'UMLGenerator-Structure',
	#package : 'UMLGenerator',
	#tag : 'Structure'
}

{ #category : 'instance creation' }
UGMethodItem class >> in: aMethod [
	^ self new
		method: aMethod;
		yourself
]

{ #category : 'comparing' }
UGMethodItem >> < anotherItem [
	method = anotherItem method
		ifFalse: [ ^ method < anotherItem method ].
	^ super < anotherItem
]

{ #category : 'comparing' }
UGMethodItem >> = anotherItem [
	^ (anotherItem respondsTo: #method)
		and: [ method = anotherItem method and: [ super = anotherItem ] ]
]

{ #category : 'accessing' }
UGMethodItem >> compiledMethod [
	^ method compiledMethod
]

{ #category : 'accessing' }
UGMethodItem >> containingClass [
	^ containingClass
]

{ #category : 'comparing' }
UGMethodItem >> hash [
	^ method hash bitXor: super hash
]

{ #category : 'accessing' }
UGMethodItem >> isClassSide [
	^ self method isClassSide
]

{ #category : 'accessing' }
UGMethodItem >> method [
	^ method
]

{ #category : 'accessing' }
UGMethodItem >> method: aMethod [
	method := aMethod.
	containingClass := method containingClass
]

{ #category : 'accessing' }
UGMethodItem >> methodName [

	^ method itemName
]

{ #category : 'accessing' }
UGMethodItem >> package [
	^ self containingClass package
]

{ #category : 'accessing' }
UGMethodItem >> possiblyMetaContainingClass [
	self isClassSide
		ifTrue: [ ^ self containingClass class ].
	^ self containingClass
]

{ #category : 'printing' }
UGMethodItem >> printContext [
	^ method printWithContext
]

{ #category : 'accessing' }
UGMethodItem >> realContainingClass [
	self isClassSide
		ifTrue: [ ^ self containingClass realClass class ].
	^ self containingClass class
]
