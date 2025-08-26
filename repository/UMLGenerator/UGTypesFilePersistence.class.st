Class {
	#name : 'UGTypesFilePersistence',
	#superclass : 'UGTypesPersistence',
	#instVars : [
		'file'
	],
	#category : 'UMLGenerator-Typer',
	#package : 'UMLGenerator',
	#tag : 'Typer'
}

{ #category : 'accessing' }
UGTypesFilePersistence class >> file: aFileReference [
	^ self new
		file: aFileReference;
		yourself
]

{ #category : 'accessing' }
UGTypesFilePersistence class >> fileName: aFileName [
	^ self new
		fileName: aFileName;
		yourself
]

{ #category : 'accessing' }
UGTypesFilePersistence >> file: aFileReference [
	file := aFileReference
]

{ #category : 'accessing' }
UGTypesFilePersistence >> fileName: fileName [
	self file: fileName asFileReference
]

{ #category : 'persistence' }
UGTypesFilePersistence >> loadTypes [
	| s result |
	file exists
		ifFalse: [ ^ Dictionary new ].
	file isReadable
		ifFalse: [ self error: 'Failed to read file ' , file fullName ].
	s := file readStream.
	result := STON fromStream: s.
	s close.
	^ result
]

{ #category : 'persistence' }
UGTypesFilePersistence >> saveTypes: aDictionary [
	| s |
	file exists
		ifTrue: [ file delete ].
	s := file writeStream.
	STON put: aDictionary onStreamPretty: s.
	s close
]
