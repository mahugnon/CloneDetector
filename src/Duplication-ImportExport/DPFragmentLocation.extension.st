Extension { #name : #DPFragmentLocation }

{ #category : #'*Duplication-ImportExport' }
DPFragmentLocation class >> entityCustomizer [
	<stonCustomizationFor: #entity>
	^ STONCustomizer
		readBlock: [ :fragment :value :reader | 
			fragment
				entity:
					((reader model entityNamed: value ifAbsent: [ nil ])
						ifNotNil: [ :entity | 
							entity addCloneLocation: fragment.
							entity ]) ]
		writeBlock: [ :fragment | fragment entity mooseName ]
]

{ #category : #'*Duplication-ImportExport' }
DPFragmentLocation class >> fileAnchorCustomizer [
	<stonCustomizationFor: #fileAnchor>
	^ STONCustomizer
		readBlock: [ :fragment :value :reader | 
			fragment
				fileAnchor:
					(fragment entity allSourceAnchors
						detect: [ :each | each fileName = value ]
						ifNone: [ self error: 'No file named ' , value , ' in ' , fragment entity asString ]) ]
		writeBlock: [ :fragment | fragment fileAnchor fileName ]
]

{ #category : #'*Duplication-ImportExport' }
DPFragmentLocation class >> stonAllInstVarNames [
	"Here we need to keep the order of the variables because entity needs to be before fileAnchor, else it might be a problem during the import since the FileAnchor need to be imported AFTER the entity."

	| toReject |
	toReject := #(#mooseID #state #clonedFragment).
	^ super stonAllInstVarNames reject: [ :each | toReject includes: each ]
]

{ #category : #'*Duplication-ImportExport' }
DPFragmentLocation class >> stonName [
	^ #Location
]
