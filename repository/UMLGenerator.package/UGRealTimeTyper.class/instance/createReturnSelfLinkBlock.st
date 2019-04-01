initialization
createReturnSelfLinkBlock
	returnSelfLinkBlock := [ :methodName :class | 
	MetaLink new
		metaObject: [ self
				add: class
				asPossibleTypeOf: (UGReturnParameter in: (UGMethod named: methodName in: class)) ];
		control: #after ]