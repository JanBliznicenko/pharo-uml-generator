initialization
createArgumentsLinkBlock
	argumentsLinkBlock := [ :method | 
	| class methodName argumentNames |
	class := method methodClass.
	methodName := method selector.
	argumentNames := method argumentNames.
	MetaLink new
		metaObject: [ :arguments | 
			arguments
				ifNotEmpty: [ arguments
						withIndexDo: [ :each :index | 
							self
								addTypeOf: each
								asPossibleTypeOf:
									(UGInputMethodParameter
										named: (argumentNames at: index)
										in: (UGMethod named: methodName in: class)) ] ] ];
		selector: #value:;
		arguments: #(arguments);
		control: #before ]