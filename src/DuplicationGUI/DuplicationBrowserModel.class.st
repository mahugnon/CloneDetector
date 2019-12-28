Class {
	#name : #DuplicationBrowserModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'duplicationFragments',
		'duplicationView',
		'selectedFragmentLocation',
		'duplicationBrowser'
	],
	#category : #DuplicationGUI
}

{ #category : #initialization }
DuplicationBrowserModel >> computeDuplicationWith: aCollection [
  duplicationFragments := (DPDetector runOn: aCollection parametrizedWith: (DPParameters new
           minNumberOfLines: 15;
           frequency: 2;
           minNumberOfCharacters: 75;
           cleaner: DPFourDCleaner new)) fragments.
  duplicationView updateView
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationBrowser: anObject [
  duplicationBrowser := anObject
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments [
	^ duplicationFragments
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments: anObject [
	duplicationFragments := anObject
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView [
	^ duplicationView
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView: anObject [
	duplicationView := anObject
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
  mooseModel := MooseModel root first.
  duplicationFragments := OrderedCollection new
]

{ #category : #'as yet unclassified' }
DuplicationBrowserModel >> mooseModelFunctions [
  ^mooseModel allWithType: FamixPWBFunction
]

{ #category : #accessing }
DuplicationBrowserModel >> selectedFragmentLocation: anObject [
  selectedFragmentLocation := anObject.
  duplicationBrowser updateCode
]
