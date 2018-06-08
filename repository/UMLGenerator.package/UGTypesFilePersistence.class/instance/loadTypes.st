persistence
loadTypes
	| s result |
	file exists
		ifFalse: [ ^ Dictionary new ].
	file isReadable
		ifFalse: [ self error: 'Failed to read file ' , file fullName ].
	s := file readStream.
	result := STON fromStream: s.
	s close.
	^ result