Class {
	#name : #DPFourDCleanerTest,
	#superclass : #TestCase,
	#instVars : [
		'cleaner'
	],
	#category : #'Duplication-Detection-Tests'
}

{ #category : #'as yet unclassified' }
DPFourDCleanerTest >> setUp [
	cleaner := DPFourDCleaner new.
]

{ #category : #'as yet unclassified' }
DPFourDCleanerTest >> testIsComment [
	self assert: (cleaner isComment: '// Nom utilisateur (OS) : jmp' )
]
