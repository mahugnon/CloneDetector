Class {
	#name : #DuplicationBrowserParameter,
	#superclass : #SpPresenter,
	#instVars : [
		'numberOfLinesOfCode',
		'label',
		'validate',
		'model'
	],
	#category : #DuplicationGUI
}

{ #category : #initialization }
DuplicationBrowserParameter >> initializeWidgets [
  numberOfLinesOfCode := self newTextInput.
  numberOfLinesOfCode ghostText: 'Minimun nombre de ligne '.
  label := self newLabel.
  label text: 'Parametres'.
  validate := self newButton.
  validate label: 'Validé'
]
