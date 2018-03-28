adding
addReturnParameterTo: umlMethod
	umlMethod ownedParameters
		add:
			(OPUMLParameter new
				name: 'return';
				type: (umlClasses at: Object);
				direction: OPUMLParameterDirectionKind return)