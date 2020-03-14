*UMLGenerator
receivingContextOn: aContext
	^ J2Context with: (receiver minClassesInContext: aContext)