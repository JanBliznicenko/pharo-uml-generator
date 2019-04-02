adding
addGeneralizationSetTo: aSuperclass
	| set subclasses |
	subclasses := aSuperclass subclasses
		select: [ :eachSubclass | umlClasses includesKey: eachSubclass ].
	subclasses ifEmpty: [ ^ self ].
	set := OPUMLGeneralizationSet new
		name: 'Subclasses of ' , aSuperclass name;
		isDisjoint: true;
		generalizations:
			(subclasses
				collect: [ :eachSubclass | 
					OPUMLGeneralization new
						general: (umlClasses at: aSuperclass);
						specific: (umlClasses at: eachSubclass);
						yourself ]).
	encompassingPackage packagedElements add: set