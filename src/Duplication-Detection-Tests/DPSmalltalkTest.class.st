Class {
	#name : #DPSmalltalkTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Duplication-Detection-Tests'
}

{ #category : #running }
DPSmalltalkTest >> detector [
	^ DPDetector
		runOn: self model allMethods
		parametrizedWith:
			(DPParameters new
				frequency: 3;
				minNumberOfLines: 10;
				minNumberOfCharacters: 80;
				cleaner: DPSmalltalkCleaner new)
]

{ #category : #accessing }
DPSmalltalkTest >> model [
	model := MooseModel new.
	FAMIXMethod new name: 'method1'; mooseModel: model; sourceAnchor: (FAMIXSourceTextAnchor new source: self sample1; yourself).
	FAMIXMethod new name: 'method2'; mooseModel: model; sourceAnchor: (FAMIXSourceTextAnchor new source: self sample2; yourself).
	FAMIXMethod new name: 'method3'; mooseModel: model; sourceAnchor: (FAMIXSourceTextAnchor new source: self sample3; yourself).
	^ model
]

{ #category : #running }
DPSmalltalkTest >> sample1 [
	^ 'printFullData

	| outStream |
	outStream := String new writeStream.
	outStream nextPutAll: ''@data''.
	outStream cr.
	rows doWithIndex: 
			[:eachRow :rowIndex |
			outStream nextPut: ${.
			"printing classification"
			outStream
				nextPut: $0;
				space;
				nextPutAll: ((self attributes at: ''classification'') at: rowIndex).
			outStream nextPutAll: (M2Index printRow: eachRow).
			outStream nextPutAll: (self printAttributeRowAt: rowIndex withOffset: index size).
			outStream nextPut: $}.
			outStream cr].
	^outStream contents'
]

{ #category : #running }
DPSmalltalkTest >> sample2 [
	^ 'printFullWordData

	| outStream |
	outStream := String new writeStream.
	outStream nextPutAll: ''@data''.
	outStream cr.
	rows doWithIndex: 
			[:eachRow :rowIndex |
			outStream nextPut: ${.
			"printing classification"
			outStream
				nextPut: $0;
				space;
				nextPutAll: ((self attributes at: ''classification'') at: rowIndex).
			outStream nextPutAll: (M2Index printRow: eachRow).
			outStream nextPut: $}.
			outStream cr].
	^outStream contents'
]

{ #category : #running }
DPSmalltalkTest >> sample3 [
	^ 'printWordData

	| outStream |
	outStream := String new writeStream.
	outStream nextPutAll: ''@data''.
	outStream cr.
	rows doWithIndex: 
			[:eachRow :rowIndex |
			outStream nextPut: ${.
			"printing classification"
			outStream
				nextPut: $0;
				space;
				nextPutAll: ((self attributes at: ''classification'') at: rowIndex).
			outStream nextPutAll: (M2Index printRow: eachRow).
			outStream nextPut: $}.
			outStream cr].
	^outStream contents'
]

{ #category : #tests }
DPSmalltalkTest >> testTwoSourceCode [

	self assert: self detector fragments size equals: 1.
	self assert: self detector fragments first members size equals: 3
]
