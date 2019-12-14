Extension { #name : #MooseEntity }

{ #category : #'*Duplication' }
MooseEntity >> addCloneLocation: anObject [
	"By default we manage the case where this method is not implemented in the entity."

	"('Entity ' , self entity asString , ' is not able to addCloneLocation') synCrLog"
]

{ #category : #'*Duplication' }
MooseEntity >> mergePossibleDuplications: aDupSystem [
	"By default we manage the case where this method is not implemented in the entity."

"	('Entity ' , self asString , ' is not able to mergeDuplications') synCrLog."
	^ true
]
