Class {
	#name : #DuplicationBrowserRoassalViewByDuplication,
	#superclass : #DuplicationBrowserRoassalView,
	#category : #'DuplicationGUI-roassal'
}

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalViewByDuplication class >> viewName [
	^ 'View by cloned fragments'
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByDuplication >> drawDuplicationDiagramOn: aView [
	| es onclick |
	onclick := DPFragmentLocationClick new model: model.
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTBox new
		fillColor: Color white;
		borderColor: Color gray) elementsOn: model duplicationFragments.
	aView addAll: es.
	RTNest new
		for: es
		add: [ :group :each | 
			group
				addAll:
					(RTBox new
						fillColor:
								[ :elt | model colorMap at: elt entity ifAbsent: [ Color veryLightGray ] ];
						elementsOn: each members).
			group @ onclick
				@
					(RTPopup new
						text: [ :el | 
							'entité: ' , el entity name , String cr , 'Ligne debut: '
								, el startLine printString , String cr , '  Ligne fin: '
								, el endLine printString , String cr , 'Taux : '
								, (el endLine - el startLine + 1) asString , 'lignes sur:  '
								, el entitySourceCode lineCount asString ];
						yourself).
			RTGridLayout new
				gapSize: 5;
				applyOn: group ].
	RTGridLayout new
		gapSize: 10;
		applyOn: es.
	es @ (DPFragmentClick new model: model)
		@
			(RTPopup new
				text: [ :el | 
					String
						streamContents: [ :st | 
							st << 'Duplication détecté dans: '.
							el locationsOfCloneClass asOrderedCollection
								do: [ :entity | 
									st
										<< entity name;
										<< String cr ] ] ];
				yourself).
	es
		@
			(RTLabeled new
				text: #name;
				top).
	RTScrollBarBuilder new
		view: aView;
		fillColor: (Color lightGray alpha: 0.2);
		build.
	^ aView
]
