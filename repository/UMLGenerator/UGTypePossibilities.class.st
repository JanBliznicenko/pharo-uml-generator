Class {
	#name : #UGTypePossibilities,
	#superclass : #Object,
	#instVars : [
		'item',
		'possibleTypes',
		'possibleCollectionElementTypes'
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

{ #category : #retrieving }
UGTypePossibilities class >> commonSuperclassOf: classes [

	| currentSuperclasses bestCommonIndex commonHierarchy classesArray |
	classesArray := classes asArray reject: #isNil.
	classesArray ifEmpty: [ ^ Object ].
	classesArray size = 1 ifTrue: [ ^ classesArray anyOne ].
	commonHierarchy := classesArray copyWithoutFirst
		                   inject:
		                   classesArray first withAllSuperclasses reversed
		                   into: [ :lastHierarchy :realClass |
			                   currentSuperclasses := realClass
				                                          withAllSuperclasses
				                                          reversed.
			                   lastHierarchy first == currentSuperclasses first
				                   ifFalse: [ ^ Object ].
			                   bestCommonIndex := 1.
			                   1 to:
				                   (lastHierarchy size min:
					                    currentSuperclasses size) do: [ :i |
				                   (lastHierarchy at: i)
				                   == (currentSuperclasses at: i) ifTrue: [
					                   bestCommonIndex := i ] ].
			                   lastHierarchy first: bestCommonIndex ].
	^ commonHierarchy last
]

{ #category : #'instance creation' }
UGTypePossibilities class >> emptyFor: anItem [

	^ self new
		  item: anItem;
		  yourself
]

{ #category : #'instance creation' }
UGTypePossibilities class >> for: anItem types: aCollectionOfTypes [

	^ (self emptyFor: anItem)
		  possibleTypes: aCollectionOfTypes;
		  yourself
]

{ #category : #'instance creation' }
UGTypePossibilities class >> for: anItem types: aCollectionOfTypes collectionElementTypes: aCollectionOfElementTypes [

	^ (self for: anItem types: aCollectionOfTypes)
		  possibleCollectionElementTypes: aCollectionOfElementTypes;
		  yourself
]

{ #category : #accessing }
UGTypePossibilities class >> shouldTypeAsCollection: aClass [

	^ (aClass includesBehavior: Collection) and: [
		  (self atomicCollectionTypes includes: aClass) not ]
]

{ #category : #copying }
UGTypePossibilities >> , otherTypePossibilities [

	^ self class
		  for: item
		  types: possibleTypes , otherTypePossibilities possibleTypes
		  collectionElementTypes: possibleCollectionElementTypes
			  , otherTypePossibilities possibleCollectionElementTypes
]

{ #category : #adding }
UGTypePossibilities >> addPossibleCollectionType: aCollectionClass withElementType: anElementClass [

	(aCollectionClass isNil or: [
		 aCollectionClass == UndefinedObject or: [
			 (aCollectionClass includesBehavior: Collection) not ] ]) ifTrue: [
		^ self error: 'Trying to save non-collection as a collection type' ].
	possibleTypes add: (self replacementOfClass: aCollectionClass).
	anElementClass ifNil: [ ^ self ].
	anElementClass == UndefinedObject ifTrue: [ ^ self ].
	possibleCollectionElementTypes add:
		(self replacementOfClass: anElementClass)
]

{ #category : #accessing }
UGTypePossibilities >> addPossibleType: aClass [

	aClass ifNil: [ ^ self ].
	aClass == UndefinedObject ifTrue: [ ^ self ].
	possibleTypes add: (self replacementOfClass: aClass)
]

{ #category : #testing }
UGTypePossibilities >> includesCollectionType [

	^ possibleTypes anySatisfy: [ :any |
		  self class shouldTypeAsCollection: any ]
]

{ #category : #testing }
UGTypePossibilities >> includesObjectType [

	^ possibleTypes anySatisfy: [ :any | any == Object ]
]

{ #category : #initialization }
UGTypePossibilities >> initialize [

	super initialize.
	possibleTypes := Set new.
	possibleCollectionElementTypes := Set new
]

{ #category : #testing }
UGTypePossibilities >> isCollection [

	^ possibleTypes isNotEmpty and: [
		  possibleTypes allSatisfy: [ :any |
			  self class shouldTypeAsCollection: any ] ]
]

{ #category : #testing }
UGTypePossibilities >> isFullyKnown [
	"Answer true if we know the type and if it is a collection, we also know type of elements"

	self isFullyUnknown ifTrue: [ ^ false ].
	(possibleTypes noneSatisfy: [ :each |
		 self class shouldTypeAsCollection: each ]) ifTrue: [ ^ true ].
	possibleCollectionElementTypes ifEmpty: [ ^ true ].
	possibleCollectionElementTypes size > 1 ifTrue: [ ^ true ].
	^ possibleCollectionElementTypes anyOne ~= Object
]

{ #category : #testing }
UGTypePossibilities >> isFullyUnknown [
	"Answer true if we do not know anything about the type"

	possibleTypes ifEmpty: [ ^ true ].
	(possibleTypes size = 1 ifTrue: [ possibleTypes anyOne == Object ])
		ifTrue: [ ^ true ].
	^ false
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
UGTypePossibilities >> possibleCollectionElementTypes [
	^ possibleCollectionElementTypes
]

{ #category : #accessing }
UGTypePossibilities >> possibleCollectionElementTypes: aCollectionOfTypes [

	possibleCollectionElementTypes := (aCollectionOfTypes reject: [ :each |
		                                   each isNil or: [
			                                   each == UndefinedObject ] ])
		                                  collect: [ :each |
		                                  self replacementOfClass: each ]
		                                  as: Set
]

{ #category : #accessing }
UGTypePossibilities >> possibleTypes [
	^ possibleTypes
]

{ #category : #accessing }
UGTypePossibilities >> possibleTypes: aCollectionOfTypes [

	possibleTypes := Set new.

	aCollectionOfTypes do: [ :each | self addPossibleType: each ]
]

{ #category : #printing }
UGTypePossibilities >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: Character space.
	possibleTypes printElementsOn: aStream.
	possibleCollectionElementTypes printElementsOn: aStream
]

{ #category : #transforming }
UGTypePossibilities >> reducedToCommonSuperclass [

	^ self class
		  for: item
		  types: (Set with: (self class commonSuperclassOf: possibleTypes))
		  collectionElementTypes: (Set with:
				   (self class commonSuperclassOf: possibleCollectionElementTypes))
]

{ #category : #private }
UGTypePossibilities >> replacementOfClass: aClass [
	^ self class classReplacements at: aClass ifAbsent: [ aClass ]
]
