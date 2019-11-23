!classDefinition: #TestTusLibros category: #TusLibros!
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

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/14/2019 17:31:09'!
defaultClock
^FixedClock with: DateAndTime now! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/11/2019 20:58:48'!
defaultCredentials
| credentials |

credentials := Dictionary new.
credentials add: (self username1)->(self passwordForUsername1).
credentials add: 'user2'->'pass2'.
credentials add: 'user3'->'pass3'.
credentials add: 'user4'->'pass4'.
credentials add: 'user5'->'pass5'.
^credentials.! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/14/2019 17:30:39'!
defaultRestInterface
	
	^ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: self defaultSalesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: self defaultClock.! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:45:54'!
defaultSalesBook
	
	^ OrderedCollection new.! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/6/2019 16:45:43'!
expiredCreditCard
	| aCreditCard aMonthOfYear |
	aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 1) monthNumber: 1.
	aCreditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen'.
	^aCreditCard.! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/11/2019 18:02:05'!
invalidCartId

^ #invalidCartId! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/7/2019 20:23:22'!
invalidPassword

^'valid password'! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/7/2019 20:23:12'!
invalidUsername

^'invalid username'! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:19:03'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 19:19:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestTusLibros methodsFor: 'support' stamp: 'FL 11/4/2019 20:59:13'!
itemSellByTheStore2
	
	^ 'validBook2'! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/11/2019 20:58:23'!
passwordForUsername1

^'valid password'! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/11/2019 20:58:32'!
username1

^'valid username'! !

!TestTusLibros methodsFor: 'support' stamp: 'LEB 11/6/2019 16:44:12'!
validCreditCard
	| aCreditCard aMonthOfYear |
	aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999) monthNumber: 12.
	aCreditCard := CreditCard withNumber: 1 expiringOn: aMonthOfYear ownedBy: 'wilkinsen2'.
	^aCreditCard.! !


!classDefinition: #CartTest category: #TusLibros!
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

!CartTest methodsFor: 'tests' stamp: 'LEB 11/7/2019 20:54:26'!
test09EachExecutesClosure

	| counter cart |
	counter := 0.
	
	cart := self createEmptyCartWithDefaultCatalog.
	
	cart add: 10 of: self itemSellByTheStore.
	cart each: [:item | counter := counter + 1].
	self assert: 10 equals: counter.! !


!classDefinition: #CashierTest category: #TusLibros!
TestTusLibros subclass: #CashierTest
	instanceVariableNames: 'anEmptyCart aCartWithAnItem aSalesbook anArbitraryDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/11/2019 19:22:03'!
test01cannotCheckOutEmptyCart

	| aCashier |
	
	aCashier _ Cashier for: anEmptyCart on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: self alwaysOKMerchantProcessor.
	
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.
			self assert: anEmptyCart isEmpty.
			self assert: aSalesbook isEmpty ]
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:50:25'!
test02checkingOutACartWithAnItemOnASalesBookReturnsATicketThatIsIncludedOnThatSalesBook

	| aCashier aTicket |
	
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: self alwaysOKMerchantProcessor.

	aTicket := aCashier checkOut.
	
	self deny: aSalesbook isEmpty.
	self assert: (aSalesbook includes: aTicket).! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:50:49'!
test03checkingOutACartWithAnItemReturnsATicketWithTheItemValue

	| aCashier aTicket |
	
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: self alwaysOKMerchantProcessor.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:51:02'!
test04checkingOutACartWithTwoItemsReturnsATicketWithTheSumOfTheItemValues

	| aCart aCashier aTicket |
	aCart _ aCartWithAnItem.
	aCart add: self itemSellByTheStore2.
	
	aCashier _ Cashier for: aCart on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: self alwaysOKMerchantProcessor.
	aTicket := aCashier checkOut.
	
	self assert: (self defaultCatalog at: self itemSellByTheStore) + (self defaultCatalog at: self itemSellByTheStore2) equals: aTicket.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	"
	NO CORREGIR LO SIGUIENTE:
	self assert: 1 equals: aTicket size.
	self assert: (aTicket at: 1) key key equals: self itemSellByTheStore.
	self assert: (aTicket at: 1) key value equals: 1.
	self assert: (aTicket at: 1) value equals: (self defaultCatalog at: self itemSellByTheStore).
	"! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/11/2019 18:36:53'!
