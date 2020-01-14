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
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn1: aView [
  | es onclick |
  onclick := DPFragmentLocationClick new model: model.
  aView @ RTDraggableView @ RTZoomableView.
  es := (RTBox new
     fillColor: Color white;
     borderColor: Color gray) elementsOn: model duplicationFragments.
  aView addAll: es.
  RTNest new for: es add: [:group :each |  group addAll: (RTBox new
                 fillColor: [:elt |  model colorMap at: elt entity ifAbsent: [ Color veryLightGray ] ];
                 elementsOn: each members).
        group @ onclick @ (RTPopup new
                 text: [:el |  'entité: ' , el entity name , String cr , 'Ligne debut: ' , el startLine printString , String cr , '  Ligne fin: ' , el endLine printString , String cr , 'Taux : ' , (el endLine - el startLine + 1) asString , 'lignes sur:  ' , el entitySourceCode lineCount asString ];
                 yourself).
        RTGridLayout new
           gapSize: 5;
           applyOn: group ].
  RTGridLayout new
     gapSize: 10;
     applyOn: es.
  es @ (DPFragmentClick new model: model) @ (RTPopup new
           text: [:el |  String streamContents: [:st |  st << 'Duplication détecté dans: '.
                    el locationsOfCloneClass asOrderedCollection do: [:entity |  st
                             << entity name;
                             << String cr ] ] ];
           yourself).
  RTScrollBarBuilder new
     view: aView;
     fillColor: (Color lightGray alpha: 0.2);
     build.
  ^aView
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn: aView [
  | es |
  aView @ RTDraggableView.
  aView @ RTZoomableView.
  es := (RTBox new
     fillColor: Color white;
     borderColor: Color gray) elementsOn: model duplicationEntities keys.
  aView addAll: es.
  RTNest new for: es add: [:group :each |  group addAll: (RTBox new
                 fillColor: [:elt |  elt clonedFragment = model focusClonedFragment ifTrue: [ Color red ] ifFalse: [ Color veryLightGray ] ];
                 elementsOn: (model duplicationEntities at: each)).
        group @ (DPFragmentLocationClick new model: model).
        group @ (RTPopup new
                 text: [:el |  'entité: ' , el entity name , String cr , 'Ligne debut: ' , el startLine printString , String cr , '  Ligne fin: ' , el endLine printString , String cr , 'Taux : ' , (el endLine - el startLine + 1) asString , ' lignes sur:  ' , el entitySourceCode lineCount asString ];
                 yourself).
        RTGridLayout new
           gapSize: 5;
           applyOn: group ].
  RTGridLayout new
     gapSize: 10;
     applyOn: es.
  es @ RTDraggable.
  es @ (RTPopup new
           text: [:entity |  'nom: ' , entity name , String cr , 'Loc: ' , entity numberOfLinesOfCode asString , String cr , 'Nbr clone: ' , entity cloneLocations size asString ];
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
