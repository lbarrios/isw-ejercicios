!classDefinition: #TerniLapilliTestCase category: #'TerniLapilli-Excercise'!
TestCase subclass: #TerniLapilliTestCase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:54:53'!
test01GameFirstTurnIsX

| game |

game := TerniLapilli new.

self assert: game isTurnOfX.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:53:52'!
test02GameFirstTurnIsNotY

| game |

game := TerniLapilli new.

self deny: game isTurnOfY.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:54:18'!
test03NextTurnOfXPlayingIsY

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.

self assert: game isTurnOfY.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:55:00'!
test04NextTurnOfYPlayingIsX

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.

self assert: game isTurnOfX.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:54:37'!
test05XPuttingAStoneAddsItToTheBoard

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.

self assert: (game includesStoneFromXAt: 0@0).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 15:54:10'!
test06YPuttingAStoneAddsItToTheBoard

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.

self assert: (game includesStoneFromYAt: 1@0).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:10:43'!
test07CannotPutStoneIfThereIsAlreadyAStoneOnTheSamePosition

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.

self should: [game putStoneAt: 0@0.] raise: Error withMessageText: TerniLapilli cannotAddStoneOnAnOccupiedPositionErrorMessage.

self assert: game isTurnOfY.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:11:33'!
test08CannotPutStoneOutsideOfTheLeftSideOfTheBoard

| game |

game := TerniLapilli new.

self should: [game putStoneAt: -1@0.] raise: Error withMessageText: TerniLapilli cannotAddStoneOutOfBoundsErrorMessage.

self assert: game isTurnOfX.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:29:12'!
test09CannotPutStoneOutsideOfTheLowerSideOfTheBoard

| game |

game := TerniLapilli new.

self should: [game putStoneAt: 0@-1.] raise: Error withMessageText: TerniLapilli cannotAddStoneOutOfBoundsErrorMessage.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:29:26'!
test10CannotPutStoneOutsideOfTheRightSideOfTheBoard

| game |

game := TerniLapilli new.

self should: [game putStoneAt: 3@0.] raise: Error withMessageText: TerniLapilli cannotAddStoneOutOfBoundsErrorMessage.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:29:44'!
test11CannotPutStoneOutsideOfTheUpperSideOfTheBoard

| game |

game := TerniLapilli new.

self should: [game putStoneAt: 0@3.] raise: Error withMessageText: TerniLapilli cannotAddStoneOutOfBoundsErrorMessage.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:12:24'!
test12XCannotPutMoreThanThreeStones

| game |

game := self filledTerniLapilli.

self 
		should: [ game putStoneAt: 0@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromXAt: 0@2).
			self assert: game isTurnOfX.].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:12:40'!
test13YCannotPutMoreThanThreeStones

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.

self 
		should: [ game putStoneAt: 0@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromYAt: 0@2).
			self assert: game isTurnOfY.].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:12:56'!
test14CannotMoveStoneBeforeHavingThree

| game |

game _ TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.

self 
		should: [ game moveStoneUp: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotMoveStoneBeforePlacingAllStonesErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromXAt: 0@1).
			self assert: (game includesStoneFromXAt: 0@0).
			self assert: game isTurnOfX.].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:14:38'!
test15CannotMoveStoneWhereThereIsNoStone

| game |

game _ self filledTerniLapilli.

self 
		should: [ game moveStoneRight: 0@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotMoveStoneIfThereIsNoStoneErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromXAt: 0@2).
			self deny: (game includesStoneFromXAt: 1@2).
			self assert: game isTurnOfX.].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:34:57'!
test16CannotMoveStoneOutOfBound

| game |

game _ self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 0@1.

self 
		should: [ game moveStoneUp: 1@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotMoveStoneOutOfBoundErrorMessage equals: anError messageText.
			self assert: (game includesStoneFromXAt: 1@2).
			self assert: game isTurnOfX.].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:34:10'!
test17XWinsWhenHasThreeStonesAligned

| game |

