private
rootClasses
	^ rootClasses
		ifNil: [ rootClasses := {Object.
			ProtoObject.
			ClassDescription.
			Class.
			Metaclass} asSet.
			rootClasses
				addAll: (rootClasses collect: #class);
				yourself ]