*UMLGenerator
saveXmlTo: aFileName
	aFileName asFileReference
		writeStreamDo: [ :s | OPXMIWriter write: (OPUMLXMIWriter new write: self) to: s ]