initialization
createReturnLinkBlock
	returnLinkBlock := [ :methodName :class | 
	MetaLink new
		metaObject: [ :value | 
			self
				add: value class
				asPossibleTypeOf: (UGReturnParameter in: (UGMethod named: methodName in: class)) ];
		selector: #value:;
		arguments: #(value);
		control: #before ]