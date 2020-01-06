Class {
	#name : #DPFragmentLocationClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #DuplicationGUI
}

{ #category : #hooks }
DPFragmentLocationClick >> initializeElement1: element [
  element announcer when: TRMouseClick do: [ model selectedFragmentLocation: element model.
        model addFragment: element model color: Color random ]
]

{ #category : #hooks }
DPFragmentLocationClick >> initializeElement: element [
  element announcer when: TRMouseClick do: [ model focusClonedFragment: element model clonedFragment.
        model refreshRoassal.
        model openTextPresenters ]
]

{ #category : #accessing }
DPFragmentLocationClick >> model: aDuplicationBrowserModel [ 
	model := aDuplicationBrowserModel
]
