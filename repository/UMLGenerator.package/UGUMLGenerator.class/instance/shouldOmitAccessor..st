private
shouldOmitAccessor: aMethod
	| protocol varNames selector |
	includeAccessors
		ifTrue: [ ^ false ].
	protocol := aMethod protocol.
	((protocol beginsWith: 'access') or: [ protocol endsWith: 'accessing' ])
		ifFalse: [ ^ false ].
	varNames := aMethod methodClass allInstVarNames asSet, aMethod methodClass allClassVarNames asSet.
	selector := aMethod selector.
	selector last = $:
		ifTrue: [ selector := selector allButLast ].
	^ varNames includes: selector