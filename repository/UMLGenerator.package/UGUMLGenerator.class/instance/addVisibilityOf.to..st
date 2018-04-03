private
addVisibilityOf: aMethod to: umlMethod
	| protocol |
	protocol := aMethod protocol.
	umlMethod
		visibility:
			(((protocol beginsWith: 'private')
				or: [ (protocol endsWith: 'private')
						or: [ (protocol beginsWith: 'protected') or: [ protocol endsWith: 'protected' ] ] ])
				ifTrue: [ OPUMLVisibilityKind protected ]
				ifFalse: [ OPUMLVisibilityKind public ])