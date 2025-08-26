Class {
	#name : 'UGTyperAdaptorCommonSuperclassCombinator',
	#superclass : 'UGTyperAdaptorCombinator',
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'private' }
UGTyperAdaptorCommonSuperclassCombinator >> processAdaptorTypes: typePossibilities [

	^ typePossibilities reducedToCommonSuperclass
]
