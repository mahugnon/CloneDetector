Class {
	#name : #DPDetectorTimeTest,
	#superclass : #DPDetectorTest,
	#instVars : [
		'numberGenerator'
	],
	#category : #'Duplication-Detection-Tests'
}

{ #category : #running }
DPDetectorTimeTest >> assertReasonableTimeToRun: sourceCodes [
	| detector timeToRun |
	timeToRun := [ 
	detector := DPDetector
		runOn: (self mockProgramsWithAll: sourceCodes)
		parametrizedWith:
			(DPParameters new
				minNumberOfLines: 5;
				frequency: 2;
				minNumberOfCharacters: 30;
				cleaner: DPDummyCleaner new) ] timeToRun.
	self logCr: '----------------------'.
	self logCr: 'Benchmarking: ' , self asString.
	self logCr: '----------------------'.
	self logCr: '# Fragments: ' , detector fragments size asString.
	self logCr: '# Programs: ' , sourceCodes size asString.
	self logCr: '# Total program lines: ' , (sourceCodes sum: [ :each | each lines size ]) asString.
	self logCr: 'Time to run: ' , timeToRun asString.
	self logCr: ''.
	self assert: timeToRun < 15 seconds
]

{ #category : #samples }
DPDetectorTimeTest >> newUniqueLine [
	^ UUID new asString, String cr
]

{ #category : #samples }
DPDetectorTimeTest >> sampleLargeSizeSources [
	"
	self new sampleLargeSizeSources inspect.
	"

	^ Array 
		new: 3
		withAll: (String streamContents: [:stream |
			5 timesRepeat: [
				stream 
					nextPutAll: self newUniqueLine;
					nextPutAll: self mantisExample;
					nextPutAll: self newUniqueLine;
					nextPutAll: self mantisCommentsExample ]])
]

{ #category : #samples }
DPDetectorTimeTest >> sampleMediumSizeSources [
	"
	self new sampleMediumSizeSources inspect.
	"
	
	^ Array streamContents: [ :stream |
		75 timesRepeat: [
			stream nextPut: 
				self newUniqueLine, 
				self mantisExample, 
				self newUniqueLine, 
				self mantisCommentsExample
		]]
]

{ #category : #samples }
DPDetectorTimeTest >> sampleSmallSizeSources [
	"
	self new sampleSmallSizeSources inspect.
	"

	^ Array streamContents: [ :stream |
		250 timesRepeat: [
			stream nextPut: 
				self newUniqueLine, 
				self pizzaExample, String cr,
				self newUniqueLine, 
				self pizzaExample, String cr.
		]]
]

{ #category : #tests }
DPDetectorTimeTest >> testLargeSizeSources [
	
	self assertReasonableTimeToRun: self sampleLargeSizeSources
]

{ #category : #tests }
DPDetectorTimeTest >> testMediumSizeSources [
	
	self assertReasonableTimeToRun: self sampleMediumSizeSources
]

{ #category : #tests }
DPDetectorTimeTest >> testSmallSizeSources [
	
	self assertReasonableTimeToRun: self sampleSmallSizeSources
]
