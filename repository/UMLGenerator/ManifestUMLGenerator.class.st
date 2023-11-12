"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestUMLGenerator,
	#superclass : #PackageManifest,
	#category : 'UMLGenerator'
}

{ #category : #'code-critics' }
ManifestUMLGenerator class >> ruleFloatReferencesRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#UGTypePossibilities #replacementOfClass: #false)) #'2019-04-02T09:34:40.827817+02:00') )
]

{ #category : #'code-critics' }
ManifestUMLGenerator class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#UGRealTimeTyper #addLinksToPackageNamed: #false)) #'2019-04-01T12:10:30.703418+02:00') )
]
