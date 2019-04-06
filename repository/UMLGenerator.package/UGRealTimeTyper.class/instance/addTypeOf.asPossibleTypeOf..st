adding
addTypeOf: aValue asPossibleTypeOf: aUGItem
	| possibleTypes |
	possibleTypes := self possibleTypesOf: aUGItem.
	(self shouldTypeAsCollection: aValue)
		ifFalse: [ ^ possibleTypes addPossibleType: aValue class ].
	aValue
		do: [ :each | possibleTypes addPossibleCollectionType: aValue class with: each class ]