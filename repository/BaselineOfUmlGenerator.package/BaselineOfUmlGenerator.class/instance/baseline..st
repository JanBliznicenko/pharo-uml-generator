baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'ClassEditor'
					with: [ spec repository: 'github://dynacase/class-editor:pharo6.1_fix/repository' ];
				baseline: 'UMLMetamodel'
					with: [ spec repository: 'github://openponk/uml-metamodel/repository' ].
			spec package: 'UmlGenerator' with: [ spec requires: #('UMLMetamodel') ].
			spec group: 'core' with: #('UmlGenerator').
			spec group: 'dev' with: #('ClassEditor' 'core').
			spec group: 'development' with: #('dev').
			spec group: 'default' with: #('dev') ]