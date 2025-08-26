"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestUMLGenerator',
	#superclass : 'PackageManifest',
	#category : 'UMLGenerator',
	#package : 'UMLGenerator'
}

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleAnySatisfyRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#UGTyperChainingCombinator #combine: #false)) #'2024-07-30T22:19:21.069+02:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleFloatReferencesRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#UGTypePossibilities #replacementOfClass: #false)) #'2019-04-02T09:34:40.827817+02:00') #(#(#RGMethodDefinition #(#'UGTypePossibilities class' #classReplacements #true)) #'2024-07-30T13:20:08.937+02:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestUMLGenerator class' #ManifestUMLGenerator)) #'2024-07-31T09:43:55.048+02:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#UGRealTimeTyper #addLinksToPackageNamed: #false)) #'2019-04-01T12:10:30.703418+02:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#UGTyperUnionCombinator #combine: #false)) #'2024-07-30T22:16:33.164+02:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleUsesAddRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#UGRealTimeTyper #addLinksToPackageNamed: #false)) #'2023-11-12T14:33:36.612+01:00') )
]

{ #category : 'code-critics' }
ManifestUMLGenerator class >> ruleUsesTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'UGTypePossibilities class' #classReplacements #true)) #'2024-07-30T13:20:05.994+02:00') )
]
