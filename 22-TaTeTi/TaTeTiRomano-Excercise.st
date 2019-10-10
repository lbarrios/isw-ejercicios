!classDefinition: #TTTEsts category: #'TaTeTiRomano-Excercise'!
TestCase subclass: #TTTEsts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaTeTiRomano-Excercise'!

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 17:19:32'!
test01GameFirstTurnIsX

| ttt |

ttt := TTT new.

self assert: ttt isTurnOfX.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 17:19:57'!
test02GameFirstTurnIsNotY

| ttt |

ttt := TTT new.

self deny: ttt isTurnOfY.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 17:36:24'!
test03NextTurnOfXPlayingIsY

| ttt |

ttt := TTT new.
ttt putStoneAt: 0@0.

self assert: ttt isTurnOfY.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:12:56'!
test04NextTurnOfYPlayingIsX

| ttt |

ttt := TTT new.
ttt putStoneAt: 0@0.
ttt putStoneAt: 1@0.

self assert: ttt isTurnOfX.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:05:13'!
test05XPuttingAStoneAddsItToTheBoard

| ttt |

ttt := TTT new.
ttt putStoneAt: 0@0.

self assert: (ttt includesStoneFromXAt: 0@0).! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:05:02'!
test06YPuttingAStoneAddsItToTheBoard

| ttt |

ttt := TTT new.
ttt putStoneAt: 0@0.
ttt putStoneAt: 1@0.

self assert: (ttt includesStoneFromYAt: 1@0).! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:12:37'!
test07CannotPutStoneIfThereIsAlreadyAStoneOnTheSamePosition

| ttt |

ttt := TTT new.
ttt putStoneAt: 0@0.

self should: [ttt putStoneAt: 0@0.] raise: Error withMessageText: TTT cannotAddStoneOnAnOccupiedPositionDescription.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:22:40'!
test08CannotPutStoneOutsideOfTheLeftSideOfTheBoard

| ttt |

ttt := TTT new.

self should: [ttt putStoneAt: -1@0.] raise: Error withMessageText: TTT cannotAddStoneOutOfBoundsErrorDescription.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:23:08'!
test09CannotPutStoneOutsideOfTheLowerSideOfTheBoard

| ttt |

ttt := TTT new.

self should: [ttt putStoneAt: 0@-1.] raise: Error withMessageText: TTT cannotAddStoneOutOfBoundsErrorDescription.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:27:49'!
test10CannotPutStoneOutsideOfTheRightSideOfTheBoard

| ttt |

ttt := TTT new.

self should: [ttt putStoneAt: 3@0.] raise: Error withMessageText: TTT cannotAddStoneOutOfBoundsErrorDescription.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:27:53'!
test11CannotPutStoneOutsideOfTheUpperSideOfTheBoard

| ttt |

ttt := TTT new.

self should: [ttt putStoneAt: 0@3.] raise: Error withMessageText: TTT cannotAddStoneOutOfBoundsErrorDescription.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:51:13'!
test12XCannotPutMoreThanThreeStones

| ttt |

ttt := self filledTTT.

self should: [ttt putStoneAt: 0@2.] raise: Error withMessageText: TTT cannotAddStoneWhenPlayerHasMaximumStones.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 19:00:25'!
test13YCannotPutMoreThanThreeStones

| ttt |

ttt := self filledTTT.
ttt moveStoneUp: 1@1.

self should: [ttt putStoneAt: 0@2.] raise: Error withMessageText: TTT cannotAddStoneWhenPlayerHasMaximumStones.! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 20:29:05'!
test20XMovingDownAStoneMovesItDown

| ttt |

ttt := self filledTTT.
ttt moveStoneUp: 1@1.
ttt moveStoneUp: 2@1.
ttt moveStoneDown: 1@2.

self assert: (ttt includesStoneFromXAt: 1@1).! !

