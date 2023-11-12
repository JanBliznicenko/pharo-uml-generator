Class {
	#name : #UGTypePossibilities,
	#superclass : #Object,
	#instVars : [
		'item',
		'possibleTypes',
		'possibleCollectionTypes',
		'classReplacements'
	],
	#classInstVars : [
		'atomicCollectionTypes',
		'classReplacements'
	],
	#category : #'UMLGenerator-Typer'
}

{ #category : #accessing }
UGTypePossibilities class >> atomicCollectionTypes [

	^ atomicCollectionTypes ifNil: [
		  atomicCollectionTypes := {
			                           BitmapCharacterSet.
			                           CharacterSet.
			                           CharacterSetComplement.
			                           Bitmap.
			                           ByteArray.
			                           DoubleByteArray.
			                           DoubleWordArray.
			                           FFIExternalArray.
			                           Float32Array.
			                           Float64Array.
			                           IntegerArray.
			                           ShortIntegerArray.
			                           SparseLargeTable.
			                           String.
			                           Text.
			                           WordArray.
			                           Interval.
			                           Semaphore.
			                           ProcessList.
			                           RunArray.
			                           WideCharacterSet } asSet flatCollect: [
			                           :each | each withAllSubclasses ] ]
]

{ #category : #accessing }
UGTypePossibilities class >> classReplacements [
	^ classReplacements
		ifNil: [ classReplacements := {(True -> Boolean).
			(False -> Boolean).
			(ByteString -> String).
			(WideString -> String).
			(ByteSymbol -> Symbol).
			(WideSymbol -> Symbol).
			(BoxedFloat64 -> Float).
			(SmallFloat64 -> Float).
			(LargeInteger -> Integer).
			(LargeNegativeInteger -> Integer).
			(LargePositiveInteger -> Integer).
			(SmallInteger -> Integer)} asDictionary ]
]

{ #category : #'instance creation' }
UGTypePossibilities class >> for: anItem [
	^ self new
		item: anItem;
		yourself
]

{ #category : #'instance creation' }
UGTypePossibilities class >> for: anItem types: aCollectionOfTypes collectionTypes: aDictionaryOfCollectionTypes [
	^ self new
		item: anItem;
		possibleTypes: aCollectionOfTypes;
		possibleCollectionTypes: aDictionaryOfCollectionTypes;
		yourself
]

{ #category : #accessing }
UGTypePossibilities class >> shouldTypeAsCollection: aClass [
	^ (aClass includesBehavior: Collection)
		and: [ (UGTypePossibilities atomicCollectionTypes includes: aClass) not ]
]

{ #category : #'instance creation' }
UGTypePossibilities class >> withAll: aCollectionOfTypePossibilities [
	| item collectionTypes |
	item := aCollectionOfTypePossibilities anyOne item.
	self assert: (aCollectionOfTypePossibilities allSatisfy: [ :each | each item = item ]).
	collectionTypes := Dictionary new.
	aCollectionOfTypePossibilities
		do: [ :each | collectionTypes addAll: each possibleCollectionTypes ].
	^ self
		for: item
		types: (aCollectionOfTypePossibilities flatCollect: [ :each | each possibleTypes ])
		collectionTypes: collectionTypes
]

{ #category : #copying }
UGTypePossibilities >> , otherTypePossibilities [
	^ UGTypePossibilities
		for: item
		types: possibleTypes , otherTypePossibilities possibleTypes
		collectionTypes: possibleCollectionTypes , otherTypePossibilities possibleCollectionTypes
]

{ #category : #accessing }
UGTypePossibilities >> addPossibleCollectionType: aClass [
	self addPossibleCollectionType: nil with: aClass
]

{ #category : #adding }
UGTypePossibilities >> addPossibleCollectionType: aCollectionClass with: aClass [
	| classReplacement collectionClassReplacement |
	aClass == UndefinedObject
		ifTrue: [ ^ self ].
	classReplacement := self replacementOfClass: aClass.
	collectionClassReplacement := self replacementOfClass: aCollectionClass.
	(possibleCollectionTypes
		at: classReplacement
		ifAbsentPut: [ collectionClassReplacement ])
		== collectionClassReplacement
		ifFalse: [ possibleCollectionTypes
				at: classReplacement
				put:
					(self
						commonSuperclassOf:
							{(possibleCollectionTypes at: classReplacement).
							collectionClassReplacement}) ]
]

{ #category : #accessing }
UGTypePossibilities >> addPossibleType: aClass [
	aClass == UndefinedObject ifTrue: [ ^ self ].
	possibleTypes add: (self replacementOfClass: aClass)
]

{ #category : #converting }
UGTypePossibilities >> asUGClasses [
	^ self possibleTypesAsUGClasses , self possibleCollectionTypesAsUGClasses
]

{ #category : #private }
UGTypePossibilities >> commonSuperclassOf: classes [
	| currentSuperclasses bestCommonIndex commonHierarchy classesArray |
	classes ifEmpty: [ ^ Object ].
	classes size = 1
		ifTrue: [ ^ classes anyOne ].
	classesArray := classes asArray.
	commonHierarchy := classesArray copyWithoutFirst
		inject: classesArray first withAllSuperclasses reversed
		into: [ :lastHierarchy :realClass | 
			currentSuperclasses := realClass withAllSuperclasses reversed.
			lastHierarchy first == currentSuperclasses first
				ifFalse: [ ^ Object ].
			bestCommonIndex := 1.
			1 to: (lastHierarchy size min: currentSuperclasses size) do: [ :i | 
				(lastHierarchy at: i) == (currentSuperclasses at: i)
					ifTrue: [ bestCommonIndex := i ] ].
			lastHierarchy first: bestCommonIndex ].
	^ commonHierarchy last
]

{ #category : #initialization }
UGTypePossibilities >> initialize [
	super initialize.
	possibleTypes := Set new.
	possibleCollectionTypes := Dictionary new
]

{ #category : #testing }
UGTypePossibilities >> isEmpty [
	^ possibleTypes isEmpty & possibleCollectionTypes isEmpty
]

{ #category : #testing }
UGTypePossibilities >> isNotFullyKnown [
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
]

{ #category : #testing }
UGTypePossibilities >> isPossibleCollection [
	^ possibleCollectionTypes isNotEmpty
]

{ #category : #testing }
UGTypePossibilities >> isUnknown [
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
		& (collectionsEmpty | (collectionsObject & collectionsOfObjects))
]

{ #category : #accessing }
UGTypePossibilities >> item [
	^ item
]

{ #category : #accessing }
UGTypePossibilities >> item: anItem [
	item := anItem
]

{ #category : #accessing }
UGTypePossibilities >> possibleCollectionTypes [
	^ possibleCollectionTypes
]

{ #category : #accessing }
UGTypePossibilities >> possibleCollectionTypes: aDictionaryOfTypes [
	possibleCollectionTypes := (aDictionaryOfTypes associations
		collect: [ :each | (self replacementOfClass: each key) -> (self replacementOfClass: each value) ]
		thenReject: [ :each | each key == UndefinedObject ]) asDictionary
]

{ #category : #converting }
UGTypePossibilities >> possibleCollectionTypesAsUGClasses [
	| ugCollections |
	ugCollections := OrderedCollection new.
	possibleCollectionTypes
		keysAndValuesDo:
			[ :eachClass :eachCollectionClass | ugCollections add: (UGCollection type: eachCollectionClass with: eachClass) ].
	^ ugCollections
]

{ #category : #accessing }
UGTypePossibilities >> possibleTypes [
	^ possibleTypes
]

{ #category : #accessing }
UGTypePossibilities >> possibleTypes: aCollectionOfTypes [
	possibleTypes := (aCollectionOfTypes
		reject: [ :each | each == UndefinedObject ]
		thenCollect: [ :each | self replacementOfClass: each ]) asSet
]

{ #category : #converting }
UGTypePossibilities >> possibleTypesAsUGClasses [
	^ possibleTypes collect: [ :each | UGClass for: each ] as: OrderedCollection
]

{ #category : #printing }
UGTypePossibilities >> printOn: aStream [
	super printOn: aStream.
	aStream << ' (' << self size asString << ')'
]

{ #category : #private }
UGTypePossibilities >> replacementOfClass: aClass [
	^ self class classReplacements at: aClass ifAbsent: [ aClass ]
]

{ #category : #accessing }
UGTypePossibilities >> size [
	^ possibleCollectionTypes size + possibleTypes size
]
