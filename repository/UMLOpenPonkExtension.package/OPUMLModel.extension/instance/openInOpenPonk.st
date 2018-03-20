*UMLOpenPonkExtension
openInOpenPonk
	| project |
	project := OPUmlProject new name: self name.
	self packagedElements do: [ :each | project addModel: each ].
	project open.
		