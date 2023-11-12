Class {
	#name : #UGTypesManagerDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'optionsList',
		'accessesModel',
		'typePossibilities',
		'selectedType',
		'hierarchyList',
		'typeField',
		'ignoreEvents',
		'typeCollectionCheck'
	],
	#category : 'UMLGeneratorGUI'
}

{ #category : #specs }
UGTypesManagerDialog class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				newColumn: [ :col | col add: #accessesModel ];
				newColumn: [ :col | col add: #optionsList ] width: 250;
				newColumn: [ :col | 
					col
						newRow: [ :row2 | row2 add: #hierarchyList ];
						newRow: [ :row2 | 
							row2
								add: #typeCollectionCheck width: 26;
								add: #typeField ]
							height: 24 ]
					width: 300 ]
]

{ #category : #retrieving }
UGTypesManagerDialog class >> openFor: typePossibilities [
	^ self new openFor: typePossibilities
]

{ #category : #retrieving }
UGTypesManagerDialog class >> typeFor: typePossibilities [
	^ (self openFor: typePossibilities) selectedType
]

{ #category : #accessing }
UGTypesManagerDialog >> accessesModel [
	^ accessesModel
]

{ #category : #accessing }
UGTypesManagerDialog >> allowEvents [
	ignoreEvents := false
]

{ #category : #actions }
UGTypesManagerDialog >> checkSelectedType [
	selectedType ifNotNil: [ ^ true ].
	self markSelectedTypeWrong.
	^ false
]

{ #category : #actions }
UGTypesManagerDialog >> deselect [
	ignoreEvents
		ifTrue: [ ^ self ].
	selectedType := nil
]

{ #category : #accessing }
UGTypesManagerDialog >> hierarchyList [
	^ hierarchyList
]

{ #category : #accessing }
UGTypesManagerDialog >> ignoreEvents [
	ignoreEvents := true
]

{ #category : #api }
UGTypesManagerDialog >> initialExtent [
	^ 1250 @ 675
]

{ #category : #initialization }
UGTypesManagerDialog >> initialize [
	super initialize.
	self allowEvents.
	self title: 'Types manager'
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeAccesses [
	accessesModel := self instantiate: MessageBrowser
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeCollectionCheck [
	typeCollectionCheck := self instantiate: CheckBoxModel.
	typeCollectionCheck label: '*'
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeHierarchy [
	hierarchyList := self instantiate: ListModel.
	hierarchyList displayBlock: [ :each | each asString ].
	hierarchyList whenSelectionChanged: [ :item | self selectedInHierarchy ]
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeOptions [
	optionsList := self instantiate: ListModel.
	optionsList displayBlock: [ :each | each asString ].
	optionsList whenSelectionChanged: [ :item | self updateHierarchyList ]
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeText [
	| applicants applicantsSet |
	typeField := self instantiate: TextInputFieldModel.
	typeField autoAccept: true.
	applicants := (Array
		streamContents: [ :strm | 
			Symbol
				allSymbolTablesDo: [ :each | 
					(each notEmpty
						and: [ each first canBeGlobalVarInitial and: [ Smalltalk globals includesKey: each ] ])
						ifTrue: [ strm nextPut: each ] ] ]) sort.
	applicantsSet := applicants asSet.
	typeField
		entryCompletion:
			(EntryCompletion new
				dataSourceBlock: [ :currText | applicants ];
				filterBlock: [ :currApplicant :currText | 
					currText size > 2
						and: [ currApplicant asLowercase includesSubstring: currText asString asLowercase ] ]).
	typeField
		whenTextChanged: [ :text | 
			(applicantsSet includes: text asSymbol)
				ifTrue: [ self selectedInText ]
				ifFalse: [ self deselect ] ]
]

{ #category : #initialization }
UGTypesManagerDialog >> initializeWidgets [
	self
		initializeAccesses;
		initializeOptions;
		initializeHierarchy;
		initializeText;
		initializeCollectionCheck
]

{ #category : #actions }
UGTypesManagerDialog >> markSelectedTypeOk [
	self typeField color: self typeField defaultColor
]

{ #category : #actions }
UGTypesManagerDialog >> markSelectedTypeWrong [
	self typeField color: Color lightRed
]

{ #category : #'instance creation' }
UGTypesManagerDialog >> open [
	self openDialogWithSpec.
	self window
		okAction: [ self checkSelectedType ];
		cancelAction: [ self deselect ];
		maximize;
		modalRelativeTo: self currentWorld.
	^ self
]

{ #category : #'instance creation' }
UGTypesManagerDialog >> openFor: aPossibilities [
	^ self
		possibilities: aPossibilities;
		open
]

{ #category : #accessing }
UGTypesManagerDialog >> optionsList [
	^ optionsList
]

{ #category : #accessing }
UGTypesManagerDialog >> possibilities: aPossibilities [
	typePossibilities := aPossibilities.
	self
		title: 'Type manager for ' , aPossibilities item kindName , ' ' , aPossibilities item asString.
	optionsList items: typePossibilities asUGClasses.
	aPossibilities size = 1
		ifTrue: [ optionsList setIndex: 1 ].
	accessesModel
		messages:
			(SystemNavigation default
				allAccessesTo: aPossibilities item itemName
				from: aPossibilities item containingClass);
		autoSelect: aPossibilities item itemName
]

{ #category : #actions }
UGTypesManagerDialog >> selectedInHierarchy [
	ignoreEvents
		ifTrue: [ ^ self ].
	hierarchyList selectedItem ifNil: [ ^ self ].
	self setTypeFieldWithoutEvents: hierarchyList selectedItem.
	selectedType := hierarchyList selectedItem
]

{ #category : #actions }
UGTypesManagerDialog >> selectedInText [
	| class |
	self markSelectedTypeOk.
	ignoreEvents
		ifTrue: [ ^ self ].
	class := typeField text asClass.
	selectedType := typeCollectionCheck state
		ifTrue: [ UGCollection for: class ]
		ifFalse: [ UGClass for: class ]
]

{ #category : #accessing }
UGTypesManagerDialog >> selectedType [
	^ selectedType
]

{ #category : #initialization }
UGTypesManagerDialog >> setTypeField: aClassItem [
	aClassItem ifNil: [ ^ typeField text: '' ].
	typeField text: aClassItem itemName.
	typeCollectionCheck state: aClassItem isCollectionClass
]

{ #category : #initialization }
UGTypesManagerDialog >> setTypeFieldWithoutEvents: aClassItem [
	self ignoreEvents.
	self setTypeField: aClassItem.
	self allowEvents
]

{ #category : #accessing }
UGTypesManagerDialog >> typeCollectionCheck [
	^ typeCollectionCheck
]

{ #category : #accessing }
UGTypesManagerDialog >> typeField [
	^ typeField
]

{ #category : #actions }
UGTypesManagerDialog >> updateHierarchyList [
	selectedType := optionsList selectedItem.
	self ignoreEvents.
	self setTypeField: selectedType.
	hierarchyList
		items: (selectedType ifNil: [ #() ] ifNotNil: [ :item | item withAllSuperclasses ]).
	hierarchyList setSelectedIndex: hierarchyList listSize.
	self allowEvents
]
