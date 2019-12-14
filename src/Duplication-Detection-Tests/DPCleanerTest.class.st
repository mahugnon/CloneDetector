Class {
	#name : #DPCleanerTest,
	#superclass : #TestCase,
	#category : #'Duplication-Detection-Tests'
}

{ #category : #tests }
DPCleanerTest >> testCPPCleaner [
	| cleaner |
	cleaner := DPCPPCleaner new.
	self assert: (cleaner clean: 'cout << 1 //this is a comment') equals: 'cout<<1'.
	self deny: (cleaner isComment: 'cout << 1 //this is a comment') description: 'Comment in code does not make a line comment'
]

{ #category : #tests }
DPCleanerTest >> testCleanSpace [
	self assert: (DPMantisCleaner new clean: '...i like pie') = 'ilikepie'
]

{ #category : #tests }
DPCleanerTest >> testComment [
	|cleaner|
	cleaner := DPMantisCleaner new.
	
	self assert: (cleaner isComment: '.! asdad asdasd').
	self assert: (cleaner isComment: '.!! asdad asdasd').
	self assert: (cleaner isComment: '....!! asdad asdasd').
	self deny: (cleaner isComment: '. asdad asdasd').
	self deny: (cleaner isComment: '! asdad asdasd').
	self assert: (cleaner isComment: '2232  .!.OK_INV=0').
	
]

{ #category : #tests }
DPCleanerTest >> testSmalltalkCleaner [
	self assert: (DPSmalltalkCleaner new clean: '"asdasd"') equals: ''.
	self assert: (DPSmalltalkCleaner new clean: 'asdasd') equals: 'asdasd'.
	self deny: (DPSmalltalkCleaner new isComment: '12"3"')
]
