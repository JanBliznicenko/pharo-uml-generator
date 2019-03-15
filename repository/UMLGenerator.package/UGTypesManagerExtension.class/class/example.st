example
example
	^ UGEnterpriseArchitectUMLGenerator new
		typesManager: self new;
		importFromPackagesNamed: #('Announcements-Core')