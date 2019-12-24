Class {
	#name : #DPFragmentLocationClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #DuplicationGUI
}

{ #category : #hooks }
DPFragmentLocationClick >> initializeElement: element [
  element announcer when: TRMouseClick do: [ model selectedFragmentLocation: element model ]
]

{ #category : #accessing }
DPFragmentLocationClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]
