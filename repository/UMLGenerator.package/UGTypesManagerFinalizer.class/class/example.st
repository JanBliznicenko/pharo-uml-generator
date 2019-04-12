example
example
	^ UGEnterpriseArchitectUMLGenerator new
		typesManager: self new;
		importFromPackagesNamed: #('Zinc-HTTP')