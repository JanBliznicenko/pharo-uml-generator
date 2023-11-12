Class {
	#name : #UGPackagingUMLGenerator,
	#superclass : #UGUMLGenerator,
	#category : 'UMLGenerator-Generator'
}

{ #category : #adding }
UGPackagingUMLGenerator >> addClass: aClass [
	aClass isTrait
		ifTrue: [ ^ self ].
	self flag: #todo.	"traits are ignored"
	^ (super addClass: aClass)
		package: (self umlPackageOf: aClass);
		yourself
]

{ #category : #private }
UGPackagingUMLGenerator >> addPackage: aPackage [
	^ self addPackageNamed: aPackage name to: encompassingPackage
]

{ #category : #private }
UGPackagingUMLGenerator >> addPackageNamed: aPackageName to: anEncompassingPackage [
	| umlPackage |
	umlPackage := OPUMLPackage new
		name: aPackageName;
		nestingPackage: anEncompassingPackage;
		yourself.
	anEncompassingPackage packagedElements add: umlPackage.
	^ umlPackage
]

{ #category : #private }
UGPackagingUMLGenerator >> addTag: aTag to: anUmlPackage [
	^ self addPackageNamed: aTag name to: anUmlPackage
]

{ #category : #private }
UGPackagingUMLGenerator >> detectUmlClass: aUmlClass inUmlPackage: aUmlPackage [
	| packagedElements |
	packagedElements := aUmlPackage packagedElements.
	(packagedElements includes: aUmlClass)
		ifTrue: [ ^ aUmlPackage ].
	^ (packagedElements
		select: [ :each | each isKindOf: OPUMLPackage ]
		thenCollect: [ :each | self detectUmlClass: aUmlClass inUmlPackage: each ]) detect: [ :any | any isNotNil ] ifNone: [ nil ]
]

{ #category : #testing }
UGPackagingUMLGenerator >> isPackageNamed: packageName equalTo: umlPackage [
	^ (umlPackage isKindOf: OPUMLPackage) and: [ umlPackage name = packageName ]
]

{ #category : #private }
UGPackagingUMLGenerator >> umlPackageOf: aClass [
	| package tag packages umlPackage |
	package := aClass package.
	tag := package classTagForClass: aClass.
	packages := encompassingPackage packagedElements
		select: [ :each | each isKindOf: OPUMLPackage ].
	umlPackage := packages
		detect: [ :any | self isPackageNamed: package name equalTo: any ]
		ifNone: [ self addPackage: package ].
	tag isRoot
		ifTrue: [ ^ umlPackage ].
	^ umlPackage packagedElements
		detect: [ :any | self isPackageNamed: tag name equalTo: any ]
		ifNone: [ self addTag: tag to: umlPackage ]
]

{ #category : #private }
UGPackagingUMLGenerator >> umlPackageOfUmlClass: aUmlClass [
	^ self detectUmlClass: aUmlClass inUmlPackage: encompassingPackage
]
