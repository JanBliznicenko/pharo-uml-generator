instance creation
newReturnParameter
	^ super newReturnParameter uuid: 'EAID_RT000000_' , (UUID new asString allButFirst: 9)