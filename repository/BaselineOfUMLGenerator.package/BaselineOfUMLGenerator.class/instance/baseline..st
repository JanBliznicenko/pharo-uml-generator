baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'ClassEditor'
					with: [ spec repository: 'github://openponk/class-editor/repository' ];
				baseline: 'UMLMetamodel'
					with: [ spec repository: 'github://openponk/uml-metamodel/repository' ];
				baseline: 'RoelTyper'
					with: [ spec repository: 'github://RMODINRIA/RoelTyper/src' ];
				baseline: 'J2Inferer'
					with: [ spec repository: 'github://tesonep/j2Inferer/mc' ].
			spec package: 'UMLGenerator' with: [ spec requires: #('UMLMetamodel' 'RoelTyper' 'J2Inferer') ].
			spec
				package: 'UMLOpenPonkExtension'
				with: [ spec requires: #('UMLGenerator' 'ClassEditor') ].
			spec group: 'core' with: #('UMLGenerator').
			spec group: 'default' with: #('core' 'UMLOpenPonkExtension') ]