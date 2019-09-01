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

!I class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:36:12'!
- unNumeroDePeano
	 
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:42:34'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:41:06'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:39:02'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los números menores a 1 no están soportados.'! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:28:52'!
- unNumeroDePeano
	 
	^[unNumeroDePeano substractTo: self] on: Error do: [self error: self name,' descripcionDeErrorDeNumerosNegativosNoSoportados'].! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:52:51'!
/ aNumber 
	
	^[self = aNumber ifTrue: [I] ifFalse: [self - aNumber / aNumber + I]] 
		on: Error 
		do: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:41:12'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:54:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
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


!classDefinition: #III category: #'Números de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Números de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Números de Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
* aNumber 
	^self previous * aNumber + aNumber! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next ! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
- unNumeroDePeano
	 
	^[unNumeroDePeano substractTo: self] on: Error do: [self error: self name,' descripcionDeErrorDeNumerosNegativosNoSoportados'].! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
/ aNumber 
	
	^[self = aNumber ifTrue: [I] ifFalse: [self - aNumber / aNumber + I]] 
		on: Error 
		do: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:54:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'. next previous: self.].
	^next
	
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
previous

	^previous ! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
previous: numero

	previous := numero ! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
removeAllNext


next ifNotNil:

[

next removeAllNext.

next removeFromSystem.

next := nil.

]! !

!III class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
substractTo: aNumber
	^self previous substractTo: aNumber previous! !


!classDefinition: #IIII category: #'Números de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Números de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Números de Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
* aNumber 
	^self previous * aNumber + aNumber! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
- unNumeroDePeano
	 
	^[unNumeroDePeano substractTo: self] on: Error do: [self error: self name,' descripcionDeErrorDeNumerosNegativosNoSoportados'].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
/ aNumber 
	
	^[self = aNumber ifTrue: [I] ifFalse: [self - aNumber / aNumber + I]] 
		on: Error 
		do: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:54:23'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
next

	next ifNil: [next := self cloneNamed: self name, 'I'. next previous: self.].
	^next
	
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
previous

	^previous ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
previous: numero

	previous := numero ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
removeAllNext


next ifNotNil:

[

next removeAllNext.

next removeFromSystem.

next := nil.

]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'FL 9/1/2019 16:53:22'!
substractTo: aNumber
	^self previous substractTo: aNumber previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!