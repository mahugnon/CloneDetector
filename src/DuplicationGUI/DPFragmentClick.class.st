Class {
	#name : #DPFragmentClick,
	#superclass : #RTInteraction,
	#instVars : [
		'model'
	],
	#category : #DuplicationGUI
}

{ #category : #hooks }
DPFragmentClick >> initializeElement: element [
  element announcer when: TRMouseClick do: [ model openTextPresenters: element model ]
]

{ #category : #accessing }
DPFragmentClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]
