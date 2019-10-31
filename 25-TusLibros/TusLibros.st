!classDefinition: #ShoppingCartTest category: #TusLibros stamp: 'FL 10/30/2019 23:35:52'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'designPatternsBook operatingSystemConceptsBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 20:32:14'!
test01ShoppingCartIsEmptyWhenCreated

	| aShoppingCart |
	
	aShoppingCart _ ShoppingCart new.
	
	self assert: aShoppingCart isEmpty.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 20:44:40'!
test02ShoppingCartIsNotEmptyAfterAddingABook

	| aShoppingCart |
	
	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: designPatternsBook .
	
	self deny: aShoppingCart isEmpty.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 20:54:52'!
test03ShoppingCartListIsEmptyWhenCreated

	| aShoppingCart |
	
	aShoppingCart _ ShoppingCart new.
	
	self assert: aShoppingCart list isEmpty.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 20:57:54'!
test04ShoppingCartListIsNotEmptyAfterAddingABook

	| aShoppingCart |
	
	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: designPatternsBook .
	
	self deny: aShoppingCart list isEmpty.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 23:05:53'!
test05ShoppingCartWithDifferentBooksListHasOneOfEachBook

	| aShoppingCart expected |
	
	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: designPatternsBook .
	aShoppingCart add: operatingSystemConceptsBook .
	
	expected _ Dictionary new.
	expected add: designPatternsBook->1.
	expected add: operatingSystemConceptsBook->1.
	
	self assert: expected equals: aShoppingCart list.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 23:06:59'!
test06ShoppingCartWithRepeatedBookListHasCorrectAmount

	| aShoppingCart expected |
	
	aShoppingCart _ ShoppingCart new.
	aShoppingCart add: designPatternsBook .
	aShoppingCart add: designPatternsBook .
	
	expected _ Dictionary new.
	expected add: designPatternsBook->2.
	
	self assert: expected equals: aShoppingCart list.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 23:16:00'!
test07ShoppingCartCanBeAddedWithMoreThanOneBookAtOnce

	| aShoppingCart expected |
	
	aShoppingCart _ ShoppingCart new.
	aShoppingCart add:2 of: designPatternsBook .
	
	expected _ Dictionary new.
	expected add: designPatternsBook->2.
	
	self assert: expected equals: aShoppingCart list.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'FL 10/30/2019 23:30:01'!
test08AddingAnAmountLessThanOneBookToAShoppingCartIsNotPosible

	| aShoppingCart |
	
	aShoppingCart _ ShoppingCart new.
	
	self should: [aShoppingCart add:0 of: designPatternsBook .]  
	raise: Error - MessageNotUnderstood withExceptionDo: [ :anError |
		anError description = ShoppingCart AddLessThanOneBookErrorMessage.
		self assert: aShoppingCart isEmpty. ]! !


!ShoppingCartTest methodsFor: 'setUp/tearDown' stamp: 'FL 10/30/2019 20:41:21'!
setUp

	designPatternsBook _ 'Design Patterns'.
	operatingSystemConceptsBook _ 'Operating System Concepts'.! !


!classDefinition: #ShoppingCart category: #TusLibros stamp: 'FL 10/30/2019 23:35:52'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ShoppingCart methodsFor: 'testing' stamp: 'FL 10/30/2019 21:02:03'!
isEmpty
	^content isEmpty ! !


!ShoppingCart methodsFor: 'initialization' stamp: 'FL 10/30/2019 22:53:07'!
initialize

	content _ Dictionary new.! !


!ShoppingCart methodsFor: 'adding' stamp: 'FL 10/30/2019 23:35:20'!
add: aBook 
	self add: 1 of:aBook.! !

!ShoppingCart methodsFor: 'adding' stamp: 'FL 10/30/2019 23:34:57'!
add: anAmount of: aBook
	anAmount >= 1 ifFalse: [self error: self class AddLessThanOneBookErrorMessage ].
	content at: aBook put: anAmount + (content at: aBook ifAbsent: [0]).! !


!ShoppingCart methodsFor: 'accessing' stamp: 'FL 10/30/2019 23:09:13'!
list
	^content copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #TusLibros stamp: 'FL 10/30/2019 23:35:52'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error message' stamp: 'FL 10/30/2019 23:33:16'!
AddLessThanOneBookErrorMessage

	^'You must add 1 or more books.'! !
