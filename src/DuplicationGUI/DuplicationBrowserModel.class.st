Class {
	#name : #DuplicationBrowserModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'duplicationFragments',
		'duplicationView',
		'selectedFragmentLocation',
		'duplicationBrowser',
		'colorMap',
		'focusClonedFragment',
		'duplicationEntities'
	],
	#category : #DuplicationGUI
}

{ #category : #api }
DuplicationBrowserModel >> addFragment: anObject color: aColor [
  colorMap at: anObject entity put: aColor.
  duplicationView updateView
]

{ #category : #accessing }
DuplicationBrowserModel >> colorMap [
  ^colorMap
]

{ #category : #initialization }
DuplicationBrowserModel >> computeDuplicationWith: aCollection [
  duplicationFragments := (DPDetector runOn: aCollection parametrizedWith: (DPParameters new
           minNumberOfLines: 150;
           frequency: 2;
           minNumberOfCharacters: 75;
           cleaner: DPPWBCleaner new)) fragments.
  self refreshRoassal
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationBrowser: anObject [
  duplicationBrowser := anObject
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationEntities [
  | dpLocations |
  dpLocations := self duplicationLocations.
  duplicationEntities := ((duplicationFragments flatCollectAsSet: #locationsOfCloneClass) collect: [:e |  e -> (dpLocations select: [:loc |  loc entity = e ]) ]) asOrderedDictionary.
  ^duplicationEntities
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments [
	^ duplicationFragments
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments: anObject [
	duplicationFragments := anObject
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationLocations [
  ^duplicationFragments flatCollectAsSet: #members
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView [
	^ duplicationView
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView: anObject [
	duplicationView := anObject
]

{ #category : #api }
DuplicationBrowserModel >> duplicationsWithLocation: aFamixPWBFunction [
  ^dpLocations select: [:each |  each entity = aFamixPWBFunction ]
]

{ #category : #accessing }
DuplicationBrowserModel >> focusClonedFragment [
  ^focusClonedFragment
]

{ #category : #accessing }
DuplicationBrowserModel >> focusClonedFragment: aDPClonedFragment [ 
	focusClonedFragment := aDPClonedFragment
]

{ #category : #'as yet unclassified' }
DuplicationBrowserModel >> fragmentAnchorName [
  ^selectedFragmentLocation entity mooseName
]

{ #category : #api }
DuplicationBrowserModel >> fragmentText [
  ^self fragmentText: selectedFragmentLocation
]

{ #category : #api }
DuplicationBrowserModel >> fragmentText: aFragmentLocation [
  | source before beforeString after afterString textToRender |
  source := aFragmentLocation entitySourceCode lines.
  before := source select: [:l |  (source indexOf: l) < aFragmentLocation startLine ].
  beforeString := String streamContents: [:stream |  before do: [:line |  stream
                 << line;
                 cr ] ].
  after := source select: [:l |  (source indexOf: l) > aFragmentLocation endLine ].
  afterString := String streamContents: [:stream |  after do: [:line |  stream
                 << line;
                 cr ] ].
  textToRender := Text new.
  textToRender append: beforeString.
  textToRender append: (Text string: aFragmentLocation codeText attributes: {(TextColor new color: Color red)}).
  textToRender append: afterString.
  ^textToRender
]

{ #category : #initialization }
DuplicationBrowserModel >> initialize [
  super initialize.
  mooseModel := MooseModel root second.
  duplicationFragments := OrderedCollection new.
  colorMap := OrderedDictionary new
]

{ #category : #'as yet unclassified' }
DuplicationBrowserModel >> mooseModelFunctions [
  ^mooseModel allWithType: FamixPWBFunction
]

{ #category : #api }
DuplicationBrowserModel >> openTextPresenters [
  focusClonedFragment members do: [:each |  SourceTextPresenter new
           text: (self fragmentText: each);
           location: each entity mooseName;
           openWithSpec ]
]

{ #category : #'as yet unclassified' }
DuplicationBrowserModel >> openTextPresenters: aFragment [
  aFragment members do: [:each |  SourceTextPresenter new
           text: (self fragmentText: each);
           location: each entity mooseName;
           openWithSpec ]
]

{ #category : #initialization }
DuplicationBrowserModel >> refreshRoassal [
  duplicationView updateView
]

{ #category : #accessing }
DuplicationBrowserModel >> selectedFragmentLocation: anObject [
  selectedFragmentLocation := anObject.
  duplicationBrowser updateCode
]
