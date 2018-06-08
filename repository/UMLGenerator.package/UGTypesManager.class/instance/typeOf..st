retrieving
typeOf: anItem
	^ knownTypes at: anItem ifAbsent: [ anItem acceptVisitor: self ]