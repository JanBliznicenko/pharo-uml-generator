Class {
	#name : #UGUMLStaticController,
	#superclass : #Object,
	#instVars : [
		'generator',
		'typesManager',
		'typerAdaptor',
		'typesFinalizer',
		'analyzedPackage'
	],
	#category : #'UMLGenerator-Controller'
}

{ #category : #'uml - generation' }
UGUMLStaticController class >> generateUMLFor: aPackageName withGenerator: aGeneratorClass saveTo: aFile [
	| instance |
	instance := self new.
	instance analyzedPackage: aPackageName;
		generator: aGeneratorClass new;
		generateAndSaveTo: aFile.
]

{ #category : #constants }
UGUMLStaticController class >> typeInfo [
	^ 'default.typeinfo-all-backups.ston'.
]

{ #category : #accessing }
UGUMLStaticController >> analyzedPackage [

	^ analyzedPackage
]

{ #category : #accessing }
UGUMLStaticController >> analyzedPackage: anObject [

	analyzedPackage := anObject
]

{ #category : #'uml - generation' }
UGUMLStaticController >> generateAndSaveTo: aFile [
	"This file has to be deleted otherwise the interferers won't be started."
	self class typeInfo asFileReference deleteIfAbsent: [ "Do nothing" ].
	"save types into following file"
	typesManager := UGTypesManager withFile: self class typeInfo.
	"use following typer(s)"
	typerAdaptor := UGTyperChainingCombinator withAdaptors: {UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new.}.
	"setup types manager"
	typesManager
		autoSave;
		typerAdaptor: typerAdaptor.
	"use finalizer for getting final types from all the ones found by typers"
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.
	"use the proper generator for the target tool (each one requires little differences in the model)"
	generator typesManager: typesFinalizer.
	"generate model for the following packages"
	generator importFromPackagesNamed: { analyzedPackage }.
	"save the xmi model into following file"
	generator saveXmlTo: aFile.
]

{ #category : #accessing }
UGUMLStaticController >> generator [

	^ generator
]

{ #category : #accessing }
UGUMLStaticController >> generator: anObject [

	generator := anObject
]

{ #category : #initialization }
UGUMLStaticController >> initialize [
	typesManager := UGTypesManager withFile: self class typeInfo.
	typerAdaptor := UGTyperChainingCombinator withAdaptors: {UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new.}.
	typesManager autoSave;
		typerAdaptor: typerAdaptor.
	typesFinalizer := UGAutoTypesManagerFinalizer new typesManager: typesManager.
]

{ #category : #accessing }
UGUMLStaticController >> typerAdaptor [

	^ typerAdaptor
]

{ #category : #accessing }
UGUMLStaticController >> typerAdaptor: anObject [

	typerAdaptor := anObject
]

{ #category : #accessing }
UGUMLStaticController >> typesFinalizer [

	^ typesFinalizer
]

{ #category : #accessing }
UGUMLStaticController >> typesFinalizer: anObject [

	typesFinalizer := anObject
]

{ #category : #accessing }
UGUMLStaticController >> typesManager [

	^ typesManager
]

{ #category : #accessing }
UGUMLStaticController >> typesManager: anObject [

	typesManager := anObject
]
