!classDefinition: #TestTusLibros category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
TestCase subclass: #TestTusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 20:31:14'!
createEmptyCartWithDefaultCatalog
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 20:59:27'!
defaultCatalog
	| aCatalog |
	aCatalog := Dictionary new.
	aCatalog add: self itemSellByTheStore -> 5.
	aCatalog add: self itemSellByTheStore2 -> 99099999999.
	^ aCatalog.! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:45:54'!
defaultSalesBook
	
	^ OrderedCollection new.! !

!TestTusLibros methodsFor: 'support' stamp: 'EEEE 11/4/2019 21:15:58'!
expiredCreditCard
	| aCreditCard |
	aCreditCard := CreditCard new.
	aCreditCard expire.
	^aCreditCard.! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:19:03'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:19:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 20:59:13'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!TestTusLibros methodsFor: 'support' stamp: 'EEEE 11/4/2019 21:16:47'!
validCreditCard

	^CreditCard new.! !


!classDefinition: #CartTest category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
TestTusLibros subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test01NewCartsAreCreatedEmpty

	self assert: self createEmptyCartWithDefaultCatalog isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FL 11/4/2019 20:31:14'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
TestTusLibros subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'EEEE 11/4/2019 21:07:03'!
test01cannotCheckOutEmptyCart

	| aCart aCashier aSalesBook |
	
	aCart _ self createEmptyCartWithDefaultCatalog.
	aSalesBook := self defaultSalesBook.
	aCashier _ Cashier for: aCart on: aSalesBook with: self validCreditCard.
	
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier invalidCartErrorMessage.
			self assert: aCart isEmpty.
			self assert: aSalesBook isEmpty ]
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'EEEE 11/4/2019 21:07:03'!
test02checkingOutACartWithAnItemOnASalesBookReturnsATicketThatIsIncludedOnThatSalesBook

	| aCashier aSalesBook aTicket |
	aSalesBook _ self defaultSalesBook.
	
	aCashier _ Cashier for: (self createEmptyCartWithDefaultCatalog add: self itemSellByTheStore) on: aSalesBook with: self validCreditCard.
	aTicket := aCashier checkOut.
	
	self deny: aSalesBook isEmpty.
	self assert: (aSalesBook includes: aTicket).! !

!CashierTest methodsFor: 'tests' stamp: 'EEEE 11/4/2019 21:07:03'!
test03checkingOutACartWithAnItemReturnsATicketWithTheItemValue

	| aCart aCashier aTicket |
	aCart _ self createEmptyCartWithDefaultCatalog.
	aCart add: self itemSellByTheStore.
	
	aCashier _ Cashier for: aCart on: self defaultSalesBook with: self validCreditCard.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'EEEE 11/4/2019 21:07:03'!
test04checkingOutACartWithTwoItemsReturnsATicketWithTheSumOfTheItemValues

	| aCart aCashier aTicket |
	aCart _ self createEmptyCartWithDefaultCatalog.
	aCart add: self itemSellByTheStore.
	aCart add: self itemSellByTheStore2.
	
	aCashier _ Cashier for: aCart on: self defaultSalesBook with: self validCreditCard.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) + (self defaultCatalog at: self itemSellByTheStore2) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'EEEE 11/4/2019 21:13:21'!
test05cannotCheckoutWithAnExpiredCreditCard

	| aCart aCashier |
	aCart _ self createEmptyCartWithDefaultCatalog.
	aCart add: self itemSellByTheStore.
	
	aCashier _ Cashier for: aCart on: self defaultSalesBook with: self expiredCreditCard.
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier expiredCreditCardMessage.
		]
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !


!classDefinition: #Cart category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FL 11/4/2019 20:29:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'TBD' stamp: 'FL 11/4/2019 20:54:55'!
getTicket
"
aTicket _ Ticket new.
items do: [:anItem | aTicket add: anItem -> (self occurrencesOf: anItem) -> ((catalog at: anItem) * (self occurrencesOf: anItem)) ].
"

^ items inject: 0 into: [:total :anItem | total + ((catalog at: anItem) * (self occurrencesOf: anItem)) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialize' stamp: 'EEEE 11/4/2019 21:05:42'!
initializeFor: aCart on: aSalesBook with: aCreditCard .
	
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'EEEE 11/4/2019 21:17:34'!
checkOut
	| aTicket |
	cart isEmpty ifTrue: [self error: self invalidCartErrorMessage].
	creditCard isExpired ifTrue: [self error: self expiredCreditCardMessage].
	
	aTicket := cart getTicket.
	salesBook add: aTicket.
	^aTicket! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'EEEE 11/4/2019 21:12:37'!
expiredCreditCardMessage
	^'Tu tarjeta esta rancia'! !


!Cashier methodsFor: 'error message' stamp: 'FL 11/4/2019 19:23:07'!
invalidCartErrorMessage
	^'The cart is empty'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'EEEE 11/4/2019 21:07:19'!
for: aCart on: aSalesBook with: aCreditCard   
	
	^self new initializeFor: aCart on: aSalesBook with: aCreditCard.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Object subclass: #CreditCard
	instanceVariableNames: 'expired'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'EEEE 11/4/2019 21:15:15'!
expire
expired := true.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'EEEE 11/4/2019 21:16:21'!
initialize
expired := false.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'EEEE 11/4/2019 21:14:29'!
isExpired
^expired! !


!classDefinition: #MerchantProcessor category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #MerchantProcessorMOCK category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
MerchantProcessor subclass: #MerchantProcessorMOCK
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Ticket category: #TusLibros stamp: 'EEEE 11/4/2019 21:33:01'!
Object subclass: #Ticket
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