!TTTEsts methodsFor: 'testing' stamp: 'LEB 10/10/2019 20:31:10'!
test21XMovingUpAStoneMovesItUp

| ttt |

ttt := self filledTTT.
ttt moveStoneUp: 1@1.

self assert: (ttt includesStoneFromXAt: 1@2).! !


!TTTEsts methodsFor: 'setUp/tearDown' stamp: 'LEB 10/10/2019 18:53:34'!
filledTTT

| ttt |
ttt _ TTT new.

"
-  -  -
Y X Y
X Y X
"

ttt putStoneAt: 0@0. "<- X"
ttt putStoneAt: 1@0.
ttt putStoneAt: 2@0. "<- X"
ttt putStoneAt: 0@1.
ttt putStoneAt: 1@1. "<- X"
ttt putStoneAt: 2@1.

^ ttt.! !


!classDefinition: #TTT category: #'TaTeTiRomano-Excercise'!
Object subclass: #TTT
	instanceVariableNames: 'turnX xStones yStones'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TaTeTiRomano-Excercise'!

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:54:32'!
includesStoneFromXAt: aStonePosition
	^ xStones includes: aStonePosition.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:54:39'!
includesStoneFromYAt: aStonePosition
	^ yStones includes: aStonePosition.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:44:22'!
initialize
	
	turnX _ true.
	xStones _ Set new.
	yStones _ Set new.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 17:26:30'!
isTurnOfX
	
	^turnX.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:43:54'!
isTurnOfY
	
	^self isTurnOfX not.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:45:33'!
putStoneAt: stonePosition

(self positionIsInsideBoard: stonePosition) ifFalse: [self error: self class cannotAddStoneOutOfBoundsErrorDescription ].
(self positionIsEmpty: stonePosition) ifFalse: [self error: self class cannotAddStoneOnAnOccupiedPositionDescription ].
(turnX ifTrue: [xStones] ifFalse: [yStones]) size = 3 ifTrue: [self error: self class cannotAddStoneWhenPlayerHasMaximumStones ].

(turnX ifTrue: [xStones] ifFalse: [yStones]) add: stonePosition.

turnX _ turnX not.! !

!TTT methodsFor: 'AAA' stamp: 'LEB 10/10/2019 18:32:21'!
stones
	
	^xStones! !


!TTT methodsFor: 'as yet unclassified' stamp: 'LEB 10/10/2019 18:42:16'!
positionIsEmpty: stonePosition
	^ ((xStones includes: stonePosition) or: [yStones includes: stonePosition]) not.! !

!TTT methodsFor: 'as yet unclassified' stamp: 'LEB 10/10/2019 18:26:32'!
positionIsInsideBoard: stonePosition
	^ (stonePosition x between: 0 and: 2) and: [stonePosition y between: 0 and: 2].! !


!TTT methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:30:51'!
moveStoneDown: aStonePosition

(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
self putStoneAt: aStonePosition + (0@-1).
! !

!TTT methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:29:58'!
moveStoneUp: aStonePosition

(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
self putStoneAt: aStonePosition + (0@1).
! !


!TTT methodsFor: 'error handling' stamp: 'LEB 10/10/2019 20:29:14'!
error: aString 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TTT class' category: #'TaTeTiRomano-Excercise'!
TTT class
	instanceVariableNames: ''!

!TTT class methodsFor: 'as yet unclassified' stamp: 'LEB 10/10/2019 18:09:08'!
cannotAddStoneOnAnOccupiedPositionDescription

	^'Dale gil no podes hacr eso'! !

!TTT class methodsFor: 'as yet unclassified' stamp: 'LEB 10/10/2019 18:15:47'!
cannotAddStoneOutOfBoundsErrorDescription
	^ 'dale gato'! !

!TTT class methodsFor: 'as yet unclassified' stamp: 'LEB 10/10/2019 18:30:46'!
cannotAddStoneWhenPlayerHasMaximumStones
	^'No podes hacer eso'.! !
