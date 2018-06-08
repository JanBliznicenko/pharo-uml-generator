instance creation
default
	^ default ifNil: [ default := self withFile: 'default.typeinfo.ston' ]