Extension { #name : #DPClonedFragment }

{ #category : #'*Duplication-ImportExport' }
DPClonedFragment >> fromSton: stonReader [
	super fromSton: stonReader.
	self members do: [ :member | member clonedFragment: self ]
]

{ #category : #'*Duplication-ImportExport' }
DPClonedFragment class >> stonAllInstVarNames [
	^ super stonAllInstVarNames \ { #mooseID. #state }
]

{ #category : #'*Duplication-ImportExport' }
DPClonedFragment class >> stonName [
	^ #Fragment
]
