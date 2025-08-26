Class {
	#name : 'UGEnterpriseArchitectUMLGenerator',
	#superclass : 'UGPackagingUMLGenerator',
	#category : 'UMLGenerator-Generator',
	#package : 'UMLGenerator',
	#tag : 'Generator'
}

{ #category : 'initialization' }
UGEnterpriseArchitectUMLGenerator >> initialize [
	super initialize.
	encompassingPackage := OPUMLPackage new.
	encompassingPackage name: 'Generated UML'.
	model packagedElements add: encompassingPackage
]

{ #category : 'instance creation' }
UGEnterpriseArchitectUMLGenerator >> newReturnParameter [
	^ super newReturnParameter uuid: 'EAID_RT000000_' , (UUID new asString allButFirst: 9)
]

{ #category : 'hooks' }
UGEnterpriseArchitectUMLGenerator >> umlXmiWriter [
	^ UGEnterpriseArchitectUMLXMIWriter
]
