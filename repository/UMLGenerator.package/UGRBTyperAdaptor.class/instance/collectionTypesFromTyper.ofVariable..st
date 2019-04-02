as yet unclassified
collectionTypesFromTyper: aTyper ofVariable: aUGVariable
	| possibleCollectionTypes collectionType possibleElementTypes |
	possibleCollectionTypes := self
		filterTypes:
			((aTyper guessTypesFor: aUGVariable variableName)
				collect: #realClass
				thenSelect: [ :each | each == Collection or: [ each inheritsFrom: Collection ] ]).
	possibleCollectionTypes ifEmpty: [ ^ Dictionary new ].
	collectionType := possibleCollectionTypes size = 1
		ifTrue: [ possibleCollectionTypes anyOne ].
	possibleElementTypes := self
		filterTypes: ((aTyper guessTypesFor: '-' , aUGVariable variableName , '-') collect: #realClass).
	^ (possibleElementTypes collect: [ :each | each -> collectionType ]) asDictionary