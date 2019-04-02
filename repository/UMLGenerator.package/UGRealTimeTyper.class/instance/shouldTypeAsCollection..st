adding
shouldTypeAsCollection: aValue
	^ aValue isCollection
		and: [ ((atomicCollectionTypes
				ifNil: [ atomicCollectionTypes := {BitmapCharacterSet.
					CharacterSet.
					CharacterSetComplement.
					Matrix.
					ByteArray.
					ColorArray.
					FFIExternalArray.
					FloatArray.
					IntegerArray.
					ShortIntegerArray.
					SparseLargeTable.
					String.
					Text.
					WordArray.
					Interval.
					Semaphore.
					ProcessList.
					RunArray} asSet flatCollect: [ :each | each withAllSubclasses ] ]) includes: aValue class) not ]