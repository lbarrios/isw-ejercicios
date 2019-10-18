!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 18:58:15'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 19:08:41'!
test02PortfolioWithOneAccountHasSameBalanceAsAccount 
	
	| portfolio account depositValue |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount  new.
	depositValue _ 100.
	Deposit register: depositValue on: account.
	portfolio add: account .

	self assert: depositValue equals: portfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 19:19:32'!
test03PortfolioWithAccountsHasTheSumOfBalancesAsBalance 
	
	| portfolio account  |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount  new.
	Deposit register: 50 on: account.
	portfolio add: account .
	account _ ReceptiveAccount  new.
	Deposit register: 100 on: account.
	portfolio add: account .

	self assert: 150 equals: portfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 20:16:36'!
test04PortfolioKnowsWhenItDoesNotHaveATransactionRegistered
	
	| portfolio deposit  |
	
	portfolio _ Portfolio new.
	deposit :=  Deposit for: 100.
	
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 20:19:00'!
test05PortfolioKnowsWhenItHasATransactionRegistered
	
	| portfolio deposit  account |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount  new.
	deposit :=  Deposit register: 100 on: account.
	portfolio add: account .
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 20:27:00'!
test06PortfolioReturnsEmptyTransactionsWhenEmpty

	| portfolio |
	
	portfolio _ Portfolio new.

	self assert: portfolio transactions isEmpty .! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 20:28:08'!
test07PortfolioKnowsItsTransactions 

	| portfolio deposit account |
	
	portfolio _ Portfolio new.
	account _ ReceptiveAccount  new.
	deposit :=  Deposit register: 100 on: account.
	portfolio add: account .

	self assert: 1 equals: portfolio transactions size .
	self assert: (portfolio transactions includes: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'FL 10/17/2019 20:15:26'!
test99PortfolioWithPortfolioCannotShareAccount 
	
	| portfolio internPortfolio account  |
	
	"TODO test muy a futuro"
	
	portfolio _ Portfolio new.
	internPortfolio _ Portfolio new.
	account _ ReceptiveAccount  new.
	Deposit register: 50 on: account.
	internPortfolio add: account .
	portfolio add: account .
	"self should: [portfolio add: internPortfolio .] raise:  Error - MessageNotUnderstood 
	withExceptionDo:  [:error | error description = Portfolio repeatFinancialEntityErrorMessage.
		self assert: 50 equals: portfolio balance .]."! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance value' stamp: 'FL 10/17/2019 18:55:02'!
balanceValueFor: aReceptiveAccount

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance value' stamp: 'FL 10/17/2019 18:55:35'!
balanceValueFor: aReceptiveAccount

	^aReceptiveAccount depositBalanceFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance value' stamp: 'FL 10/17/2019 18:54:19'!
balanceValueFor: aReceptiveAccount

	^aReceptiveAccount withdrawBalanceFor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialEntity category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialEntity methodsFor: 'balance' stamp: 'FL 10/17/2019 20:41:35'!
balance

	self subclassResponsibility ! !


!FinancialEntity methodsFor: 'testing' stamp: 'FL 10/17/2019 20:42:30'!
hasRegistered: aTransaction

	^ self subclassResponsibility ! !


!FinancialEntity methodsFor: 'transactions' stamp: 'FL 10/17/2019 20:43:28'!
transactions 

	^ self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #Portfolio
	instanceVariableNames: 'financialEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'FL 10/17/2019 19:24:14'!
balance

	^financialEntities sum: [ :aFinancialEntity | aFinancialEntity balance] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'add' stamp: 'FL 10/17/2019 20:08:15'!
add: aFinancialEntity

	financialEntities add: aFinancialEntity .
	! !


!Portfolio methodsFor: 'initialization' stamp: 'FL 10/17/2019 19:20:06'!
initialize

	financialEntities _ Set new.! !


!Portfolio methodsFor: 'transactions ' stamp: 'FL 10/17/2019 20:35:23'!
transactions 

	| transactions |
	transactions _ OrderedCollection new.
	financialEntities do: [:financialEntity | transactions addAll: financialEntity transactions ].

	^transactions! !


!Portfolio methodsFor: 'accounts' stamp: 'FL 10/17/2019 20:21:31'!
accounts

	| accounts |
	
	"METODO HORRIBLE!! Probablemente hay que sacarlo"
	
	accounts _ Set new.
	financialEntities do: [:financialEntity | (financialEntity isKindOf: Portfolio) ifTrue: [accounts addAll:  financialEntity accounts] 
		ifFalse: [accounts add: financialEntity ] ].
	
	^accounts! !


!Portfolio methodsFor: 'testing' stamp: 'FL 10/17/2019 20:20:35'!
hasRegistered: aTransaction

	^financialEntities anySatisfy: [:financialEntity | financialEntity hasRegistered: aTransaction ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'exceptions' stamp: 'FL 10/17/2019 19:42:43'!
repeatFinancialEntityErrorMessage

	^'Portfolio does not support information duplication.'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'FL 10/17/2019 18:53:53'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceValueFor: self] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'FL 10/17/2019 18:53:31'!
depositBalanceFor: aDepositTransaction

	^aDepositTransaction value! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'FL 10/17/2019 18:52:52'!
withdrawBalanceFor: aWithdrawTransaction

	^aWithdrawTransaction value * (-1)! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
