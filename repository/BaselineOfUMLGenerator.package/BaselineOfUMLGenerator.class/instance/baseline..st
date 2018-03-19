baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
			project: 'Fame' with: [
				spec
					className: #ConfigurationOfFame;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Fame/main' ];
			project: 'Famix' with: [
				spec
					className: #ConfigurationOfFamix;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/Famix/main' ];"
			project: 'PetitParser' with: [
				spec
					className: #ConfigurationOfPetitParser;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Moose/PetitParser/main' ];
			baseline: 'PetitParser2' with: [
				spec
				 	repository: 'github://kursjan/petitparser2' ];
			project: 'PetitSmalltalk' with: [
				spec
					className: #ConfigurationOfPetitSmalltalk;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/PetitParser/main/' ];"
				baseline: 'ClassEditor'
					with: [ spec repository: 'github://openponk/class-editor/repository' ];
				baseline: 'UMLMetamodel'
					with: [ spec repository: 'github://openponk/uml-metamodel/repository' ];
				package: 'Moose-Core'
					with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main' ];
				package: 'Moose-GenericImporter'
					with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
							requires: #('Moose-Core') ];
				package: 'Moose-SmalltalkImporter'
					with: [ spec repository: 'http://www.smalltalkhub.com/mc/Moose/Moose/main';
							requires: #('Moose-GenericImporter' 'Famix') ].
			spec package: 'UMLGenerator' with: [ spec requires: #('UMLMetamodel' 'Moose-SmalltalkImporter') ].
			spec group: 'core' with: #('UMLGenerator').
			spec group: 'default' with: #('core' 'ClassEditor') ]