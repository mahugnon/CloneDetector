Class {
	#name : #SourceTextPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceText'
	],
	#category : #DuplicationGUI
}

{ #category : #specs }
SourceTextPresenter class >> defaultSpec [
  ^SpBoxLayout newHorizontal
     add: #sourceText;
     yourself
]

{ #category : #initialization }
SourceTextPresenter >> initializePresenter [ 
]

{ #category : #initialization }
SourceTextPresenter >> initializeWidgets [
  sourceText := self newText
]

{ #category : #accessing }
SourceTextPresenter >> text: aText [
  sourceText text: aText
]
