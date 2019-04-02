private
replacementOfClass: aClass
	^ (classReplacements
		ifNil: [ classReplacements := {(ByteString -> String).
			(WideString -> String).
			(ByteSymbol -> Symbol).
			(WideSymbol -> Symbol).
			(BoxedFloat64 -> Float).
			(SmallFloat64 -> Float).
			(LargeInteger -> Integer).
			(LargeNegativeInteger -> Integer).
			(LargePositiveInteger -> Integer).
			(SmallInteger -> Integer)} asDictionary ]) at: aClass ifAbsent: [ aClass ]