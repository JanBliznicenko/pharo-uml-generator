initialization
initializeText
	| applicants applicantsSet |
	typeField := self instantiate: TextInputFieldModel.
	typeField autoAccept: true.
	applicants := (Array
		streamContents: [ :strm | 
			Symbol
				allSymbolTablesDo: [ :each | 
					(each notEmpty
						and: [ each first canBeGlobalVarInitial and: [ Smalltalk globals includesKey: each ] ])
						ifTrue: [ strm nextPut: each ] ] ]) sort.
	applicantsSet := applicants asSet.
	typeField
		entryCompletion:
			(EntryCompletion new
				dataSourceBlock: [ :currText | applicants ];
				filterBlock: [ :currApplicant :currText | 
					currText size > 2
						and: [ currApplicant asLowercase includesSubstring: currText asString asLowercase ] ]).
	typeField
		whenTextChanged: [ :text | 
			(applicantsSet includes: text asSymbol)
				ifTrue: [ self selectedInText ]
				ifFalse: [ self deselect ] ]