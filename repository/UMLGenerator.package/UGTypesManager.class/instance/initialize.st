initialization
initialize
	super initialize.
	knownTypes := Dictionary new.
	persistence := UGTypesNoPersistence new.
	typerAdapters := self class typerClasses collect: [ :each | each default ].
	autoSave := false.
	self defaultBlockForVariable