game _ TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.
game putStoneAt: 1@1.
game putStoneAt: 2@0.
game putStoneAt: 2@2.

self assert: game hasPlayerXWon.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:36:20'!
test18YWinsWhenHasThreeStonesAligned

| game |

game _ TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.
game putStoneAt: 0@1.
game putStoneAt: 1@1.
game putStoneAt: 2@2.
game putStoneAt: 1@2.

self assert: game hasPlayerYWon.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 18:34:29'!
test19CannotAddStoneWhenGameIsOver

| game |

game _ TerniLapilli new.
game putStoneAt: 0@0.
game putStoneAt: 1@0.
game putStoneAt: 1@1.
game putStoneAt: 2@0.
game putStoneAt: 2@2.

self 
		should: [ game putStoneAt: 2@1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotDoActionWhenGameIsOverErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromYAt: 2@1).].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:12:17'!
test20MovingUpAStoneMovesItUp

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.

self assert: (game includesStoneFromXAt: 1@2).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:12:24'!
test21MovingDownAStoneMovesItDown

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 2@1.
game moveStoneDown: 1@2.

self assert: (game includesStoneFromXAt: 1@1).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:12:29'!
test22MovingLeftAStoneMovesItLeft

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 2@1.
game moveStoneLeft: 1@2.

self assert: (game includesStoneFromXAt: 0@2).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:12:34'!
test23MovingRightAStoneMovesItRight

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 0@1.
game moveStoneRight: 1@2.

self assert: (game includesStoneFromXAt: 2@2).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:12:38'!
test24MovingUprightAStoneMovesItUpright

| game |

game := self filledTerniLapilli.
game moveStoneUpright: 1@1.

self assert: (game includesStoneFromXAt: 2@2).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:13:53'!
test25MovingUpleftAStoneMovesItUpleft

| game |

game := self filledTerniLapilli.
game moveStoneUpleft: 1@1.

self assert: (game includesStoneFromXAt: 0@2).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:18:25'!
test26MovingDownrightAStoneMovesItDownright

| game |

game := self filledTerniLapilli.
game moveStoneUpleft: 1@1.
game moveStoneUp: 2@1.
game moveStoneDownright: 0@2.

self assert: (game includesStoneFromXAt: 1@1).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:20:51'!
test27MovingDownleftAStoneMovesItDownleft

| game |

game := self filledTerniLapilli.
game moveStoneUpright: 1@1.
game moveStoneUp: 0@1.
game moveStoneDownleft: 2@2.

self assert: (game includesStoneFromXAt: 1@1).! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 19:11:05'!
test28CannotMoveStoneWhenGameIsOver

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 1@0.

self 
		should: [ game moveStoneRight: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotDoActionWhenGameIsOverErrorMessage equals: anError messageText.
			self deny: (game includesStoneFromXAt: 1@0).
			self assert: (game includesStoneFromXAt: 0@0).].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 19:15:06'!
test29CannotMoveStoneOverAnotherStone

| game |

game := self filledTerniLapilli.

self 
		should: [ game moveStoneRight: 0@0. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotMoveStoneOverAnotherStoneErrorMessage equals: anError messageText.
			self assert: (game includesStoneFromXAt: 0@0).
			self assert: (game includesStoneFromYAt: 1@0).].! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 19:25:42'!
test30CannotMoveDiagonallyIfCenterIsNotInvolved

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.
game moveStoneUp: 0@1.

self 
		should: [ game moveStoneDownleft: 1@2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: TerniLapilli cannotMoveWhereThereIsNoLineErrorMessage equals: anError messageText.
			self assert: (game includesStoneFromXAt: 1@2).
			self deny: (game includesStoneFromXAt: 0@1).
			self assert: game isTurnOfX ].! !


!TerniLapilliTestCase methodsFor: 'setUp/tearDown' stamp: 'FL 10/16/2019 15:56:23'!
filledTerniLapilli

| game |
game _ TerniLapilli new.

"
-  -  -
Y X Y
X Y X
"

