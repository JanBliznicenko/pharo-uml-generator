converting
asLatexTables
	^ String
		streamContents: [ :s | 
			s << self packageName << ' & ' << self itemCount asString.
			self
				foundCountsDo: [ :each | 
					s << ' & ' << each asString << ' ('.
					each * 100 / self itemCount printOn: s showingDecimalPlaces: 1.
					s << ' \%)' ].
			s << ' \\' ]