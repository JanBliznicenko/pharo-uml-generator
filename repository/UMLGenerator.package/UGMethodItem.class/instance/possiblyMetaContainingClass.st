accessing
possiblyMetaContainingClass
	self isClassSide
		ifTrue: [ ^ self containingClass class ].
	^ self containingClass