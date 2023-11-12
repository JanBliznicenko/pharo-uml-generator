Class {
	#name : #UGGUITypesManagerFinalizer,
	#superclass : #UGTypesManagerFinalizer,
	#category : 'UMLGeneratorGUI'
}

{ #category : #accessing }
UGGUITypesManagerFinalizer >> dialogClass [
	^ UGTypesManagerDialog
]

{ #category : #retrieving }
UGGUITypesManagerFinalizer >> typeFor: typePossibilities [
	^ self dialogClass typeFor: typePossibilities
]
