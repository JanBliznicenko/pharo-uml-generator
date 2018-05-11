private
typeDictionaryOfMethod: aMethod
	^ (aMethod parameters collect: [ :eachParameter | eachParameter -> (self possibleTypesOfParameter: eachParameter) ]) asDictionary