Class {
	#name : #UGAutoTypesManagerFinalizer,
	#superclass : #UGTypesManagerFinalizer,
	#category : #'UMLGenerator-TypeManager'
}

{ #category : #retrieving }
UGAutoTypesManagerFinalizer >> typeFor: typePossibilities [

	| typePossibilitiesWithOneClass typeClass |
	typePossibilitiesWithOneClass := typePossibilities
		                                 reducedToCommonSuperclass.
	typeClass := typePossibilitiesWithOneClass possibleTypes anyOne.
	typePossibilitiesWithOneClass isCollection ifTrue: [
		^ UGCollection
			  type: typeClass
			  with:
			  typePossibilitiesWithOneClass possibleCollectionElementTypes
				  anyOne ].
	^ UGClass for: typeClass
]
