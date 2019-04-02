adding
addLinksToPackageNamed: aPackageName
	| package |
	package := aPackageName asPackage.
	(linkedPackages includes: package)
		ifTrue: [ ^ self ].
	package definedClasses
		do: [ :eachClass | 
			eachClass methods
				do: [ :eachMethod | 
					eachMethod ast link: (links add: (argumentsLinkBlock value: eachMethod)).
					eachMethod ast assignmentNodes
						select: [ :eachNode | eachNode variable isInstance ]
						thenDo:
							[ :eachNode | eachNode link: (links add: (assignmentLinkBlock value: eachClass)) ].
					eachMethod ast allChildren
						select: [ :eachNode | eachNode isReturn ]
						thenDo: [ :eachNode | 
							eachNode
								link:
									(links
										add: (returnLinkBlock value: eachMethod selector value: eachClass)) ].
					eachMethod ast lastIsReturn
						ifFalse: [ eachMethod ast
								link:
									(links
										add: (returnSelfLinkBlock value: eachMethod selector value: eachClass)) ] ] ]