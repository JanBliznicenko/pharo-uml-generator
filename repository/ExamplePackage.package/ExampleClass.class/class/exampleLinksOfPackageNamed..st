as yet unclassified
exampleLinksOfPackageNamed: aPackageName
	| assignmentLink returnLink returnSelfLink argumentsLink |
	assignmentLink := MetaLink new
		metaObject: [ :node :value | 
			Transcript
				show:
					'assigned ' , value asString , ' (' , value className , ') to '
						, node variable name asString;
				cr ];
		selector: #value:value:;
		arguments: #(node value);
		control: #after.
	returnLink := MetaLink new
		metaObject: [ :node :value | 
			Transcript
				show: 'returned ' , value asString , ' (' , value className , ')';
				cr;
				cr ];
		selector: #value:value:;
		arguments: #(node value);
		control: #before.
	returnSelfLink := MetaLink new
		metaObject: [ :node :class | 
			Transcript
				show: 'returned self (' , class name , ')';
				cr;
				cr ];
		selector: #value:value:;
		arguments: #(node class);
		control: #after.
	argumentsLink := MetaLink new
		metaObject: [ :selector :arguments | 
			arguments
				ifEmpty: [ Transcript show: selector , ' received no arguments' ]
				ifNotEmpty: [ Transcript show: selector , ' received arguments '.
					arguments
						do: [ :each | Transcript show: each asString , ' (' , each className , ')' ]
						separatedBy: [ Transcript show: ', ' ] ].
			Transcript cr ];
		selector: #value:value:;
		arguments: #(selector arguments);
		control: #before.
	aPackageName asPackage definedClasses
		do: [ :eachClass | 
			eachClass methods
				do: [ :eachMethod | 
					eachMethod ast link: argumentsLink.
					eachMethod ast lastIsReturn
						ifFalse: [ eachMethod ast link: returnSelfLink ].
					eachMethod ast allChildren
						select: [ :eachNode | eachNode isReturn ]
						thenDo: [ :eachNode | eachNode link: returnLink ].
					eachMethod ast assignmentNodes
						select: [ :eachNode | eachNode variable isInstance ]
						thenDo: [ :eachNode | eachNode link: assignmentLink ] ] ].
	ExampleClass new
		method2;
		method1: 4 and: 2.
	assignmentLink uninstall.
	returnLink uninstall.
	returnSelfLink uninstall.
	argumentsLink uninstall