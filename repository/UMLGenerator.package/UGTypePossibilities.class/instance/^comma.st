copying
, otherTypePossibilities
	^ UGTypePossibilities
		for: item
		types: possibleTypes , otherTypePossibilities possibleTypes
		collectionTypes: possibleCollectionTypes , otherTypePossibilities possibleCollectionTypes