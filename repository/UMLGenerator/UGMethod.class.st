Class {
	#name : #UGMethod,
	#superclass : #UGClassItem,
	#category : 'UMLGenerator-Structure'
}

{ #category : #visiting }
UGMethod >> acceptVisitor: aVisitor [
	^ aVisitor visitMethod: self
]

{ #category : #accessing }
UGMethod >> compiledMethod [
	^ containingClass >> self itemName
]

{ #category : #accessing }
UGMethod >> inputParameters [
	^ self compiledMethod argumentNames
		collect: [ :each | UGInputMethodParameter named: each in: self ]
]

{ #category : #constants }
UGMethod >> kindName [
	^ 'method'
]

{ #category : #accessing }
UGMethod >> parameters [
	^ self inputParameters , {self returnParameter}
]

{ #category : #accessing }
UGMethod >> returnParameter [
	^ UGReturnParameter in: self
]
