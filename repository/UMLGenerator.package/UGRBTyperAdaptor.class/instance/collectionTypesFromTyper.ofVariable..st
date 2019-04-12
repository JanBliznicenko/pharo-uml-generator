as yet unclassified
collectionTypesFromTyper: aTyper ofVariable: aUGVariable
	| possibleCollectionTypes possibleElementTypes collectionType |
	possibleCollectionTypes := self
		filterTypes:
			((aTyper guessTypesFor: aUGVariable variableName)
				collect: #realClass
				thenSelect: [ :each | each includesBehavior: Collection ]).
	possibleCollectionTypes ifEmpty: [ ^ Dictionary new ].
	possibleElementTypes := self
		filterTypes:
			((aTyper guessTypesFor: '-' , aUGVariable variableName , '-')
				collect: #realClass).
	collectionType := self commonSuperclassOf: possibleCollectionTypes.
	possibleElementTypes
		ifEmpty: [ ^ {(Object -> collectionType)} asDictionary ].
	^ (possibleElementTypes collect: [ :each | each -> collectionType ])
		asDictionary