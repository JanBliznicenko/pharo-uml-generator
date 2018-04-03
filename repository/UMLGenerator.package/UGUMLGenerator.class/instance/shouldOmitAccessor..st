private
shouldOmitAccessor: aMethod
	| protocol varNames selector |
	includeAccessors
		ifFalse: [ ^ false ].
	protocol := aMethod protocol.
	((protocol beginsWith: 'access') or: [ protocol endsWith: 'accessing' ])
		ifFalse: [ ^ false ].
	varNames := aMethod methodClass allInstVarNames , aMethod methodClass allClassVarNames.
	selector := aMethod selector.
	selector last = $:
		ifTrue: [ selector := selector allButLast ].
	^ varNames includes: selector