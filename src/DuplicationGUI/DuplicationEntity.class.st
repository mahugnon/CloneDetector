Class {
	#name : #DuplicationEntity,
	#superclass : #Object,
	#instVars : [
		'entity',
		'color',
		'dpFragment'
	],
	#category : #'DuplicationGUI-core'
}

{ #category : #accessing }
DuplicationEntity >> color [
	^ color
]

{ #category : #accessing }
DuplicationEntity >> color: anObject [
	color := anObject
]

{ #category : #accessing }
DuplicationEntity >> entity [
	^ entity
]

{ #category : #accessing }
DuplicationEntity >> entity: anObject [
	entity := anObject
]
