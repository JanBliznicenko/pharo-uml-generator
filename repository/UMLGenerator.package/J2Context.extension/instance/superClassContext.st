*UMLGenerator
superClassContext
	^ self class with: (self contents collect: #superclass thenSelect: #isNotNil)