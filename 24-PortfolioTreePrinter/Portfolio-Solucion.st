!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/21/2019 19:46:01'!
test08TransferingIncreasesBalanceOnTheReceiver

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.
		
	self assert: 100 equals: receiverAccount balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/21/2019 19:46:37'!
test09TransferingDecreasesBalanceOnTheReceiver

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.
		
	self assert: 0 equals: transferorAccount balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/21/2019 20:42:43'!
test10ReceptiveAccountKnowsRegisteredTransferDeposit

	| receiverAccount transferorAccount transfer |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer register: 100 from: transferorAccount to: receiverAccount.
		
	self assert: (receiverAccount hasRegistered: (transfer deposit)).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/21/2019 20:44:45'!
test11TransferorAccountKnowsRegisteredTransferWithdraw

	| receiverAccount transferorAccount transfer |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	transfer := Transfer register: 100 from: transferorAccount to: receiverAccount.
		
	self assert: (transferorAccount hasRegistered: (transfer withdraw)).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:34:35'!
test12AccountSummaryOfAnAccountWithoutOperationsReturnsAnEmptyString

	| account |
	
	account := ReceptiveAccount  new.	
	self assert: 'Balance = 0.' equals: (AccountSummary for: account).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:34:58'!
test13AccountSummaryOfAnAccountWithADepositReturnsAStringWithThatDeposit

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	self assert: 'Dep�sito por 100. Balance = 100.' equals: (AccountSummary for: account).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:35:09'!
test13AccountSummaryOfAnAccountWithAWithdrawReturnsAStringWithThatWithdraw

	| account |
	
	account := ReceptiveAccount  new.
	Withdraw register: 100 on: account.
	self assert: 'Extracci�n por 100. Balance = -100.' equals: (AccountSummary for: account).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:35:27'!
test14AccountSummaryOfAnAccountWithADepositAndAWithdrawReturnsAStringWithTheConcatenationOfTheOperations

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	self assert: 'Dep�sito por 100. Extracci�n por 50. Balance = 50.' equals: (AccountSummary for: account).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:35:50'!
test15AccountSummaryOfAnAccountWithATransferDepositReturnsAStringWithADepositFromThatTransfer

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.
	self assert: 'Entrada por transferencia de 100. Balance = 100.' equals: (AccountSummary for: receiverAccount).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:36:13'!
test16AccountSummaryOfAnAccountWithATransferWithdrawReturnsAStringWithAWithdrawFromThatTransfer

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.
	self assert: 'Dep�sito por 100. Salida por transferencia de 100. Balance = 0.' equals: (AccountSummary for: transferorAccount).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 17:59:33'!
test17TransferNetOfAnAccountWithNoTransfersIsZero

	| acccount |
	
	acccount := ReceptiveAccount  new.
	Deposit register: 100 on: acccount.
	
	self assert: 0 equals: (TransferNet for: acccount).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:01:07'!
test18TransferNetOfAnAccountWithADepositTransferIsTheAmountOfTheDeposit

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.

	self assert: 100 equals: (TransferNet for: receiverAccount).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FL 10/27/2019 18:01:31'!
test19TransferNetOfAnAccountWithATransferWithdrawIsTheAmountOfTheWithdraw

	| receiverAccount transferorAccount |
	
	transferorAccount := ReceptiveAccount  new.
	Deposit register: 100 on: transferorAccount.
	receiverAccount := ReceptiveAccount  new.
	
	Transfer register: 100 from: transferorAccount to: receiverAccount.

	self assert: -100 equals: (TransferNet for: transferorAccount).! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'FL 10/27/2019 17:33:31'!
process: anAccountReport
	
	^transactions
		inject: anAccountReport startingValue
		into: [ :currentValue :transaction | anAccountReport affect: currentValue with: transaction].! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountReport category: #'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'startingValue currentValue account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'process' stamp: 'FL 10/27/2019 17:54:05'!
affect: aValue with: aTransaction

	currentValue _ aValue.
	
	aTransaction processFor: self.
	
	^currentValue ! !

!AccountReport methodsFor: 'process' stamp: 'FL 10/27/2019 17:53:07'!
processDeposit: aDeposit

	^self subclassResponsibility! !

!AccountReport methodsFor: 'process' stamp: 'FL 10/27/2019 17:31:49'!
processTransferDeposit: aTransferDeposit

	^self subclassResponsibility! !

!AccountReport methodsFor: 'process' stamp: 'FL 10/27/2019 17:31:35'!
processTransferWithdraw: aTransferWithdraw

	^self subclassResponsibility! !

!AccountReport methodsFor: 'process' stamp: 'FL 10/27/2019 17:31:23'!
processWithdraw: aWithdraw

	^self subclassResponsibility! !


!AccountReport methodsFor: 'value' stamp: 'FL 10/27/2019 17:30:49'!
startingValue

	^startingValue ! !

!AccountReport methodsFor: 'value' stamp: 'FL 10/27/2019 18:30:12'!
value

	^self subclassResponsibility ! !


!AccountReport methodsFor: 'initialization' stamp: 'FL 10/27/2019 17:46:33'!
initializeFor: anAccount

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: #'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'instance creation' stamp: 'FL 10/27/2019 18:00:07'!
for: anAccount

	^(self new initializeFor: anAccount) value.! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'FL 10/27/2019 17:49:08'!
initializeFor: anAccount

	startingValue _ ''.
	currentValue _ ''.
	account _ anAccount .! !


