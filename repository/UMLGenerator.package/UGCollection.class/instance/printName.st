printing
printName
	| name |
	name := '*' , self itemName.
	collectionRealClass ifNil: [ ^ name ].
	^ name , '*' , collectionRealClass name