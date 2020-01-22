Class {
	#name : #DPFragmentClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #'DuplicationGUI-core'
}

{ #category : #hooks }
DPFragmentClick >> initializeElement: element [
	element announcer
		when: TRMouseClick
		do: [ model updateFragmentColorFor: element model ]
]

{ #category : #accessing }
DPFragmentClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]
