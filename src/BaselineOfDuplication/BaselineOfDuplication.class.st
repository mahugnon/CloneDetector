Class {
	#name : #BaselineOfDuplication,
	#superclass : #BaselineOf,
	#category : #BaselineOfDuplication
}

{ #category : #baselines }
BaselineOfDuplication >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self baselineOfRoassal2Spec2: spec.
			self baselineOfPowerBuilderParser: spec.
			spec
				package: 'Duplication';
				package: 'Duplication-Detection';
				package: 'Duplication-Entities';
				package: 'DuplicationGui'
					with: [ spec requires: #('PowerBuilderParser' 'Roassal2Spec2') ] ]
]

{ #category : #baselines }
BaselineOfDuplication >> baselineOfPowerBuilderParser: spec [
	spec
		baseline: 'PowerBuilderParser'
		with: [ spec
				repository: 'github://moosetechnology/PowerBuilderParser:LastestMoose8/src' ]
]

{ #category : #baselines }
BaselineOfDuplication >> baselineOfRoassal2Spec2: spec [
	spec
		baseline: 'Roassal2Spec2'
		with: [ spec repository: 'github://mahugnon/Roassal2Spec2:master/src' ]
]
