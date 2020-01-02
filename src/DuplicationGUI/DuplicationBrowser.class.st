Class {
	#name : #DuplicationBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'entityPanel',
		'fragmentLocationPanel',
		'sourceCodePanel',
		'model',
		'fragmentFileName'
	],
	#classInstVars : [
		'colorMap'
	],
	#category : #DuplicationGUI
}

{ #category : #specs }
DuplicationBrowser class >> defaultSpec [
  ^SpBoxLayout newHorizontal
     add: #entityPanel withConstraints: [:constraints |  constraints width: 200 ];
     add: #fragmentLocationPanel;
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
  entityPanel whenSelectionChangedDo: [:selection |  model computeDuplicationWith: selection selectedItem ]
]

{ #category : #initialization }
DuplicationBrowser >> initializeWidgets [
  model := DuplicationBrowserModel new.
  model duplicationBrowser: self.
  entityPanel := self newList.
  entityPanel items: {model mooseModelFunctions}.
  fragmentLocationPanel := self instantiate: DuplicationBrowserRoassalView.
  fragmentLocationPanel model: model.
  sourceCodePanel := self newText.
  fragmentFileName := self newButton
]

{ #category : #updating }
DuplicationBrowser >> updateCode [
  sourceCodePanel text: model fragmentText.
  fragmentFileName label: model fragmentAnchorName
]
