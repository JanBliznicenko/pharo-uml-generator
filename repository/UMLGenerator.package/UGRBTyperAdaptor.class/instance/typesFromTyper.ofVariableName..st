private
typesFromTyper: aTyper ofVariableName: aVariableName
	^ self filterTypes: ((aTyper guessTypesFor: aVariableName) collect: #realClass) asSet