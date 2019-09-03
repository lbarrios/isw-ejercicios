!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'initialize' stamp: 'FL 9/2/2019 21:33:10'!
addAndSuspendCustomer: paulMcCartney into: customerBook
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'FL 9/2/2019 20:59:25'!
assert: aCustomerBook onlyIncludes: aCustomer
	
	[ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: aCustomer) ]! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'FL 9/2/2019 19:59:53'!
checkActiveCustomers: activeAmount suspendedCustomers: suspendedAmount totalCustomers: totalAmount in: customerBook

	self assert: activeAmount equals: customerBook numberOfActiveCustomers.
	self assert: suspendedAmount equals: customerBook numberOfSuspendedCustomers.
	self assert: totalAmount equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'FL 9/2/2019 21:52:56'!
should2: aClosure notTakeMoreThan: aTime
" 
Se llama should2 porque ya existe un método should en la clase padre TestCase
dejamos la implementación para que vean cómo lo hicimos
"
| millisecondsBeforeRunning millisecondsAfterRunning |

millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
aClosure value.
millisecondsAfterRunning := Time millisecondClockValue * millisecond.

self assert: millisecondsAfterRunning-millisecondsBeforeRunning < (aTime).! !


!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:50:10'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: 'John Lennon'.] notTakeMoreThan: (Duration milliSeconds: 50).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:52:03'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	self should: [customerBook addCustomerNamed: paulMcCartney.] notTakeMoreThan: (Duration milliSeconds: 100).
	"
	La implementación que hicimos era
	self should2: [customerBook addCustomerNamed: paulMcCartney.] notTakeMoreThan: (100 * millisecond).
	pero encontramos que existe un método should: ... notTakeMoreThan: ... en la clase padre.
	Así que lo reemplazamos.
	"
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 20:39:31'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self should: [ customerBook addCustomerNamed: ''. ] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:02:48'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self should: [ customerBook removeCustomerNamed: 'Paul McCartney'. ] 
		raise: NotFound 
		withExceptionDo: [ :anError | self assert: customerBook onlyIncludes: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:35:44'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCustomer: paulMcCartney into: customerBook.
	
	
	self checkActiveCustomers: 0 suspendedCustomers: 1 totalCustomers: 1 in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:36:11'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCustomer: paulMcCartney into: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkActiveCustomers: 0 suspendedCustomers: 0 totalCustomers: 0 in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:02:39'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook suspendCustomerNamed: 'Paul McCartney'.]
		raise: CantSuspend
		withExceptionDo: [ :anError | self assert: customerBook onlyIncludes: johnLennon ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FL 9/2/2019 21:33:43'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspendCustomer: johnLennon into: customerBook.

	self should: [customerBook suspendCustomerNamed: johnLennon.]
		raise: CantSuspend
		withExceptionDo: [ :anError | self assert: customerBook onlyIncludes: johnLennon ]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FL 9/2/2019 21:55:16'!
removeCustomerNamed: aName 

"Habíamos implementado un método 
self remove: ... ifAbsent: ...
Pero encontramos que la clase OrderedCollection ya implementa lo que queríamos, así que usamos directamente esa versión."

	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
			^ NotFound signal.]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
