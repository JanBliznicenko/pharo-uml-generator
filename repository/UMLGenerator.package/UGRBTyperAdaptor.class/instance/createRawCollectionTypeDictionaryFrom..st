private
createRawCollectionTypeDictionaryFrom: aTypeDictionary
	^ (aTypeDictionary keys
		collect: [ :variable | 
			variable
				->
					(self
						possibleTypesOfVariable: (UGVariable named: '-' , variable variableName , '-' in: variable containingClass)) ])
		asDictionary