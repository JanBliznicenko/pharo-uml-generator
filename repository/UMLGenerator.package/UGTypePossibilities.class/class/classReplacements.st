accessing
classReplacements
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