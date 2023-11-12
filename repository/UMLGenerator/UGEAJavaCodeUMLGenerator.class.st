Class {
	#name : #UGEAJavaCodeUMLGenerator,
	#superclass : #UGEnterpriseArchitectUMLGenerator,
	#instVars : [
		'methodNameReplacements'
	],
	#category : 'UMLGenerator-Generator'
}

{ #category : #private }
UGEAJavaCodeUMLGenerator >> addPackageNamed: aPackageName to: anEncompassingPackage [
	^ super addPackageNamed: (self packageNameFrom: aPackageName) to: anEncompassingPackage
]

{ #category : #conversions }
UGEAJavaCodeUMLGenerator >> classNameFrom: aString [
	^ aString
]

{ #category : #testing }
UGEAJavaCodeUMLGenerator >> isPackageNamed: packageName equalTo: umlPackage [
	^ (umlPackage isKindOf: OPUMLPackage)
		and: [ umlPackage name = (self packageNameFrom: packageName) ]
]

{ #category : #conversions }
UGEAJavaCodeUMLGenerator >> methodNameFrom: aString [
	methodNameReplacements
		ifNil: [ methodNameReplacements := {('<' -> 'isLessThan').
			('>' -> 'isMoreThan').
			('<=' -> 'isLessOrEqualTo').
			('>=' -> 'isMoreOrEqualTo').
			('=' -> 'isEqualTo').
			('~=' -> 'isDifferentTo').
			(',' -> 'concatenate').
			('+' -> 'plus').
			('-' -> 'minus').
			('*' -> 'times').
			('/' -> 'dividedBy').
			('<<' -> 'nextPut').
			('>>' -> 'readInto')} asDictionary ].
	^ methodNameReplacements
		at: aString
		ifAbsent: [ (aString last = $:
				ifTrue: [ aString allButLast ]
				ifFalse: [ aString asString ])
				replace: [ :char | 
					char = $:
						ifTrue: [ $_ ]
						ifFalse: [ char ] ] ]
]

{ #category : #conversions }
UGEAJavaCodeUMLGenerator >> packageNameFrom: aString [
	^ aString asString
		replace: [ :char | 
			char = $-
				ifTrue: [ $. ]
				ifFalse: [ char ] ]
]

{ #category : #conversions }
UGEAJavaCodeUMLGenerator >> parameterNameFrom: aString [
	^ aString
]

{ #category : #adding }
UGEAJavaCodeUMLGenerator >> umlMethodFrom: aMethod [
	^ (super umlMethodFrom: aMethod)
		name: (self methodNameFrom: aMethod selector);
		yourself
]

{ #category : #conversions }
UGEAJavaCodeUMLGenerator >> variableNameFrom: aString [
	^ aString
]
