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
	instanceVariableNames: 'sentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 10:48:35'!
setUp

	sentenceFinderByPrefix _ SentenceFinderByPrefix new.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 10:59:16'!
test01FindShouldReturnNoMatchesWhenCreated
	|  prefix |
	
	prefix _ 'Hello'. 
	
	self assert: (sentenceFinderByPrefix find: prefix ) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:01:21'!
test02CanNotUseEmptyPrefix
	|  prefix |
	
	prefix _ ''. 
	
	self
		should: [ sentenceFinderByPrefix find: prefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:07:51'!
test03CanNotUsePrefixWithWhiteSpace
	|  prefix |
	
	prefix _ 'Hola mundo'. 
	
	self
		should: [ sentenceFinderByPrefix find: prefix ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithWhiteSpaceErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:30:29'!
test04OneSentenceOnStackThatMatch
	|  prefix sentence matches |
	
	prefix _ 'Hell'. 
	sentence _ 'Hello'.
	
	sentenceFinderByPrefix addSentence: sentence.
	matches _ sentenceFinderByPrefix find: prefix .
	
	self assert: matches size = 1.
	self assert: matches first = sentence .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:31:14'!
test05OneSentenceOnStackThatDoesNotMatch
	|  prefix sentence matches |
	
	prefix _ 'HELL'. 
	sentence _ 'Hello'.
	
	sentenceFinderByPrefix addSentence: sentence.
	matches _ sentenceFinderByPrefix find: prefix .
	
	self assert: matches isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:36:16'!
test06ManySentencesOnStackWithOneMatch
	|  prefix sentences matches |
	
	prefix _ 'Wint'. 
	sentences _ #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	
	sentenceFinderByPrefix addSentences: sentences.
	matches _ sentenceFinderByPrefix find: prefix .
	
	self assert: matches size = 1.
	self assert: matches first = (sentences at: 4) .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 11:37:24'!
test07ManySentencesOnStackWithNoMatches
	|  prefix sentences matches |
	
	prefix _ 'Hello'. 
	sentences _ #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	
	sentenceFinderByPrefix addSentences: sentences.
	matches _ sentenceFinderByPrefix find: prefix .
	
	self assert: matches isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 12:05:08'!
test08ManySentencesOnStackWithMatches
	|  prefix sentences matches |
	
	prefix _ 'win'. 
	sentences _ #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	
	sentenceFinderByPrefix addSentences: sentences.
	matches _ sentenceFinderByPrefix find: prefix .
	
	self assert: matches size = 2.
	self assert: matches first = (sentences at: 2) .
	self assert: (matches at: 2) = (sentences at: 1) .! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FL 9/17/2019 12:11:34'!
test09FindShouldReturnNoMatchesAfterFind
	|  prefix sentences |
	
	prefix _ 'win'. 
	sentences _ #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	
	sentenceFinderByPrefix addSentences: sentences.
	sentenceFinderByPrefix find: prefix .
	
	self assert: (sentenceFinderByPrefix find: prefix) isEmpty.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'FL 9/17/2019 09:40:25'!
initialize

	top _ OOStackBase new.
	size _ 0.! !


!OOStack methodsFor: 'evaluating' stamp: 'FL 9/17/2019 09:51:15'!
isEmpty

	^size = 0.! !

!OOStack methodsFor: 'evaluating' stamp: 'FL 9/17/2019 09:51:24'!
size
	^size! !


!OOStack methodsFor: 'accessing' stamp: 'FL 9/17/2019 10:05:03'!
top
	^top valueFromStack: self! !


!OOStack methodsFor: 'adding' stamp: 'FL 9/17/2019 09:55:31'!
push: something
	| newTop|
	newTop _ OOStackableElement value: something over: top.
	size _ size + 1.
	top _ newTop .! !


!OOStack methodsFor: 'removing' stamp: 'FL 9/17/2019 10:06:22'!
pop
	| topValue |
	topValue _ self top.
	size _ size - 1.
	top _ top belowElement .
	^topValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'accessing' stamp: 'FL 9/17/2019 10:00:22'!
valueFromStack: anOOStack
	^self subclassResponsibility ! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing' stamp: 'FL 9/17/2019 10:03:26'!
valueFromStack: anOOStack
	^anOOStack error: anOOStack class stackEmptyErrorDescription. ! !


!classDefinition: #OOStackableElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackableElement
	instanceVariableNames: 'value belowElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackableElement methodsFor: 'initialization' stamp: 'FL 9/17/2019 09:47:08'!
value: aValue over: anOOStackElement
	value _ aValue.
	belowElement _ anOOStackElement .! !


!OOStackableElement methodsFor: 'accessing' stamp: 'FL 9/17/2019 09:57:55'!
belowElement

	^belowElement ! !

!OOStackableElement methodsFor: 'accessing' stamp: 'FL 9/17/2019 10:01:32'!
valueFromStack: anOOStack

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackableElement class' category: #'Stack-Exercise'!
OOStackableElement class
	instanceVariableNames: ''!

!OOStackableElement class methodsFor: 'instance creation' stamp: 'FL 9/17/2019 09:48:55'!
value: aValue over: anOOStackElement
	^self new value: aValue over: anOOStackElement.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentencesStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'FL 9/17/2019 10:23:21'!
initialize
	sentencesStack _ OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'adding' stamp: 'FL 9/17/2019 10:26:53'!
addSentence: aSentence
	sentencesStack push:aSentence .! !

!SentenceFinderByPrefix methodsFor: 'adding' stamp: 'FL 9/17/2019 11:16:23'!
addSentences: sentencesCollection
	sentencesCollection do: [:sentence | self addSentence: sentence ]! !


!SentenceFinderByPrefix methodsFor: 'evaluating' stamp: 'FL 9/17/2019 12:08:33'!
checkPrefix: aPrefix
	aPrefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription ].
	(aPrefix allSatisfy: [:c | c ~= 32 asCharacter]) ifFalse: [self error: self class prefixWithWhiteSpaceErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'evaluating' stamp: 'FL 9/17/2019 11:46:02'!
find: aPrefix
	| sentences |
	self checkPrefix: aPrefix.
	sentences _ self obtainSentencesFromStack .
	^sentences select: [:sentence | self string:aPrefix  isPrefixOf:sentence ].! !

!SentenceFinderByPrefix methodsFor: 'evaluating' stamp: 'FL 9/17/2019 12:02:07'!
string: aString isPrefixOf: anotherString
	^aString = (anotherString copyFrom: 1 to: aString size).! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'FL 9/17/2019 11:24:30'!
obtainSentencesFromStack
	| sentences |
	sentences _ OrderedCollection new.
	[sentencesStack isEmpty ] whileFalse: [sentences addLast: sentencesStack pop ].
	^sentences ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'FL 9/17/2019 11:05:12'!
emptyPrefixErrorDescription
	^'Prefix is empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'FL 9/17/2019 11:05:34'!
prefixWithWhiteSpaceErrorDescription
	^'Prefix has white space'! !
