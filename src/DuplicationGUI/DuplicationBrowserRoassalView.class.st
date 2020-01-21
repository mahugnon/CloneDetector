Class {
	#name : #DuplicationBrowserRoassalView,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'duplicationDiagram'
	],
	#category : #'DuplicationGUI-roassal'
}

{ #category : #specs }
DuplicationBrowserRoassalView class >> defaultSpec [
  ^SpBoxLayout newVertical
     add: #duplicationDiagram;
     yourself
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn: aView [
	^ self subclassResponsibility
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeDuplicationDiagram [
  duplicationDiagram := self instantiate: RoassalModel.
  duplicationDiagram script: [:aView :canvas |  self drawDuplicationDiagramOn: aView.
        aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeWidgets [
  model := DuplicationBrowserModel new.
  self initializeDuplicationDiagram
]

{ #category : #accessing }
DuplicationBrowserRoassalView >> model: anObject [
  model := anObject.
  model duplicationView: self
]

{ #category : #updating }
DuplicationBrowserRoassalView >> updateView [
  self update
]
