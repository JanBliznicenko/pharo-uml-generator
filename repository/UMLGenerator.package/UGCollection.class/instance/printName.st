printing
printName
	collectionRealClass ifNil: [ ^ '*' , self itemName ].
	^ collectionRealClass name , '<' , self itemName , '>'