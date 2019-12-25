Class {
	#name : #DuplicationBrowserRoassalView,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'duplicationDiagram'
	],
	#category : #DuplicationGUI
}

{ #category : #specs }
DuplicationBrowserRoassalView class >> defaultSpec [
  ^SpBoxLayout newVertical
     add: #duplicationDiagram;
     yourself
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn: aView [
  | es onclick |
  onclick := DPFragmentLocationClick new model: model.
  aView @ RTDraggableView @ RTZoomableView.
  es := (RTBox new
     fillColor: Color white;
     borderColor: Color gray) elementsOn: model duplicationFragments.
  aView addAll: es.
  RTNest new for: es add: [:group :each |  group addAll: (RTBox new
                 fillColor: Color veryLightGray;
                 elementsOn: each members).
        group @ onclick @ (RTShowLabel new
                 labelledInteraction: (RTLabeled new text: [:el |  'entité: ' , el entity name , String cr , 'Ligne debut: ' , el startLine printString , String cr , '  Ligne fin: ' , el endLine printString ]);
                 top;
                 yourself).
        RTGridLayout new
           gapSize: 5;
           applyOn: group ].
  RTGridLayout new
     gapSize: 10;
     applyOn: es.
  es @ (RTShowLabel new
           labelledInteraction: (RTLabeled new text: [:el |  String streamContents: [:st |  st << 'Duplication détecté dans: '.
                          el locationsOfCloneClass asOrderedCollection do: [:entity |  st
                                   << entity name;
                                   << String cr ] ] ]);
           top;
           yourself).
  ^aView
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeDuplicationDiagram [
  duplicationDiagram := self instantiate: RoassalModel.
  duplicationDiagram script: [:aView :canvas |  self drawDuplicationDiagramOn: aView.
        aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeWidgets [
  model := DuplicationBrowserModel new.
  self initializeDuplicationDiagram
]

{ #category : #accessing }
DuplicationBrowserRoassalView >> model: anObject [
  model := anObject.
  model duplicationView: self
]

{ #category : #updating }
DuplicationBrowserRoassalView >> updateView [
  self update
]
