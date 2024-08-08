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
			with: [ spec repository: 'github://JanBliznicenko/RoelTyper/src' ];
			baseline: 'J2Inferer'
			with: [ spec repository: 'github://JanBliznicenko/j2Inferer/mc' ];
			baseline: 'MetaLinksToolkit'
			with: [
				spec repository:
						'github://JanBliznicenko/metalinks-toolkit/repository' ];
			baseline: 'XPath'
			with: [ spec repository: 'github://pharo-contributions/XML-XPath' ].
		spec package: 'UMLGenerator' with: [
			spec requires:
				#( 'OPUMLXMI' 'RoelTyper' 'J2Inferer' 'MetaLinksToolkit' ) ].
		spec
			package: 'UMLGeneratorGUI'
			with: [ spec requires: #( 'UMLGenerator' ) ].
		spec group: 'GUI' with: #( 'UMLGeneratorGUI' ).
		spec group: 'default' with: #( 'UMLGenerator' ).
		spec group: 'statistics' with: #( 'default' 'XPath' ) ]
]
