!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:25:32'!
initialize

top := OOStackNodeWithoutValue new.
size := 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 19:50:04'!
isEmpty

^size=0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:20:05'!
pop

	[| value | 
	value := top value.
	size := size -1.
	top := top nextNode.
	^value.] on: Error do: [^self error: OOStack stackEmptyErrorDescription.]! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:05:22'!
push: aThing

| newNode |

size := size + 1.
newNode := OOStackNodeWithValue containing: aThing pointingTo: top.
top := newNode.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 19:48:59'!
size

^1! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:25:57'!
top

[^top value] on: Error do: [^self error: OOStack stackEmptyErrorDescription.]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:19:20'!
nextNode
^self subclassResponsibility ! !

!OOStackNode methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:02:47'!
value
^self subclassResponsibilty.! !


!classDefinition: #OOStackNodeWithValue category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackNodeWithValue
	instanceVariableNames: 'value node'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNodeWithValue methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:14:00'!
initializeWith: anObject pointingTo: anStackNode

value := anObject. 
node := anStackNode.! !

!OOStackNodeWithValue methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:15:09'!
nextNode
^node! !

!OOStackNodeWithValue methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:09:47'!
value
^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNodeWithValue class' category: #'Stack-Exercise'!
OOStackNodeWithValue class
	instanceVariableNames: ''!

!OOStackNodeWithValue class methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:13:31'!
containing: anObject pointingTo: anStackNode
^self new initializeWith: anObject pointingTo: anStackNode! !


!classDefinition: #OOStackNodeWithoutValue category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackNodeWithoutValue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNodeWithoutValue methodsFor: 'as yet unclassified' stamp: 'LEB 9/16/2019 20:25:44'!
value
^self error.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
