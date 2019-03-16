as yet unclassified
prepareLinks
	| assignmentLink returnLink returnSelfLink |
	
	assignmentLink := MetaLink new
		metaObject: [ :node :value | 
			Transcript
				show:
					'assigned ' , value asString , ' ('
						, value className , ') to '
						, node variable name asString;
				cr ];
		selector: #value:value:;
		arguments: #(node value);
		control: #after.
		
	returnLink := MetaLink new
		metaObject: [ :node :value | 
			Transcript
				show:
					'returned ' , value asString , ' ('
						, value className , ')';
				cr ];
		selector: #value:value:;
		arguments: #(node value);
		control: #before.
		
	returnSelfLink := MetaLink new
		metaObject: [ :node :class | 
			Transcript
				show:
					'returned self ('
						, class name , ')';
				cr ];
		selector: #value:value:;
		arguments: #(node class);
		control: #after.
		
	'ExamplePackage' asPackage definedClasses
		do: [ :eachClass | 
			eachClass methods
				do: [ :eachMethod | 
					eachMethod ast lastIsReturn ifFalse: [eachMethod ast link: returnSelfLink].
					eachMethod ast allChildren select: [ :eachNode | eachNode isReturn ] thenDo: [ :eachNode | eachNode link: returnLink ].
					eachMethod ast assignmentNodes
						select: [ :eachNode | eachNode variable isInstance ]
						thenDo: [ :eachNode | eachNode link: assignmentLink ] ] ].
				
	ExampleClass new
		method2;
		method2.
		
	assignmentLink uninstall.
	returnLink uninstall.
	returnSelfLink uninstall.