*UMLGenerator
classes
	| results remainings |
	results := Set new: minClasses size.
	minClasses
		do: [ :c | 
			(minClasses includesAny: c superclasses)
				ifFalse: [ results add: c ] ].
	remainings := results asOrderedCollection.
	[ remainings isEmpty ]
		whileFalse: [ | c siblings |
			c := remainings first.
			c superclass
				ifNil: [ remainings remove: c.
					results remove: c ]
				ifNotNil: [ siblings := c analysedClass superclass subclasses.
					(results includesAll: siblings)
						ifTrue: [ c analysedClass superclass = Trait
								ifTrue: [ remainings
										removeAllSuchThat: [ :each | each analysedClass superclass = Trait ].
									results
										removeAllSuchThat: [ :each | each analysedClass superclass = Trait ] ]
								ifFalse: [ remainings removeAllFoundIn: siblings.
									results removeAllFoundIn: siblings ].
							results add: c superclass.
							remainings add: c superclass ]
						ifFalse: [ remainings remove: c ] ] ].
	^ results