test05cannotCheckoutWithAnExpiredCreditCard

	| aCashier |
	
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self expiredCreditCard onDate: anArbitraryDate withMerchantProcessor: self alwaysOKMerchantProcessor.
	
	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCreditCardMessage.
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

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/11/2019 18:37:15'!
test06checkingOutHandlesMerchantProcessorErrorCorrectly

	| aCashier aMerchantProcessor |
	
		
	aMerchantProcessor := MerchantProcessorMOCK with: [^ self error ].
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.

	self 
		should: [aCashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier merchantProcessorErrorMessage.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'LEB 11/6/2019 17:51:54'!
test07checkingOutCommunicatesWithMerchantProcessor

	| aCashier aMerchantProcessor communicationFlag |
	
	communicationFlag := false.
	aMerchantProcessor := MerchantProcessorMOCK with: [ communicationFlag := true ].
	
	aCashier _ Cashier for: aCartWithAnItem on: aSalesbook with: self validCreditCard onDate: anArbitraryDate withMerchantProcessor: aMerchantProcessor.
	aCashier checkOut.
	
	self assert: communicationFlag.! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'LEB 11/6/2019 17:25:32'!
setUp

anEmptyCart := self createEmptyCartWithDefaultCatalog.
aCartWithAnItem := self createEmptyCartWithDefaultCatalog add: self itemSellByTheStore.
aSalesbook := self defaultSalesBook.
anArbitraryDate := FixedGregorianDate yearNumber: 3 monthNumber: 3 dayNumber: 3.! !


!classDefinition: #CreditCardTest category: #TusLibros!
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


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestTusLibros subclass: #RestInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/7/2019 21:03:29'!
test01cannotCreateCartWithInvalidUserCredencials

| interface |

interface _ self defaultRestInterface.

self 
	should: [interface createCartForClientId: self invalidUsername identifiedByPassword: self invalidPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidUserCredencialsErrorMessage.
	]

! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test02listCartOfAJustCreatedCartIsEmpty

| interface cartId |
interface _ self defaultRestInterface.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
self assert: ((interface listCart: cartId) isEmpty).! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 18:02:05'!
test03cannotListCartForAnInvalidCartId

| interface |
interface _ self defaultRestInterface.

self 
	should: [interface listCart: self invalidCartId.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidCartIdErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test04listingACartAfterAddingAnItemContainsThatItem

| interface cartId cartList |
interface _ self defaultRestInterface.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.

cartList _ interface listCart: cartId.

self assert: (cartList includesKey: (self itemSellByTheStore)).
self assert: 5 equals: (cartList at: (self itemSellByTheStore)).! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 19:46:31'!
test05bCannotAddToCartWithANonPositiveValue

| interface cartId |
interface _ self defaultRestInterface.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.

self 
	should: [interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 0.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | | cartList |
		self assert: anError messageText = RestInterface invalidQuantityErrorMessage.
		
		cartList _ interface listCart: cartId.
		self assert: (cartList includesKey: (self itemSellByTheStore)).
		self assert: 5 equals: (cartList at: (self itemSellByTheStore)).
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 18:02:05'!
test05cannotAddToAnInvalidIdCart

| interface |
interface _ self defaultRestInterface.

self 
	should: [interface addToCart: self invalidCartId isbn: (self itemSellByTheStore) quantity: 5.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidCartIdErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 18:02:54'!
test06cannotCheckoutOnAnInvalidIdCart

| interface |
interface _ self defaultRestInterface.

self 
	should: [interface checkoutCart: self invalidCartId withCreditCard: self validCreditCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidCartIdErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test07cannotCheckoutWithAnEmptyCart

| interface cartId |
interface _ self defaultRestInterface.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.

self 
	should: [interface checkoutCart: cartId withCreditCard: self expiredCreditCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface emptyCartErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test08cannotCheckoutWithAnExpiredCreditCard

| interface cartId |
interface _ self defaultRestInterface.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.

self 
	should: [interface checkoutCart: cartId withCreditCard: self expiredCreditCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface expiredCreditCardMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:31:24'!
test09cannotCheckoutIfMerchantProcessorFails

| interface cartId |
interface _ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: self defaultSalesBook 
withMerchantProcessor: (MerchantProcessorMOCK with: [self error.]) withClock: self defaultClock.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.

self 
	should: [interface checkoutCart: cartId withCreditCard: self validCreditCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface merchantProcessorErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test10cannotUseCartAfterCheckout

| interface cartId |
interface _ self defaultRestInterface.
cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

self 
	should: [interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidCartIdErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test11listingPurchasesOfANewUserIsEmpty

| interface purchases |
interface _ self defaultRestInterface.

purchases _ interface listPurchasesForClientId: self username1 identifiedByPassword: self passwordForUsername1.

self assert: purchases items isEmpty.
self assert: purchases total equals: 0.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:32:08'!
test12cannotListPurchasesWithInvalidUserCredencials

| interface |

interface _ self defaultRestInterface.

self 
	should: [interface listPurchasesForClientId: self invalidUsername identifiedByPassword: self invalidPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface invalidUserCredencialsErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 20:58:32'!
test13listingPurchasesAfterCheckingOutACartWithAnItemContainsThatItem

| interface cartId pass purchases user |
interface _ self defaultRestInterface.

user _ self username1.
pass _ self passwordForUsername1.

cartId _ interface createCartForClientId: user identifiedByPassword: pass.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

purchases _ interface listPurchasesForClientId: user identifiedByPassword: pass.

self assert: (purchases items includesKey: (self itemSellByTheStore)).
self assert: 5 equals: (purchases items at: (self itemSellByTheStore)).
self assert: 5 * (self defaultCatalog at: self itemSellByTheStore) equals: purchases total.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 21:08:25'!
test14listingManyPurchasesAfterCheckingOutManyCartsWithManyItemsWithMultipleUsersContainsAllThoseItemsForEachUser

| interface cartId pass purchases user pass2 user2 purchases2 |
interface _ self defaultRestInterface.

user _ self username1.
pass _ self passwordForUsername1.
user2 _ 'user2'.
pass2 _ 'pass2'.

cartId _ interface createCartForClientId: user identifiedByPassword: pass.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

cartId _ interface createCartForClientId: user2 identifiedByPassword: pass2.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 100.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

cartId _ interface createCartForClientId: user identifiedByPassword: pass.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 10.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

cartId _ interface createCartForClientId: user identifiedByPassword: pass.
interface addToCart: cartId isbn: (self itemSellByTheStore2) quantity: 3.
interface checkoutCart: cartId withCreditCard: self validCreditCard.

purchases _ interface listPurchasesForClientId: user identifiedByPassword: pass.
purchases2 _ interface listPurchasesForClientId: user2 identifiedByPassword: pass2.

self assert: (purchases items includesKey: (self itemSellByTheStore)).
self assert: (purchases items includesKey: (self itemSellByTheStore2)).
self assert: 15 equals: (purchases items at: (self itemSellByTheStore)).
self assert: 3 equals: (purchases items at: (self itemSellByTheStore2)).
self assert: (15 * (self defaultCatalog at: self itemSellByTheStore)) + (3 * (self defaultCatalog at: self itemSellByTheStore2)) equals: purchases total.
self assert: (purchases2 items includesKey: (self itemSellByTheStore)).
self assert: 100 equals: (purchases2 items at: (self itemSellByTheStore)).
self assert: (100 * (self defaultCatalog at: self itemSellByTheStore)) equals: purchases2 total.! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:39:23'!
test15cannotAddToCartAfter30MinutesOfInactivity

| interface cartId clock |

clock _ self defaultClock.
interface _ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: self defaultSalesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: clock.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
clock addTime: (Duration minutes: 31).

self 
	should: [interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface expiredCartErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:39:38'!
test16cannotListCartAfter30MinutesOfInactivity

| interface cartId clock |

clock _ self defaultClock.
interface _ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: self defaultSalesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: clock.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
clock addTime: (Duration minutes: 31).
self 
	should: [interface listCart: cartId.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface expiredCartErrorMessage.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:39:42'!
test17cannotCheckOutCartAfter30MinutesOfInactivity

| interface cartId clock salesBook |

clock _ self defaultClock.
salesBook _ self defaultSalesBook.
interface _ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: salesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: clock.

cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
clock addTime: (Duration minutes: 31).
self 
	should: [interface checkoutCart: cartId withCreditCard: self validCreditCard.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = RestInterface expiredCartErrorMessage.
		self assert: salesBook isEmpty.
	]! !

!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'FL 11/17/2019 16:24:35'!
test18cartIsStillValidAfterMoreThan30MinutesIfUsedFrequently

| interface cartId clock salesBook |

clock _ self defaultClock.
salesBook _ self defaultSalesBook.
interface _ RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: salesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: clock.

self shouldnt:  [
	cartId _ interface createCartForClientId: self username1 identifiedByPassword: self passwordForUsername1.
	clock addTime: (Duration minutes: 29).
	interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
	clock addTime: (Duration minutes: 29).
	interface listCart: cartId.
	clock addTime: (Duration minutes: 29).
	interface addToCart: cartId isbn: (self itemSellByTheStore) quantity: 5.
	clock addTime: (Duration minutes: 29).
	interface listCart: cartId.
	clock addTime: (Duration minutes: 29).
	interface checkoutCart: cartId withCreditCard: self validCreditCard.] raise: Error.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'LEB 11/14/2019 18:05:25'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage.! !


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


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'TBD' stamp: 'LEB 11/11/2019 20:52:46'!
getTicket
"
aTicket _ Ticket new.
items do: [:anItem | aTicket add: anItem -> (self occurrencesOf: anItem) -> ((catalog at: anItem) * (self occurrencesOf: anItem)) ].
"

"
^ items inject: 0 into: [:total :anItem | total + ((catalog at: anItem) * (self occurrencesOf: anItem)) ]
"

^ items inject: 0 into: [:total :anItem | total + ((catalog at: anItem)) ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'LEB 11/7/2019 20:55:29'!
each: aBlockClosure 
	items do: [:item | aBlockClosure value: item].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LEB 11/14/2019 18:04:47'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: #TusLibros!
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


!Cashier methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:22:03'!
checkOut
	| aTicket |
	cart isEmpty ifTrue: [self error: self class emptyCartErrorMessage].
	(creditCard isExpiredOn: date) ifTrue: [self error: self class expiredCreditCardMessage].
	
	aTicket := cart getTicket.
	
	[merchantProcessor debit: aTicket from: creditCard] on: Error do: [self error: self class merchantProcessorErrorMessage].
	
	salesBook add: aTicket.
	^aTicket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 16:53:41'!
for: aCart on: aSalesBook with: aCreditCard onDate: aGregorianDate withMerchantProcessor: aMerchantProcessor  
	
	^self new initializeFor: aCart on: aSalesBook with: aCreditCard onDate: aGregorianDate withMerchantProcessor: aMerchantProcessor.! !


!Cashier class methodsFor: 'error messages' stamp: 'LEB 11/11/2019 19:22:03'!
emptyCartErrorMessage
	^'The cart is empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'LEB 11/11/2019 18:36:39'!
expiredCreditCardMessage
	^'Tu tarjeta esta rancia'! !

!Cashier class methodsFor: 'error messages' stamp: 'LEB 11/11/2019 18:36:32'!
merchantProcessorErrorMessage
	^'El merchant procesor se murió'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 21:48:04'!
now! !


!classDefinition: #FixedClock category: #TusLibros!
Clock subclass: #FixedClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FixedClock methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 21:51:07'!
addTime: anInterval
time := time + anInterval! !

!FixedClock methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:25:26'!
initializeWith: aDate

time _ aDate.! !

!FixedClock methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 21:51:13'!
now

^time! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedClock class' category: #TusLibros!
FixedClock class
	instanceVariableNames: ''!

!FixedClock class methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 17:26:20'!
with: initialDate
^self new initializeWith: initialDate.! !


!classDefinition: #CreditCard category: #TusLibros!
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

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 15:45:41'!
withNumber: aNumber expiringOn: aMonthOfYear ownedBy: aName
	^self new initializeWithNumber: aNumber expiringOn: aMonthOfYear ownedBy: aName! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'LEB 11/6/2019 17:37:34'!
debit: anAmount from: aCreditCard

self shouldBeImplemented.
! !


!classDefinition: #MerchantProcessorMOCK category: #TusLibros!
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

!classDefinition: 'MerchantProcessorMOCK class' category: #TusLibros!
MerchantProcessorMOCK class
	instanceVariableNames: ''!

!MerchantProcessorMOCK class methodsFor: 'instance creation' stamp: 'LEB 11/6/2019 17:32:08'!
with: aBlockClosure 
	^self new initializeWith: aBlockClosure ! !


!classDefinition: #Purchase category: #TusLibros!
Object subclass: #Purchase
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 20:51:35'!
+ anotherPurchase
	| newItems |
	newItems _ items copy.
	anotherPurchase items keysAndValuesDo: [:k :v | newItems add: k->(v+(newItems at: k ifAbsent: [0]))].
	^Purchase withItems: newItems total: total+anotherPurchase total.! !

!Purchase methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:46:57'!
initializeWithItems: aListOfItems total: anAmount

items _ aListOfItems.
total _ anAmount.! !

!Purchase methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:49:01'!
items

^items! !

!Purchase methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:49:08'!
total

^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: #TusLibros!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:46:28'!
withItems: aListOfItems total: anAmount

	^ self new initializeWithItems: aListOfItems total: anAmount.! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'carts userForCarts catalog credentials salesBook merchantProcessor purchases clock lastUsedTime sessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'LEB 11/14/2019 20:51:35'!
initializeWithCatalog: aCatalog withCredentials: aCredentialsDictionary withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withClock: aClock

catalog _ aCatalog.
salesBook _ aSalesBook.
merchantProcessor _ aMerchantProcessor.
credentials _ aCredentialsDictionary.
clock _ aClock.
sessions _ Dictionary new. 
purchases _ Dictionary new.
	credentials keysDo: [:user | purchases add: user->(Purchase withItems: Dictionary new total: 0)].! !


!RestInterface methodsFor: 'usage' stamp: 'LEB 11/14/2019 20:52:52'!
addToCart: cartId isbn: anIsbn quantity: anAmount
	
	(self getCart: cartId) add: anAmount of: anIsbn.! !

!RestInterface methodsFor: 'usage' stamp: 'LEB 11/14/2019 20:51:35'!
checkoutCart: cartId withCreditCard: creditCard 
	| ticket session purchase |
	
	session _ self getSession: cartId.
	
	ticket _ self getTicketFor: session cart withCreditCard: creditCard.
	
	purchase _ (Purchase withItems: (self listCart: cartId) total: ticket). 
	self addPurchase: purchase forUser: session user.
	
	sessions removeKey: cartId.
	^ticket.! !

!RestInterface methodsFor: 'usage' stamp: 'LEB 11/14/2019 20:42:27'!
createCartForClientId: anUsername identifiedByPassword: aPassword
	| newCartId |

	self checkPassword: aPassword forUsername: anUsername.
	newCartId _ self getHashForUsername: anUsername.
	sessions add: newCartId->(Session 
		forUser: anUsername 
		withCart: (Cart acceptingItemsOf: catalog) 
		using: clock).

	^newCartId.! !

!RestInterface methodsFor: 'usage' stamp: 'LEB 11/14/2019 20:53:35'!
listCart: cartId
	| cartList |
	
	cartList _ Dictionary new.
	(self getCart: cartId) each: [:item | cartList add: item->(1+(cartList at:item ifAbsent:[0]))].
	
	^ cartList.! !

!RestInterface methodsFor: 'usage' stamp: 'LEB 11/14/2019 20:38:49'!
listPurchasesForClientId: anUsername identifiedByPassword: aPassword 
	
	self checkPassword: aPassword forUsername: anUsername.
	^purchases at: anUsername.! !


!RestInterface methodsFor: 'private' stamp: 'LEB 11/14/2019 20:49:33'!
addPurchase: aPurchase forUser: anUser
	purchases at: anUser put: ((purchases at: anUser) + aPurchase).
	! !

!RestInterface methodsFor: 'private' stamp: 'LEB 11/14/2019 20:53:07'!
getCart: cartId

^ (self getSession: cartId) cart! !

!RestInterface methodsFor: 'private' stamp: 'LEB 11/14/2019 20:42:27'!
getHashForUsername: anUsername
"
	Hacer de cuenta que esto es un UUID... 
"
^ (anUsername), Time now hash asString! !

!RestInterface methodsFor: 'private' stamp: 'LEB 11/14/2019 20:35:46'!
getSession: aCartId

^ sessions at: aCartId ifAbsent: [self error: self class invalidCartIdErrorMessage].! !

!RestInterface methodsFor: 'private' stamp: 'LEB 11/14/2019 20:47:32'!
getTicketFor: aCart withCreditCard: creditCard

	| cashier |
	cashier _ Cashier for: aCart on: salesBook with: creditCard onDate: (FixedGregorianDate fromDate: (clock now)) withMerchantProcessor: merchantProcessor.
	^cashier checkOut.! !


!RestInterface methodsFor: 'private - preconditions' stamp: 'LEB 11/14/2019 20:43:45'!
checkPassword: aPassword forUsername: anUsername 
	(self isValidPassword: aPassword forUsername: anUsername) ifFalse: [self error: self class invalidUserCredencialsErrorMessage.].
! !

!RestInterface methodsFor: 'private - preconditions' stamp: 'LEB 11/7/2019 21:19:12'!
isValidPassword: aPassword forUsername: anUsername
	
	^aPassword = (credentials at: anUsername ifAbsent: [^false.]).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'error messages' stamp: 'LEB 11/11/2019 19:22:03'!
emptyCartErrorMessage
^ Cashier emptyCartErrorMessage.! !

!RestInterface class methodsFor: 'error messages' stamp: 'LEB 11/7/2019 20:08:48'!
invalidCartIdErrorMessage
	^'El id de carrito no es válido.'! !

!RestInterface class methodsFor: 'error messages' stamp: 'LEB 11/7/2019 20:06:52'!
invalidUserCredencialsErrorMessage
	^'El usuario o el password no es válido'.! !


!RestInterface class methodsFor: 'instance creation' stamp: 'LEB 11/11/2019 21:55:32'!
withCatalog: aCatalog withCredentials: aCredentialsDictionary withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withClock: aClock 
^self new initializeWithCatalog: aCatalog 
	withCredentials: aCredentialsDictionary 
	withSalesBook: aSalesBook 
	withMerchantProcessor: aMerchantProcessor 
	withClock: aClock.! !


!RestInterface class methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 21:52:05'!
expiredCartErrorMessage
	^'El reloj se expiró'! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:03:52'!
expiredCreditCardMessage
	^ Cashier expiredCreditCardMessage.! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'LEB 11/14/2019 18:04:36'!
invalidQuantityErrorMessage
	^Cart invalidQuantityErrorMessage.! !

!RestInterface class methodsFor: 'as yet unclassified' stamp: 'LEB 11/11/2019 19:08:34'!
merchantProcessorErrorMessage
	^Cashier merchantProcessorErrorMessage.! !


!classDefinition: #Session category: #TusLibros!
Object subclass: #Session
	instanceVariableNames: 'username cart clock lastUsedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'private - usage' stamp: 'LEB 11/14/2019 20:19:54'!
checkAndRefreshSession

	(clock now > (lastUsedTime + (Duration minutes: 30))) ifTrue: [self error: RestInterface expiredCartErrorMessage].
	lastUsedTime := clock now.! !


!Session methodsFor: 'initialization' stamp: 'LEB 11/14/2019 20:14:00'!
initializeForUser: anUsername withCart: aCart using: aClock 
	username := anUsername.
	cart := aCart.
	clock := aClock.
	lastUsedTime := clock now.! !


!Session methodsFor: 'getters' stamp: 'LEB 11/14/2019 20:27:58'!
cart
self checkAndRefreshSession.
^cart! !

!Session methodsFor: 'getters' stamp: 'LEB 11/14/2019 20:28:54'!
user
self checkAndRefreshSession.
^username! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #TusLibros!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'LEB 11/14/2019 20:06:14'!
forUser: anUsername withCart: aCart using: aClock 
	^self new initializeForUser: anUsername withCart: aCart using: aClock ! !


!classDefinition: #TusLibrosServerController category: #TusLibros!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'port restInterface webServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosServerController methodsFor: 'destroy' stamp: 'LEB 11/21/2019 19:15:10'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'LEB 11/21/2019 20:37:44'!
initializeWith: aPortNumber
	
	restInterface := RestInterface withCatalog: self defaultCatalog withCredentials: self defaultCredentials withSalesBook: self defaultSalesBook withMerchantProcessor: self alwaysOKMerchantProcessor withClock: self defaultClock.
	
	port := aPortNumber.
	
	webServer := WebServer new listenOn: port.
	
	webServer addService: '/createCart' action:[:request | | clientId password |
		[ | cartId |
			clientId := (request fields at:'clientId').
			password := (request fields at:'password').
			cartId := restInterface createCartForClientId: clientId identifiedByPassword: password.
			request send200Response: '0|' , cartId.
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: ('1|',anError messageText) ]].

	webServer addService: '/addToCart' action:[:request | | cartId bookIsbn bookQuantity |
		[ | |
			cartId := (request fields at:'cartId').
			bookIsbn := (request fields at:'bookIsbn').
			bookQuantity := (request fields at:'bookQuantity') asInteger.
			restInterface addToCart: cartId isbn: bookIsbn quantity: bookQuantity.
			request send200Response: '0|OK'.
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: ('1|',anError messageText) ]].

	webServer addService: '/listCart' action:[:request | | cartId |
		[ | cartList response |
			cartId := (request fields at:'cartId').
			cartList := restInterface listCart: cartId.
			response := ''.
			cartList keysAndValuesDo: [:aKey :aValue | response := response, '|', aKey asString, '|', aValue asString.].
			request send200Response: (response size = 0 ifTrue: ['0|'] ifFalse: ['0',response]).
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: ('1|',anError messageText) ]].

	webServer addService: '/checkOutCart' action:[:request | | cartId ccn cced |
		[ | ticket aMonthOfYear |
			cartId := (request fields at:'cartId').
			ccn := (request fields at:'ccn').
			cced := (request fields at:'cced').
			aMonthOfYear := GregorianMonthOfYear year: (GregorianYear number: 2020) monthNumber: 6. "ARREGLAR ESTO"
			ticket := restInterface checkoutCart: cartId withCreditCard: (CreditCard withNumber: ccn expiringOn: aMonthOfYear ownedBy: 'alguien').
			request send200Response: 'CheckoutCart: ', ticket asString.
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: ('1|',anError messageText) ]].


	webServer addService: '/listPurchases' action:[:request | | clientId password |
		[ | purchases response |
			clientId := (request fields at:'clientId').
			password := (request fields at:'password').
			purchases := restInterface listPurchasesForClientId: clientId identifiedByPassword: password.
			response := ''.
			(purchases items) keysAndValuesDo: [:aKey :aValue | response := response, '|', aKey asString, '|', aValue asString.].
			request send200Response: '0|',response,'|',purchases total asString.
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: ('1|',anError messageText) ]].! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'LEB 11/21/2019 19:12:26'!
port
	
	^port ifNil: [port:=8080].
	
	! !


!TusLibrosServerController methodsFor: 'support' stamp: 'LEB 11/21/2019 19:34:00'!
alwaysOKMerchantProcessor
	
	^ MerchantProcessorMOCK with: [].! !

!TusLibrosServerController methodsFor: 'support' stamp: 'LEB 11/21/2019 19:35:03'!
defaultCatalog
	| aCatalog |
	aCatalog := Dictionary new.
	aCatalog add: 'validBook1' -> 5.
	aCatalog add: 'validBook2' -> 99099999999.
	^ aCatalog.! !

!TusLibrosServerController methodsFor: 'support' stamp: 'LEB 11/21/2019 19:33:23'!
defaultClock
^FixedClock with: DateAndTime now! !

!TusLibrosServerController methodsFor: 'support' stamp: 'LEB 11/21/2019 19:35:24'!
defaultCredentials
| credentials |

credentials := Dictionary new.
credentials add: 'user1'->'pass1'.
credentials add: 'user2'->'pass2'.
credentials add: 'user3'->'pass3'.
credentials add: 'user4'->'pass4'.
credentials add: 'user5'->'pass5'.
^credentials.! !

!TusLibrosServerController methodsFor: 'support' stamp: 'LEB 11/21/2019 19:33:49'!
defaultSalesBook
	
	^ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #TusLibros!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'LEB 11/21/2019 19:16:13'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
