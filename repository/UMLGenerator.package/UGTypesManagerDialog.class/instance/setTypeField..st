initialization
setTypeField: aClassItem
	aClassItem ifNil: [ ^ typeField text: '' ].
	typeField text: aClassItem itemName.
	typeCollectionCheck state: aClassItem isCollectionClass