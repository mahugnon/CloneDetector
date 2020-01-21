Class {
	#name : #AbstractDuplicationQuery,
	#superclass : #Object,
	#category : #'DuplicationGUI-queries'
}

{ #category : #running }
AbstractDuplicationQuery class >> runOn: anObject [
	^ self new runOn: anObject
]

{ #category : #running }
AbstractDuplicationQuery >> runOn: anObject [
	^ self subclassResponsibility
]
