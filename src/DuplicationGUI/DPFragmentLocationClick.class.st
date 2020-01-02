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
  element announcer when: TRMouseClick do: [ model selectedFragmentLocation: element model.
        model addFragment: element model color: Color random ]
]

{ #category : #accessing }
DPFragmentLocationClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]
