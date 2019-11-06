!classDefinition: #TestTusLibros category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
TestCase subclass: #TestTusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/6/2019 17:43:51'!
alwaysOKMerchantProcessor
	
	^ MerchantProcessorMOCK with: [].! !

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

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/6/2019 16:45:43'!
expiredCreditCard
	| aCreditCard aMonthOfYear |
	aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 1) monthNumber: 1.
	aCreditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen'.
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

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/6/2019 16:44:12'!
validCreditCard
	| aCreditCard aMonthOfYear |
	aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999) monthNumber: 12.
	aCreditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen2'.
	^aCreditCard.! !


!classDefinition: #CartTest category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
TestTusLibros subclass: #CashierTest
	instanceVariableNames: 'anEmptyCart aCartWithAnItem aSalesbook anArbitraryDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:25:32'!
test01cannotCheckOutEmptyCart

	| aCashier aMerchantProcessor |
	
	aMerchantProcessor := self alwaysOKMerchantProcessor.
	aCashier _ Cashier for: anEmptyCart on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.
	
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier invalidCartErrorMessage.
			self assert: anEmptyCart isEmpty.
			self assert: aSalesbook isEmpty ]
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:26:02'!
test02checkingOutACartWithAnItemOnASalesBookReturnsATicketThatIsIncludedOnThatSalesBook

	| aCashier aTicket aMerchantProcessor |
	
	aMerchantProcessor := self alwaysOKMerchantProcessor.
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.

	aTicket := aCashier checkOut.
	
	self deny: aSalesbook isEmpty.
	self assert: (aSalesbook includes: aTicket).! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:25:32'!
test03checkingOutACartWithAnItemReturnsATicketWithTheItemValue

	| aCashier aTicket aMerchantProcessor |
	
	aMerchantProcessor := self alwaysOKMerchantProcessor.
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:25:32'!
test04checkingOutACartWithTwoItemsReturnsATicketWithTheSumOfTheItemValues

	| aCart aCashier aTicket aMerchantProcessor |
	aCart _ aCartWithAnItem.
	aCart add: self itemSellByTheStore2.
	
	aMerchantProcessor := self alwaysOKMerchantProcessor.
	aCashier _ Cashier for: aCart on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) + (self defaultCatalog at: self itemSellByTheStore2) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:27:49'!
test05cannotCheckoutWithAnExpiredCreditCard

	| aCashier aMerchantProcessor |
	
	aMerchantProcessor := self alwaysOKMerchantProcessor.
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self expiredCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier expiredCreditCardMessage.
			self deny: aCartWithAnItem isEmpty.
			self assert: aSalesbook isEmpty	
				]
			
			
			
			
			
			
			
			
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:39:49'!
test06checkingOutHandlesMerchantProcessorErrorCorrectly

	| aCashier aMerchantProcessor |
	
		
	aMerchantProcessor := MerchantProcessorMOCK with: [^ self error ].
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.

	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier merchantProcessorErrorMessage.
		]
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'LEB 11/6/2019 17:25:32'!
setUp

anEmptyCart := self createEmptyCartWithDefaultCatalog.
aCartWithAnItem := self createEmptyCartWithDefaultCatalog add: self itemSellByTheStore.
aSalesbook := self defaultSalesBook.
anArbitraryDate := FixedGregorianDate yearNumber: 3 monthNumber: 3 dayNumber: 3.! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
TestTusLibros subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 16:21:31'!
test01creditCardIsNotExpiredWhenItsExpirationDateIsGreaterThanAGivenDate
| creditCard aMonthOfYear |

aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 2020) monthNumber: 6.
creditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen'.

self deny: (creditCard isExpiredOn: (FixedGregorianDate yearNumber: 1 monthNumber: 1 dayNumber: 1)).




































"
aDate := FixedGregorianDate yearNumber: 1 monthNumber: 1 dayNumber: 1.
aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 1) monthNumber: 6.

aDate2 := GregorianMonthOfYear year: aDate year number monthNumber: aDate month number.
aDate2 < aMonthOfYear.

(aMonthOfYear > aDate or: aMonthOfYear = aDate) not.

aDate year.

(GregorianYear number: 1) = aDate year.
"! !

!CreditCardTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 16:25:09'!
test02creditCardIsExpiredWhenTheGivenDateIsGreaterThanExpirationDate
| creditCard aMonthOfYear |

aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 2020) monthNumber: 6.
creditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen'.

self assert: (creditCard isExpiredOn: (FixedGregorianDate yearNumber: 2020 monthNumber: 7 dayNumber: 1)).




