game putStoneAt: 0@0. "<- X"
game putStoneAt: 1@0.
game putStoneAt: 2@0. "<- X"
game putStoneAt: 0@1.
game putStoneAt: 1@1. "<- X"
game putStoneAt: 2@1.

^ game.! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Excercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turnX xStones yStones'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!TerniLapilli methodsFor: 'adding' stamp: 'FL 10/16/2019 20:55:24'!
putStoneAt: stonePosition

(self positionIsInsideBoard: stonePosition) ifFalse: [self error: self class cannotAddStoneOutOfBoundsErrorMessage ].
(self positionIsEmpty: stonePosition) ifFalse: [self error: self class cannotAddStoneOnAnOccupiedPositionErrorMessage ].
^self state putStoneAt: stonePosition! !


!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 18:57:09'!
hasAWinningColumn: aStoneSet
	| x |
	x _ aStoneSet atRandom x.
	^aStoneSet allSatisfy: [:e | e x = x]! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 19:00:04'!
hasAWinningDiagonal: aStoneSet

	| downDiagonal upDiagonal |
	downDiagonal _ Set with: 0@2 with: 1@1 with: 2@0.
	upDiagonal _ Set with: 0@0 with: 1@1 with: 2@2.
	^aStoneSet = downDiagonal or: [aStoneSet = upDiagonal].! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 18:57:13'!
hasAWinningRow: aStoneSet
	| y |
	y _ aStoneSet atRandom y.
	^aStoneSet allSatisfy: [:e | e y = y]! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 19:04:45'!
hasThreeStonesAligned: aStoneSet

	^(self hasAWinningRow: aStoneSet) or: [self hasAWinningColumn: aStoneSet] or: [self hasAWinningDiagonal: aStoneSet].! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 21:08:53'!
moveStoneAt: aStonePosition distance: aDistance

| destinationPosition |
destinationPosition _ aStonePosition + aDistance.

(self positionIsInsideBoard: destinationPosition) ifFalse: [self error: self class cannotMoveStoneOutOfBoundErrorMessage ].
(self positionIsEmpty: destinationPosition ) ifFalse: [self error: self class cannotMoveStoneOverAnotherStoneErrorMessage ].

self state moveStoneAt: aStonePosition to: destinationPosition 
! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 21:03:38'!
moveStoneWhenFilledAt: aStonePosition to: aDestination


