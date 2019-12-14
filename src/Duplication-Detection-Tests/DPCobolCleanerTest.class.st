Class {
	#name : #DPCobolCleanerTest,
	#superclass : #TestCase,
	#instVars : [
		'cleaner'
	],
	#category : #'Duplication-Detection-Tests'
}

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> setUp [
	cleaner := DPCobolCleaner new.
]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerLength72 [
	 self assert: (cleaner clean:'             DISPLAY ''**      DATE DEBUT ANNULATION INCORRECTE      **''') equals: ''.
	cleaner insideProcedureDivision: true.
	 self assert: (cleaner clean:'             DISPLAY ''**      DATE DEBUT ANNULATION INCORRECTE      **''') equals: 'DISPLAY''**DATEDEBUTANNULATIONINCORRECTE**'''
]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerLongerThan72 [
	 self assert: (cleaner clean:'AN2000***  ACCEPT DATE-SYST FROM DATE.                                  19880099') equals: ''.
	cleaner insideProcedureDivision: true.
	 self assert: (cleaner clean:'AN2000***  ACCEPT DATE-SYST FROM DATE.                                  19880099') equals: '***ACCEPTDATE-SYSTFROMDATE.'
]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerProcedureDivCommented [
	self deny: (cleaner insideProcedureDivision).
	self assert: (cleaner clean:'      *PROCEDURE DIVISION.') equals: ''.
	self deny: (cleaner insideProcedureDivision).

]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerSmallerThan8 [
	 self assert: (cleaner clean:'XXX') equals: ''.
	cleaner insideProcedureDivision: true.
	 self assert: (cleaner clean:'XXX') equals: ''.

]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerStartAt8 [
	 self assert: (cleaner clean:'LM1109 TRAITEMENT-NON-AUTO-BIS.') equals: ''.
	cleaner insideProcedureDivision: true.
	 self assert: (cleaner clean:'LM1109 TRAITEMENT-NON-AUTO-BIS.') equals: 'TRAITEMENT-NON-AUTO-BIS.'
]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testCleanerWithProcedureDivision [
	self deny: (cleaner insideProcedureDivision).
	self assert: (cleaner clean:'       PROCEDURE DIVISION.') equals: ''.
	self assert: (cleaner insideProcedureDivision).

]

{ #category : #'as yet unclassified' }
DPCobolCleanerTest >> testIsComment [
	self assert: (cleaner isComment: '*** CALL GENDATE USING GEN-OUTPUT' ).
	self deny: (cleaner isComment: ' CALL GENDATE USING GEN-OUTPUT' ).
	self assert: (cleaner isComment: '*' ).
	self deny: (cleaner isComment: '' ).

]
