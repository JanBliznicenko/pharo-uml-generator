initialization
createAssignmentLinkBlock
	assignmentLinkBlock := [ :class | 
	MetaLink new
		metaObject: [ :node :value | 
			self
				addTypeOf: value
				asPossibleTypeOf: (UGVariable named: node variable name asString in: class) ];
		selector: #value:value:;
		arguments: #(node value);
		control: #after ]