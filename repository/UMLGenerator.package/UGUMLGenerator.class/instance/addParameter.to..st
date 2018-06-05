adding
addParameter: aParameterName to: umlMethod
	umlMethod ownedParameters
		add:
			(OPUMLParameter new
				name: aParameterName;
				"type: (umlClasses at: Object);"
				direction: OPUMLParameterDirectionKind in)