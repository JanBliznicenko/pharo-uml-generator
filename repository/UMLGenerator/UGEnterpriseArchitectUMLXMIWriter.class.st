Class {
	#name : 'UGEnterpriseArchitectUMLXMIWriter',
	#superclass : 'OPUMLXMIWriter',
	#category : 'UMLGenerator-Generator',
	#package : 'UMLGenerator',
	#tag : 'Generator'
}

{ #category : 'writing' }
UGEnterpriseArchitectUMLXMIWriter >> write: anElement [
	| document rootElement |
	unresolved := OrderedCollection new.
	identityCache := IdentityDictionary new.
	document := OPXMIObjectElement new.
	document xmiName: 'xmi:XMI'.
	rootElement := self writeElement: anElement.
	rootElement xmiName: 'uml:' , anElement umlMetaClass name.
	document
		containedItems:
			{(OPXMIValueAttribute xmiName: 'xmlns:uml' value: 'http://www.omg.org/spec/UML/20131001').
			(OPXMIValueAttribute xmiName: 'xmlns:xmi' value: 'http://www.omg.org/spec/XMI/20131001').
			(OPXMIValueAttribute xmiName: 'xmi:version' value: '2.5')}
				,
					{(OPXMIObjectElement new
						xmiName: 'xmi:Documentation';
						containedItems:
							{(OPXMIValueAttribute xmiName: 'exporter' value: 'Enterprise Architect').
							(OPXMIValueAttribute xmiName: 'exporterVersion' value: '6.5')})} , {rootElement}
				, self resolvedStereotypes.
	self resolveReferences.
	^ document
]