!AccountSummary methodsFor: 'process' stamp: 'FL 10/27/2019 18:27:45'!
processDeposit: aDeposit

	currentValue _ currentValue ,'Dep�sito por ', aDeposit value asString, '. '! !

!AccountSummary methodsFor: 'process' stamp: 'FL 10/27/2019 18:27:50'!
processTransferDeposit: aTransferDeposit

	currentValue _ currentValue,'Entrada por transferencia de ', aTransferDeposit value asString, '. '.! !

!AccountSummary methodsFor: 'process' stamp: 'FL 10/27/2019 18:27:57'!
processTransferWithdraw: aTransferWithdraw

	currentValue _ currentValue,'Salida por transferencia de ', aTransferWithdraw value asString, '. '.! !

!AccountSummary methodsFor: 'process' stamp: 'FL 10/27/2019 18:28:01'!
processWithdraw: aWithdraw

	currentValue _ currentValue ,'Extracci�n por ', aWithdraw value asString, '. '! !


!AccountSummary methodsFor: 'value' stamp: 'FL 10/27/2019 18:32:34'!
value

	currentValue _ account process: self.
	
	^currentValue ,'Balance = ', account balance asString, '.'.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'FL 10/27/2019 17:49:56'!
initializeFor: anAccount

	startingValue _ 0.
	currentValue _ 0.
	account _ anAccount .! !


!TransferNet methodsFor: 'process' stamp: 'FL 10/27/2019 17:53:50'!
processDeposit: aDeposit! !

!TransferNet methodsFor: 'process' stamp: 'FL 10/27/2019 17:56:23'!
processTransferDeposit: aTransferDeposit

	currentValue _ aTransferDeposit affectBalance: currentValue ! !

!TransferNet methodsFor: 'process' stamp: 'FL 10/27/2019 17:56:42'!
processTransferWithdraw: aTransferWithdraw

	currentValue _ aTransferWithdraw affectBalance: currentValue ! !

!TransferNet methodsFor: 'process' stamp: 'FL 10/27/2019 17:53:45'!
processWithdraw: aWithdraw! !


!TransferNet methodsFor: 'value' stamp: 'FL 10/27/2019 18:30:36'!
value

	^account process: self! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'process' stamp: 'FL 10/27/2019 17:36:17'!
processFor: anAccountReport

	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'FL 10/21/2019 20:38:36'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'FL 10/21/2019 20:34:00'!
affectBalance: aBalance

	^aBalance + self value ! !


!Deposit methodsFor: 'process' stamp: 'FL 10/27/2019 17:37:09'!
processFor: anAccountReport

	^anAccountReport processDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'FL 10/21/2019 20:38:41'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'FL 10/21/2019 20:34:07'!
affectBalance: aBalance

	^aBalance - self value! !


!Withdraw methodsFor: 'process' stamp: 'FL 10/27/2019 17:37:48'!
processFor: anAccountReport

	^anAccountReport processWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'part' stamp: 'FL 10/21/2019 20:24:13'!
deposit

	^deposit! !

!Transfer methodsFor: 'part' stamp: 'FL 10/21/2019 20:24:21'!
withdraw

	^withdraw! !


!Transfer methodsFor: 'value' stamp: 'FL 10/21/2019 20:24:26'!
value

	^value! !


!Transfer methodsFor: 'initialization' stamp: 'FL 10/21/2019 20:37:36'!
initializeFor: aValue from: transferorAccount to: receiverAccount

	value := aValue.
	withdraw := TransferWithdraw of: self.
	deposit := TransferDeposit of: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: 'withdraw deposit'!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FL 10/21/2019 20:23:06'!
for: aValue from: transferorAccount to: receiverAccount.

	^ self new initializeFor: aValue from: transferorAccount to: receiverAccount.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FL 10/21/2019 20:43:07'!
register: aValue from: transferorAccount to: receiverAccount 

	| transaction |

	transaction := self for: aValue from: transferorAccount to: receiverAccount.
	transferorAccount register: transaction withdraw.
	receiverAccount register: transaction deposit.
	
	^ transaction ! !


!classDefinition: #TransferTransaction category: #'Portfolio-Solucion'!
Object subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'value' stamp: 'FL 10/27/2019 18:21:24'!
value

	^transfer value! !


!TransferTransaction methodsFor: 'initialization' stamp: 'FL 10/27/2019 17:38:53'!
initializeOf: aTransfer

	transfer := aTransfer! !


!TransferTransaction methodsFor: 'process' stamp: 'FL 10/27/2019 17:38:27'!
processFor: anAccountReport

	^self subclassResponsibility! !


!TransferTransaction methodsFor: 'balance' stamp: 'FL 10/21/2019 20:36:34'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: #'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'FL 10/27/2019 17:39:17'!
of: aTransfer

	^ self new initializeOf: aTransfer! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'process' stamp: 'FL 10/27/2019 17:40:47'!
processFor: anAccountReport

	^anAccountReport processTransferDeposit: self.! !


!TransferDeposit methodsFor: 'balance' stamp: 'FL 10/21/2019 20:37:09'!
affectBalance: aBalance

	^aBalance + transfer value ! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'process' stamp: 'FL 10/27/2019 17:41:12'!
processFor: anAccountReport

	^anAccountReport processTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'balance' stamp: 'FL 10/21/2019 20:37:17'!
affectBalance: aBalance

	^aBalance - transfer value ! !
