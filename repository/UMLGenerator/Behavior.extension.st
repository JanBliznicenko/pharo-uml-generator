Extension { #name : #Behavior }

{ #category : #'*UMLGenerator' }
Behavior >> recompileAndIncludeTraitMethods [

	self methods do: [ :each | self compile: each sourceCode ]
]
