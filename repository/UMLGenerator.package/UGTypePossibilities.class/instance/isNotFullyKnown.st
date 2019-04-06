testing
isNotFullyKnown
	| typeEmpty typeObject typeCollections collectionsEmpty collectionsObject collectionsOfObjects |
	typeEmpty := possibleTypes isEmpty.
	typeObject := possibleTypes size = 1
		and: [ possibleTypes anyOne = Object or: [ possibleTypes anyOne isNil ] ].
	typeCollections := possibleTypes
		allSatisfy: [ :each | self class shouldTypeAsCollection: each ].
	collectionsEmpty := possibleCollectionTypes isEmpty.
	collectionsObject := possibleCollectionTypes size = 1
		and: [ possibleCollectionTypes anyOne = Object ].
	collectionsOfObjects := possibleCollectionTypes size = 1
		and: [ possibleCollectionTypes keys anyOne = Object
				or: [ possibleCollectionTypes keys anyOne isNil ] ].
	^ typeEmpty | typeObject | typeCollections
		& (collectionsEmpty | collectionsObject | collectionsOfObjects)