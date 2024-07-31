Class {
	#name : #UGUMLRealTimeController,
	#superclass : #Object,
	#instVars : [
		'generator',
		'typesManager',
		'typerAdaptor',
		'typesFinalizer',
		'analyzedPackage'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'UMLGenerator-Controller'
}

{ #category : #'uml - generation' }
UGUMLRealTimeController class >> finishSilentUmlGenerationWithGenerator: aGeneratorClass saveTo: aFile [
	instance ifNil: [ self notify: 'startSilentUmlGenerationFor: has to be called first.'. ^ self. ].
	instance 	generator: aGeneratorClass new;
		silentGenerateAndSaveTo: aFile.
	instance := nil.
]

{ #category : #'uml - generation' }
UGUMLRealTimeController class >> generateUMLFor: aPackageName withGenerator: aGeneratorClass saveTo: aFile [
	instance ifNotNil: [ instance clearAfterRealTimeInferer. ].
	instance := self new.
	instance analyzedPackage: aPackageName;
		generator: aGeneratorClass new;
		generateAndSaveTo: aFile.
	instance := nil.
]

{ #category : #'uml - generation' }
UGUMLRealTimeController class >> startSilentUmlGenerationFor: aPackageName [
	instance ifNotNil: [ instance clearAfterRealTimeInferer. ].
	instance := self new.
	instance analyzedPackage: aPackageName;
		prepareForRealTimeInferer.
]

{ #category : #constants }
UGUMLRealTimeController class >> typeInfo [
	^ 'default.typeinfo-all-backups.ston'.
]

{ #category : #accessing }
UGUMLRealTimeController >> analyzedPackage [

	^ analyzedPackage
]

{ #category : #accessing }
UGUMLRealTimeController >> analyzedPackage: anObject [

	analyzedPackage := anObject
]

{ #category : #'uml - generation' }
UGUMLRealTimeController >> clearAfterRealTimeInferer [
	"removes current metalinks (stops current types logging)"

	UGRealTimeTyper default uninstallLinks.
	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	analyzedPackage ifNotNil: [ :arg |
		analyzedPackage asPackage recompileAndIncludeTraitMethods ]
]

{ #category : #'uml - generation' }
UGUMLRealTimeController >> generateAndSaveTo: aFile [
	"This file has to be deleted otherwise the interferers won't be started."
	self class typeInfo asFileReference deleteIfAbsent: [ "Do nothing" ].
	"Remove links from previous realtime interferer usage."
	self clearAfterRealTimeInferer.
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: analyzedPackage.
	"this is the time to run tests/scenarios to log types"
	self notify:
		'This is time to run tests/scenarios to log types for realtime type inferer.'
		, (String with: Character cr)
		, 'Run the tests/scenarios and then click Proceed'.
	"save types into following file"
	typesManager := UGTypesManager withFile: self class typeInfo.
	"use following typer(s)"
	typerAdaptor := UGTyperChainingCombinator withAdaptors: {UGRealTimeTyperAdaptor new. UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new }.
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
	"Remove links from realtime interferer usage."
	self clearAfterRealTimeInferer
]

{ #category : #accessing }
UGUMLRealTimeController >> generator [

	^ generator
]

{ #category : #accessing }
UGUMLRealTimeController >> generator: anObject [

	generator := anObject
]

{ #category : #'uml - generation' }
UGUMLRealTimeController >> prepareForRealTimeInferer [
	"This file has to be deleted otherwise the interferers won't be started."
	self class typeInfo asFileReference deleteIfAbsent: [ "Do nothing" ].
	"Remove links from previous realtime interferer usage."
	self clearAfterRealTimeInferer.
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: analyzedPackage.
]

{ #category : #'uml - generation' }
UGUMLRealTimeController >> silentGenerateAndSaveTo: aFile [
	"save types into following file"
	typesManager := UGTypesManager withFile: self class typeInfo.
	"use following typer(s)"
	typerAdaptor := UGTyperChainingCombinator withAdaptors: {UGRealTimeTyperAdaptor new. UGRBTyperAdaptor new. UGJ2InfererTyperAdaptor new }.
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
	"Remove links from realtime interferer usage."
	self clearAfterRealTimeInferer.
]

{ #category : #accessing }
UGUMLRealTimeController >> typerAdaptor [

	^ typerAdaptor
]

{ #category : #accessing }
UGUMLRealTimeController >> typerAdaptor: anObject [

	typerAdaptor := anObject
]

{ #category : #accessing }
UGUMLRealTimeController >> typesFinalizer [

	^ typesFinalizer
]

{ #category : #accessing }
UGUMLRealTimeController >> typesFinalizer: anObject [

	typesFinalizer := anObject
]

{ #category : #accessing }
UGUMLRealTimeController >> typesManager [

	^ typesManager
]

{ #category : #accessing }
UGUMLRealTimeController >> typesManager: anObject [

	typesManager := anObject
]
