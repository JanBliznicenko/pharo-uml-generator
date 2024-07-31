Class {
	#name : #UGTyperAdaptorCommonSuperclassCombinator,
	#superclass : #UGTyperAdaptorCombinator,
	#category : #'UMLGenerator-Typer'
}

{ #category : #private }
UGTyperAdaptorCommonSuperclassCombinator >> processAdaptorTypes: typePossibilities [

	^ typePossibilities reducedToCommonSuperclass
]
