*UMLOpenPonkExtension
openInOpenPonk
	| project elementCount packageCount |
	project := OPUmlProject new name: self name.
	elementCount := self packagedElements size.
	packageCount := self packagedElements count: [ :each | each isKindOf: OPUMLPackage ].
	elementCount > packageCount
		ifTrue: [ project addModel: self ]
		ifFalse: [ self packagedElements do: [ :each | project addModel: each ] ].
	project open