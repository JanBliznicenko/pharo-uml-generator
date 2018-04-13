*UMLGenerator
refineTypesByLookingAtAssignments
	| searcher needsSearch |
	needsSearch := false.
	searcher := RBParseTreeSearcher new.
	variableTypes
		keysAndValuesDo: [ :key :value | 
			(key beginsWith: '--')
				ifFalse: [ needsSearch := true.
					searcher
						matches:
							
									(key first = $-
										ifTrue: [ key copyFrom: 2 to: key size - 1,' `@message: ``@object' ]
										ifFalse: [ key
								,' := ``@object' ])
						do: [ :aNode :answer | self guessTypeFromAssignment: aNode ] ] ].
	needsSearch
		ifTrue: [ self executeSearch: searcher ]