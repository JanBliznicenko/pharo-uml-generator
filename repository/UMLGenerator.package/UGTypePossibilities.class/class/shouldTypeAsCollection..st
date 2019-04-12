accessing
shouldTypeAsCollection: aClass
	^ (aClass includesBehavior: Collection)
		and: [ (UGTypePossibilities atomicCollectionTypes includes: aClass) not ]