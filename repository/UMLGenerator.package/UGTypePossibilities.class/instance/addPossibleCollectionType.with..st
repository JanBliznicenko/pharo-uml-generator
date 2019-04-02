accessing
addPossibleCollectionType: aCollectionClass with: aClass
	| classReplacement collectionClassReplacement |
	aClass == UndefinedObject ifTrue: [ ^ self ].
	classReplacement := self replacementOfClass: aClass.
	collectionClassReplacement := self replacementOfClass: aCollectionClass.
	(possibleCollectionTypes at: classReplacement ifAbsentPut: [ collectionClassReplacement ])
		== collectionClassReplacement
		ifFalse: [ possibleCollectionTypes at: classReplacement put: nil ]