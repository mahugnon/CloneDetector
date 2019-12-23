Class {
	#name : #DuplicationBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'entityPanel',
		'fragmentLocationPanel',
		'sourceCodePanel',
		'model'
	],
	#category : #DuplicationGUI
}

{ #category : #specs }
DuplicationBrowser class >> defaultSpec [
  ^SpBoxLayout newHorizontal
     add: #entityPanel;
     add: #fragmentLocationPanel;
     add: #sourceCodePanel;
     yourself
]

{ #category : #examples }
DuplicationBrowser class >> runMe [
  < example>
  self new openWithSpec
]

{ #category : #specs }
DuplicationBrowser class >> title [
^'Code duplication browser '
]

{ #category : #initialization }
DuplicationBrowser >> initializePresenter [
  entityPanel whenSelectedItemChangedDo: [:selection |  model computeDuplicationWith: selection ]
]

{ #category : #initialization }
DuplicationBrowser >> initializeWidgets [ 
 model := DuplicationBrowserModel new.
  entityPanel := self newList.
  entityPanel items: {model mooseModelFunctions}.
  fragmentLocationPanel := self newText.
  sourceCodePanel := self newText

]
