Class {
	#name : #DuplicationBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'entityPanel',
		'sourceCodePanel',
		'model',
		'duplicationResultPanel',
		'duplicationViewSelector'
	],
	#classInstVars : [
		'colorMap'
	],
	#category : #'DuplicationGUI-core'
}

{ #category : #private }
DuplicationBrowser class >> createIcon [
	ThemeIcons
		compile:
			'duplicationIcon
	^ '''
				,
					(Base64MimeConverter
						mimeEncode:
							'/Users/honore/Documents/Resources/duplicate.png' asFileReference
								binaryReadStream) contents , ''''
		classified: '*DuplicationGUI'.
	ThemeIcons
		compile:
			'duplication
	^ icons
			at: #''duplication''
			ifAbsentPut:[ Form fromBinaryStream: self duplicationIcon base64Decoded asByteArray readStream ]'
		classified: 'DuplicationGUI'.
	Smalltalk ui icons duplication
]

{ #category : #specs }
DuplicationBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #entityPanel
					withConstraints: [ :constraints | constraints width: 300 ];
				add:
					(SpBoxLayout newVertical
						add: #duplicationViewSelector
							withConstraints: [ :constraints | constraints height: self toolbarHeight ];
						add: #duplicationResultPanel;
						yourself);
				yourself);
		add: #sourceCodePanel;
		yourself
]

{ #category : #'as yet unclassified' }
DuplicationBrowser class >> duplicationView: aBuilder [
	<worldMenu>
	self createIcon.
	(aBuilder item: #Duplication)
		order: 10;
		help:
			'Lauch call Powerbuider methods call tree. You should install a PowerbuilderMooseModel in the image';
		label: 'PWB Duplication';
		iconName: #duplication;
		action: [ self runMe ]
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
DuplicationBrowser >> initializeDuplicationResultPanel [
	duplicationResultPanel := self instantiate: model defaultRoassalView.
	duplicationResultPanel model: model
]

{ #category : #initialization }
DuplicationBrowser >> initializeDuplicationRoassalViewSelector [
	duplicationViewSelector := self newDropList.
	duplicationViewSelector
		items: DuplicationBrowserRoassalView views;
		help: 'Select the roassal visualization to use';
		display: [ :item | item viewName ]
]

{ #category : #initialization }
DuplicationBrowser >> initializeEntityPanel [
	entityPanel := self newList.
	entityPanel items: {model mooseModelFunctions}
]

{ #category : #initialization }
DuplicationBrowser >> initializeModel [
	model := DuplicationBrowserModel new.
	model duplicationBrowser: self
]

{ #category : #initialization }
DuplicationBrowser >> initializePresenter [
  entityPanel whenSelectionChangedDo: [:selection |  model computeDuplicationWith: selection selectedItem ]
]

{ #category : #initialization }
DuplicationBrowser >> initializeSourceCodePanel [
	sourceCodePanel := self instantiate: SourceTextPresenter.
	self iconNamed: #duplication
]

{ #category : #initialization }
DuplicationBrowser >> initializeWidgets [
	self initializeModel.
	self initializeEntityPanel.
	self initializeDuplicationResultPanel.
	self initializeSourceCodePanel.
	self initializeDuplicationRoassalViewSelector
]

{ #category : #updating }
DuplicationBrowser >> updateCode [
	sourceCodePanel text: model fragmentText.
	sourceCodePanel entityName: model selectedFragmentLocationName.
	"fragmentFileName label: model fragmentAnchorName"
]
