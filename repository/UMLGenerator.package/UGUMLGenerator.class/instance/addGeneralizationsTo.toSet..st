public - importer
addGeneralizationsTo: aSuperclass toSet: aGeneralizationSet
	aSuperclass subclasses
		select: [ :eachSubclass | umlClasses includesKey: eachSubclass ]
		thenDo: [ :eachSubclass | 
			aGeneralizationSet generalizations
				add:
					(OPUMLGeneralization new
						general: (umlClasses at: aSuperclass);
						specific: (umlClasses at: eachSubclass);
						yourself) ]