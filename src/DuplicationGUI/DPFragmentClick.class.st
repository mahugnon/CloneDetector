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
  element announcer when: TRMouseClick do: [ self openTextPresenters: element model ]
]

{ #category : #accessing }
DPFragmentClick >> model: aDuplicationBrowserModel [
  model := aDuplicationBrowserModel
]

{ #category : #'as yet unclassified' }
DPFragmentClick >> openTextPresenters: aFragment [
  aFragment members do: [:each |  SourceTextPresenter new
           text: (model fragmentText: each);
           location: each entity mooseName;
           openWithSpec ]
]
