initialization
initialize
	super initialize.
	persistence := UGTypesNoPersistence new.
	typerAdapters := self class typerClasses collect: [ :each | each default ].
	self defaultBlockForVariable