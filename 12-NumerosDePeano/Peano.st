!classDefinition: #I category: #'Números de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Números de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Números de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:51:43'!
* unNumeroDePeano

	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 18:51:11'!
+ unNumeroDePeano

	^unNumeroDePeano next ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:58:22'!
/ unNumeroDePeano

	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 18:25:32'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:44:29'!
substractTo: aNumber
	^aNumber previous! !


!classDefinition: #II category: #'Números de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Números de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Números de Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:56:02'!
* aNumber 
	^self previous * aNumber + aNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 18:53:45'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next ! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:44:51'!
- unNumeroDePeano
	 
	^unNumeroDePeano substractTo: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:58:38'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 19:03:43'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'. next previous: self.].
	^next
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 18:57:53'!
previous

	^previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 19:04:17'!
previous: numero

	previous := numero ! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 18:39:35'!
removeAllNext


next ifNotNil:

[

next removeAllNext.

next removeFromSystem.

next := nil.

]! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/26/2019 20:45:59'!
substractTo: aNumber
	^self previous substractTo: aNumber previous! !

II initializeAfterFileIn!