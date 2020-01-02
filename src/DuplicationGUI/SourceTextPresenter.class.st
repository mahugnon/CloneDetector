Class {
	#name : #SourceTextPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceText',
		'location'
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

{ #category : #TOREMOVE }
SourceTextPresenter >> location: aString [
  location := aString
]

{ #category : #accessing }
SourceTextPresenter >> text: aText [
  sourceText text: aText
]

{ #category : #TOREMOVE }
SourceTextPresenter >> title [
  ^location
]