as yet unclassified
simpleTypesFromTyper: aTyper ofVariable: aUGVariable
	^ self
		filterTypes:
			((aTyper guessTypesFor: aUGVariable variableName)
				collect: #realClass
				thenReject: [ :each | each includesBehavior: Collection ]) asSet