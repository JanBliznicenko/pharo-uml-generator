Extension { #name : 'Behavior' }

{ #category : '*UMLGenerator' }
Behavior >> includeTraitMethods [

	self methods
		select: #isFromTrait
		thenDo: [ :each | self compile: each sourceCode ]
]

{ #category : '*UMLGenerator' }
Behavior >> recompileAndIncludeTraitMethods [

	self methods do: [ :each | self compile: each sourceCode ]
]
