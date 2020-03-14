*UMLGenerator
returnTypeFor: message onContext: aContext alreadyEvaluated: anObject
	^ J2Type
		withClasses:
			(aContext contents
				collect: [ :e | inferer typeInfoFor: e analysedClass instanceSide ])