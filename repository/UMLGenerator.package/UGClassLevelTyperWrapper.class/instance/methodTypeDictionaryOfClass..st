private
methodTypeDictionaryOfClass: aClass
	^ aClass selectors
		flatCollect: [ :eachSelector | self typeDictionaryOfMethod: (UGMethod named: eachSelector in: aClass) ]
		as: Dictionary