(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition ifAbsent: [self error: self class cannotMoveStoneIfThereIsNoStoneErrorMessage ].
self putStoneAt: aDestination .
! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 21:07:16'!
moveStoneWhenFinished


self error: self class cannotDoActionWhenGameIsOverErrorMessage
! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 21:06:26'!
moveStoneWhenNotFilled

self error: self class cannotMoveStoneBeforePlacingAllStonesErrorMessage 
! !

!TerniLapilli methodsFor: 'private' stamp: 'LEB 10/10/2019 18:26:32'!
positionIsInsideBoard: stonePosition
	^ (stonePosition x between: 0 and: 2) and: [stonePosition y between: 0 and: 2].! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 20:56:02'!
putStoneWhenFilled

	self error: self class cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage.! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 20:55:53'!
putStoneWhenFinished

	self error: self class cannotDoActionWhenGameIsOverErrorMessage! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 20:52:28'!
putStoneWhenNotFilledAt: stonePosition

	(turnX ifTrue: [xStones] ifFalse: [yStones]) add: stonePosition.

	turnX _ turnX not.! !

!TerniLapilli methodsFor: 'private' stamp: 'FL 10/16/2019 20:58:19'!
state 

	^TerniLapilliState stateFor: self! !


!TerniLapilli methodsFor: 'initialization' stamp: 'LEB 10/10/2019 18:44:22'!
initialize
	
	turnX _ true.
	xStones _ Set new.
	yStones _ Set new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'FL 10/16/2019 17:42:43'!
allStonesAreNotPlaced

	^xStones size + yStones size < 6! !

!TerniLapilli methodsFor: 'testing' stamp: 'FL 10/16/2019 17:43:03'!
allStonesArePlaced

	^self allStonesAreNotPlaced not! !

!TerniLapilli methodsFor: 'testing' stamp: 'FL 10/16/2019 19:06:23'!
hasPlayerXWon
	^xStones size = 3 and: [self hasThreeStonesAligned: xStones ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'FL 10/16/2019 19:06:44'!
hasPlayerYWon
	^yStones size = 3 and: [self hasThreeStonesAligned: yStones ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:54:32'!
includesStoneFromXAt: aStonePosition
	^ xStones includes: aStonePosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:54:39'!
includesStoneFromYAt: aStonePosition
	^ yStones includes: aStonePosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'FL 10/16/2019 18:44:25'!
isOver
	^self hasPlayerXWon or: [self hasPlayerYWon ].! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 17:26:30'!
isTurnOfX
	
	^turnX.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:43:54'!
isTurnOfY
	
	^self isTurnOfX not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:42:16'!
positionIsEmpty: stonePosition
	^ ((xStones includes: stonePosition) or: [yStones includes: stonePosition]) not.! !


!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:41'!
moveStoneDown: aStonePosition

self moveStoneAt: aStonePosition distance:  (0@-1).
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:41'!
moveStoneDownleft: aStonePosition 
	aStonePosition  = (2@2) | (aStonePosition = (1@1)) ifFalse: [self error: self class cannotMoveWhereThereIsNoLineErrorMessage ].
	self moveStoneAt: aStonePosition distance:  -1@-1.! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:41'!
moveStoneDownright: aStonePosition 
	aStonePosition  = (0@2) | (aStonePosition = (1@1)) ifFalse: [self error: self class cannotMoveWhereThereIsNoLineErrorMessage ].
	self moveStoneAt: aStonePosition distance: 1@-1.! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:42'!
moveStoneLeft: aStonePosition

	self moveStoneAt: aStonePosition distance: -1@0.
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:42'!
moveStoneRight: aStonePosition

	self moveStoneAt: aStonePosition distance: 1@0.
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:42'!
moveStoneUp: aStonePosition

self moveStoneAt: aStonePosition distance: 0@1.
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:42'!
moveStoneUpleft: aStonePosition 
	aStonePosition  = (2@0) | (aStonePosition = (1@1)) ifFalse: [self error: self class cannotMoveWhereThereIsNoLineErrorMessage ].
	self moveStoneAt: aStonePosition distance: -1@1.! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 21:04:42'!
moveStoneUpright: aStonePosition 
	aStonePosition  = (0@0) | (aStonePosition = (1@1)) ifFalse: [self error: self class cannotMoveWhereThereIsNoLineErrorMessage ].
	self moveStoneAt: aStonePosition distance: 1@1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Excercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 17:29:03'!
cannotAddStoneOnAnOccupiedPositionErrorMessage

	^'There is already a stone on that position'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 17:28:41'!
cannotAddStoneOutOfBoundsErrorMessage
	^ 'Position out of bound'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 17:28:20'!
cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage
	^'All stones have been placed'.! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 18:43:12'!
cannotDoActionWhenGameIsOverErrorMessage
	^'Game is over'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 17:27:41'!
cannotMoveStoneBeforePlacingAllStonesErrorMessage
	^'There are less than 6 stones'.! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 18:14:38'!
cannotMoveStoneIfThereIsNoStoneErrorMessage
	^'There is no stone to move'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 18:14:54'!
cannotMoveStoneOutOfBoundErrorMessage
	^'Moving out of bound'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 19:16:43'!
cannotMoveStoneOverAnotherStoneErrorMessage
	^'There is already a stone where you want to move'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 19:26:31'!
cannotMoveWhereThereIsNoLineErrorMessage
	^'There is no line on the board that allows that move'! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Excercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'FL 10/16/2019 20:34:43'!
initializeFor: aTerniLapilli

	terniLapilli _ aTerniLapilli ! !


!TerniLapilliState methodsFor: 'adding' stamp: 'FL 10/16/2019 20:37:02'!
putStoneAt: stonePosition
	
	self subclassResponsibility ! !


!TerniLapilliState methodsFor: 'moving' stamp: 'FL 10/16/2019 21:09:52'!
moveStoneAt: aStonePosition to: aDestination

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Excercise'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'state selection' stamp: 'FL 10/16/2019 20:40:12'!
canHandle: aTerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState class methodsFor: 'state selection' stamp: 'FL 10/16/2019 20:41:36'!
stateFor: aTerniLapilli

	^(self subclasses detect: [:aTerniLapilliStateClass | aTerniLapilliStateClass canHandle: aTerniLapilli ]) for: aTerniLapilli ! !


!TerniLapilliState class methodsFor: 'instance creation' stamp: 'FL 10/16/2019 20:41:55'!
for: aStack

	^self new initializeFor: aStack! !


!classDefinition: #FilledTerniLapilliState category: #'TerniLapilli-Excercise'!
TerniLapilliState subclass: #FilledTerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!FilledTerniLapilliState methodsFor: 'adding' stamp: 'FL 10/16/2019 20:56:38'!
putStoneAt: stonePosition
	
	terniLapilli putStoneWhenFilled ! !


!FilledTerniLapilliState methodsFor: 'moving' stamp: 'FL 10/16/2019 21:10:31'!
moveStoneAt: aStonePosition to: aDestination

	terniLapilli moveStoneWhenFilledAt: aStonePosition to: aDestination ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FilledTerniLapilliState class' category: #'TerniLapilli-Excercise'!
FilledTerniLapilliState class
	instanceVariableNames: ''!

!FilledTerniLapilliState class methodsFor: 'state selection' stamp: 'FL 10/16/2019 20:45:38'!
canHandle: aTerniLapilli

	^aTerniLapilli allStonesArePlaced  & (aTerniLapilli isOver not).! !


!classDefinition: #FinishedTerniLapilliState category: #'TerniLapilli-Excercise'!
TerniLapilliState subclass: #FinishedTerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!FinishedTerniLapilliState methodsFor: 'adding' stamp: 'FL 10/16/2019 20:57:19'!
putStoneAt: stonePosition
	
	terniLapilli putStoneWhenFinished ! !


!FinishedTerniLapilliState methodsFor: 'moving' stamp: 'FL 10/16/2019 21:10:56'!
moveStoneAt: aStonePosition to: aDestination

	terniLapilli moveStoneWhenFinished ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinishedTerniLapilliState class' category: #'TerniLapilli-Excercise'!
FinishedTerniLapilliState class
	instanceVariableNames: ''!

!FinishedTerniLapilliState class methodsFor: 'state selection' stamp: 'FL 10/16/2019 20:46:25'!
canHandle: aTerniLapilli

	^aTerniLapilli isOver.! !


!classDefinition: #NotFilledTerniLapilliState category: #'TerniLapilli-Excercise'!
TerniLapilliState subclass: #NotFilledTerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Excercise'!

!NotFilledTerniLapilliState methodsFor: 'adding' stamp: 'FL 10/16/2019 20:57:41'!
putStoneAt: stonePosition
	
	terniLapilli putStoneWhenNotFilledAt: stonePosition ! !


!NotFilledTerniLapilliState methodsFor: 'moving' stamp: 'FL 10/16/2019 21:11:15'!
moveStoneAt: aStonePosition to: aDestination

	terniLapilli moveStoneWhenNotFilled ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotFilledTerniLapilliState class' category: #'TerniLapilli-Excercise'!
NotFilledTerniLapilliState class
	instanceVariableNames: ''!

!NotFilledTerniLapilliState class methodsFor: 'state selection' stamp: 'FL 10/16/2019 20:46:08'!
canHandle: aTerniLapilli

	^aTerniLapilli allStonesAreNotPlaced  & (aTerniLapilli isOver not).! !
