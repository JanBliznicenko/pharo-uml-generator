Extension { #name : #Collection }

{ #category : #'*UMLGenerator' }
Collection >> commonClassesSuperclass [
	"Answer the most specific common super class of the receiver's
	elements, returns Object on empty collections. Expects collection of classes. For collection of instances use commonSuperclass"

	| common |
	self isEmpty
		ifTrue: [ ^ Object ].
	common := self anyOne.
	self
		do: [ :each | 
			Object == common
				ifTrue: [ ^ Object ].
			[ each includesBehavior: common ]
				whileFalse: [ common ifNil: [ ^ Object ].
					common := common superclass ] ].
	^ common
]
