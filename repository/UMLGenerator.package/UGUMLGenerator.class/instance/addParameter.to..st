private
addParameter: aParameterName to: umlMethod
	umlMethod ownedParameters
		add:
			(OPUMLParameter new
				name: aParameterName;
				direction: OPUMLParameterDirectionKind in)