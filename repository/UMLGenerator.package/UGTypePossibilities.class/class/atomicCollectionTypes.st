accessing
atomicCollectionTypes
	^ atomicCollectionTypes
		ifNil: [ atomicCollectionTypes := {BitmapCharacterSet.
			CharacterSet.
			CharacterSetComplement.
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
			RunArray} asSet flatCollect: [ :each | each withAllSubclasses ] ]