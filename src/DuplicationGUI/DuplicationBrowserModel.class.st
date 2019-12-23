Class {
	#name : #DuplicationBrowserModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel'
	],
	#category : #DuplicationGUI
}

{ #category : #initialization }
DuplicationBrowserModel >> computeDuplicationWith: aCollection [
  
| duplicationFragments |
duplicationFragments := DPDetector runOn: aCollection parametrizedWith: (DPParameters new
           minNumberOfLines: 15;
           frequency: 2;
           minNumberOfCharacters: 75;
           cleaner: DPFourDCleaner new).

]

{ #category : #initialization }
DuplicationBrowserModel >> initialize [
  super initialize.
  mooseModel := MooseModel root first
]

{ #category : #'as yet unclassified' }
DuplicationBrowserModel >> mooseModelFunctions [
  ^mooseModel allWithType: FamixPWBFunction
]
