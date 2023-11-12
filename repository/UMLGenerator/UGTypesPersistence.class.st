Class {
	#name : #UGTypesPersistence,
	#superclass : #Object,
	#category : 'UMLGenerator-Typer'
}

{ #category : #persistence }
UGTypesPersistence >> loadTypes [
	^ self subclassResponsibility
]

{ #category : #persistence }
UGTypesPersistence >> saveTypes: aDictionary [
	self subclassResponsibility
]
