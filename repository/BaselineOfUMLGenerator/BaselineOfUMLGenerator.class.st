Class {
	#name : #BaselineOfUMLGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfUMLGenerator
}

{ #category : #baselines }
BaselineOfUMLGenerator >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'OPUMLXMI'
			with: [ spec repository: 'github://openponk/uml-xmi/repository' ];
			baseline: 'RoelTyper'
			with: [ spec repository: 'github://RMODINRIA/RoelTyper/src' ];
			baseline: 'J2Inferer'
			with: [ spec repository: 'github://JanBliznicenko/j2Inferer/mc' ];
			baseline: 'MetaLinksToolkit'
			with: [
				spec repository:
						'github://JanBliznicenko/metalinks-toolkit/repository' ].
		spec package: 'UMLGenerator' with: [
			spec requires:
				#( 'OPUMLXMI' 'RoelTyper' 'J2Inferer' 'MetaLinksToolkit' ) ].
		spec
			package: 'UMLGeneratorGUI'
			with: [ spec requires: #( 'UMLGenerator' ) ].
		spec group: 'GUI' with: #( 'UMLGeneratorGUI' ).
		spec group: 'default' with: #( 'UMLGenerator' ) ]
]
