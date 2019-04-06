private
replacementOfClass: aClass
	^ self class classReplacements at: aClass ifAbsent: [ aClass ]