"
aDate := FixedGregorianDate yearNumber: 1 monthNumber: 1 dayNumber: 1.
aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 1) monthNumber: 6.

aDate2 := GregorianMonthOfYear year: aDate year number monthNumber: aDate month number.
aDate2 < aMonthOfYear.

(aMonthOfYear > aDate or: aMonthOfYear = aDate) not.

aDate year.

(GregorianYear number: 1) = aDate year.
"! !

!CreditCardTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 16:25:28'!
test03creditCardIsExpiredWhenTheGivenDateIsEqualThanExpirationDate
| creditCard aMonthOfYear |

aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 2020) monthNumber: 6.
creditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen'.

self assert: (creditCard isExpiredOn: (FixedGregorianDate yearNumber: 2020 monthNumber: 6 dayNumber: 1)).




































"
aDate := FixedGregorianDate yearNumber: 1 monthNumber: 1 dayNumber: 1.
aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 1) monthNumber: 6.

aDate2 := GregorianMonthOfYear year: aDate year number monthNumber: aDate month number.
aDate2 < aMonthOfYear.

(aMonthOfYear > aDate or: aMonthOfYear = aDate) not.

aDate year.

(GregorianYear number: 1) = aDate year.
"! !


!classDefinition: #Cart category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook creditCard date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialize' stamp: 'LEB 11/6/2019 16:54:02'!
initializeFor: aCart on: aSalesBook with: aCreditCard onDate: aGregorianDate withMerchantProcessor: aMerchantProcessor 
	
	cart := aCart.
	salesBook := aSalesBook.
	creditCard := aCreditCard.
	date := aGregorianDate.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'LEB 11/6/2019 17:42:09'!
checkOut
	| aTicket |
	cart isEmpty ifTrue: [self error: self invalidCartErrorMessage].
	(creditCard isExpiredOn: date) ifTrue: [self error: self expiredCreditCardMessage].
	
	aTicket := cart getTicket.
	
	[merchantProcessor debit: aTicket from: creditCard] on: Error do: [self error: self merchantProcessorErrorMessage].
	
	salesBook add: aTicket.
	^aTicket! !


!Cashier methodsFor: 'error message' stamp: 'EEEE 11/4/2019 21:12:37'!
expiredCreditCardMessage
	^'Tu tarjeta esta rancia'! !

!Cashier methodsFor: 'error message' stamp: 'FL 11/4/2019 19:23:07'!
invalidCartErrorMessage
	^'The cart is empty'! !

!Cashier methodsFor: 'error message' stamp: 'LEB 11/6/2019 17:42:41'!
merchantProcessorErrorMessage
	^'El merchant procesor se murió'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 16:53:41'!
for: aCart on: aSalesBook with: aCreditCard onDate: aGregorianDate withMerchantProcessor: aMerchantProcessor  
	
	^self new initializeFor: aCart on: aSalesBook with: aCreditCard onDate: aGregorianDate withMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'LEB 11/6/2019 16:29:03'!
isExpiredOn: aDate
^ (aDate monthOfYear < expiration) not.
! !


!CreditCard methodsFor: 'initialization' stamp: 'LEB 11/6/2019 16:30:03'!
initializeWithNumber: aNumber expiringOn: anExpirationMonthOfYear ownedBy: anOwnerName 
	number := aNumber.
	expiration := anExpirationMonthOfYear.
	owner := anOwnerName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 15:45:41'!
withNumber: aNumber expiringOn: aMonthOfYear ownedBy: aName
	^self new initializeWithNumber: aNumber expiringOn: aMonthOfYear ownedBy: aName! !


!classDefinition: #MerchantProcessor category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'LEB 11/6/2019 17:37:34'!
debit: anAmount from: aCreditCard

self shouldBeImplemented.
! !


!classDefinition: #MerchantProcessorMOCK category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
MerchantProcessor subclass: #MerchantProcessorMOCK
	instanceVariableNames: 'blockClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorMOCK methodsFor: 'initialization' stamp: 'LEB 11/6/2019 17:38:18'!
debit: anAmount from: aCreditCard

^blockClosure value.! !

!MerchantProcessorMOCK methodsFor: 'initialization' stamp: 'LEB 11/6/2019 17:32:30'!
initializeWith: aBlockClosure 
	blockClosure := aBlockClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMOCK class' category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
MerchantProcessorMOCK class
	instanceVariableNames: ''!

!MerchantProcessorMOCK class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 17:32:08'!
with: aBlockClosure 
	^self new initializeWith: aBlockClosure ! !


!classDefinition: #Ticket category: #TusLibros stamp: 'LEB 11/6/2019 17:44:06'!
Object subclass: #Ticket
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
