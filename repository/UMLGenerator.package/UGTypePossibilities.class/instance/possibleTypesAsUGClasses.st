converting
possibleTypesAsUGClasses
	^ possibleTypes collect: [ :each | UGClass for: each ] as: OrderedCollection