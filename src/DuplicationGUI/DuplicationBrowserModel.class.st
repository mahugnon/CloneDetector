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

{ #category : #api }
DuplicationBrowserModel >> fragmentText [
  ^selectedFragmentLocation codeText
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
