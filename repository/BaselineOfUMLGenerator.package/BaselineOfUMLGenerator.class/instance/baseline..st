baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'OPUMLXMI'
					with: [ spec repository: 'github://openponk/uml-xmi/repository' ];
				baseline: 'RoelTyper'
					with: [ spec repository: 'github://RMODINRIA/RoelTyper/src' ];
				baseline: 'J2Inferer'
					with: [ spec repository: 'github://tesonep/j2Inferer/mc' ].
			spec package: 'UMLGenerator' with: [ spec requires: #('OPUMLXMI' 'RoelTyper' 'J2Inferer') ].
			spec
				package: 'UMLOpenPonkExtension'
				with: [ spec requires: #('UMLGenerator') ].
			spec group: 'core' with: #('UMLGenerator').
			spec group: 'default' with: #('core' 'UMLOpenPonkExtension')].