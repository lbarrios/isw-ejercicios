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

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/27/2019 16:10:47'!
- unNumeroDePeano
	 
	self error: 'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 8/27/2019 16:01:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifFalse: [self error:'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].
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

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/27/2019 16:16:02'!
- unNumeroDePeano
	 "TODO que tire el error  'descripcionDeErrorDeNumerosNegativosNoSoportados' en vez de no entender el mensaje previous cuando no se puede hacer la resta"
	^unNumeroDePeano substractTo: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/27/2019 16:08:52'!
/ aNumber 
	"TODO por el momento solo anda si con I"
	^self - aNumber / aNumber + 1! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 8/27/2019 16:16:37'!
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