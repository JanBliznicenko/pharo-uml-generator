accessing
saveXmlTo: aFileName
	aFileName asFileReference
		ensureDelete;
		writeStreamDo: [ :s | OPXMIWriter write: (self umlXmiWriter new write: model) to: s ]