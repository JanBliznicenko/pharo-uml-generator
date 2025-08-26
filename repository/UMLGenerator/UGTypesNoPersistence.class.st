Class {
	#name : 'UGTypesNoPersistence',
	#superclass : 'UGTypesPersistence',
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'persistence' }
UGTypesNoPersistence >> loadTypes [
	^ Dictionary new
]

{ #category : 'persistence' }
UGTypesNoPersistence >> saveTypes: aDictionary [
	"do nothing"

	
]
