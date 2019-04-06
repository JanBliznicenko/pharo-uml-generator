accessing
shouldTypeAsCollection: aClass
	^ aClass == Collection
		or: [ (aClass inheritsFrom: Collection)
				and: [ (UGTypePossibilities atomicCollectionTypes includes: aClass) not ] ]