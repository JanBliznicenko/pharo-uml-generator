generator - attribute
createAttributeNamed: aSymbol in: aClass
	| multiplicity |
	multiplicity := self multiplicityFor: aSymbol in: aClass.
	^ OPUMLProperty new
		name: aSymbol;
		type: (self attributeTypeFor: aSymbol in: aClass);
		lowerValue: multiplicity lowerValue;
		upperValue: multiplicity upperValue;
		yourself