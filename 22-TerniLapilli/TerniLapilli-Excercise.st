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

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:25:53'!
test07CannotPutStoneIfThereIsAlreadyAStoneOnTheSamePosition

| game |

game := TerniLapilli new.
game putStoneAt: 0@0.

self should: [game putStoneAt: 0@0.] raise: Error withMessageText: TerniLapilli cannotAddStoneOnAnOccupiedPositionErrorMessage.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:28:57'!
test08CannotPutStoneOutsideOfTheLeftSideOfTheBoard

| game |

game := TerniLapilli new.

self should: [game putStoneAt: -1@0.] raise: Error withMessageText: TerniLapilli cannotAddStoneOutOfBoundsErrorMessage.! !

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

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:30:32'!
test12XCannotPutMoreThanThreeStones

| game |

game := self filledTerniLapilli.

self should: [game putStoneAt: 0@2.] raise: Error withMessageText: TerniLapilli cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage.! !

!TerniLapilliTestCase methodsFor: 'testing' stamp: 'FL 10/16/2019 16:30:32'!
test13YCannotPutMoreThanThreeStones

| game |

game := self filledTerniLapilli.
game moveStoneUp: 1@1.

self should: [game putStoneAt: 0@2.] raise: Error withMessageText: TerniLapilli cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage.! !

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

!TerniLapilli methodsFor: 'adding' stamp: 'FL 10/16/2019 16:30:32'!
putStoneAt: stonePosition

(self positionIsInsideBoard: stonePosition) ifFalse: [self error: self class cannotAddStoneOutOfBoundsErrorMessage ].
(self positionIsEmpty: stonePosition) ifFalse: [self error: self class cannotAddStoneOnAnOccupiedPositionErrorMessage ].
(turnX ifTrue: [xStones] ifFalse: [yStones]) size = 3 ifTrue: [self error: self class cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage ].

(turnX ifTrue: [xStones] ifFalse: [yStones]) add: stonePosition.

turnX _ turnX not.! !


!TerniLapilli methodsFor: 'private' stamp: 'LEB 10/10/2019 18:26:32'!
positionIsInsideBoard: stonePosition
	^ (stonePosition x between: 0 and: 2) and: [stonePosition y between: 0 and: 2].! !


!TerniLapilli methodsFor: 'initialization' stamp: 'LEB 10/10/2019 18:44:22'!
initialize
	
	turnX _ true.
	xStones _ Set new.
	yStones _ Set new.! !


!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:54:32'!
includesStoneFromXAt: aStonePosition
	^ xStones includes: aStonePosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:54:39'!
includesStoneFromYAt: aStonePosition
	^ yStones includes: aStonePosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 17:26:30'!
isTurnOfX
	
	^turnX.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:43:54'!
isTurnOfY
	
	^self isTurnOfX not.! !

!TerniLapilli methodsFor: 'testing' stamp: 'LEB 10/10/2019 18:42:16'!
positionIsEmpty: stonePosition
	^ ((xStones includes: stonePosition) or: [yStones includes: stonePosition]) not.! !


!TerniLapilli methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:30:51'!
moveStoneDown: aStonePosition

(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
self putStoneAt: aStonePosition + (0@-1).
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 16:21:40'!
moveStoneDownleft: aStonePosition 
	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (-1@-1).! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 16:19:12'!
moveStoneDownright: aStonePosition 
	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (1@-1).! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:41:35'!
moveStoneLeft: aStonePosition

	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (-1@0).
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:42:30'!
moveStoneRight: aStonePosition

	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (1@0).
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'LEB 10/10/2019 20:29:58'!
moveStoneUp: aStonePosition

(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
self putStoneAt: aStonePosition + (0@1).
! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 16:15:04'!
moveStoneUpleft: aStonePosition 
	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (-1@1).! !

!TerniLapilli methodsFor: 'movingStones' stamp: 'FL 10/16/2019 16:10:59'!
moveStoneUpright: aStonePosition 
	(turnX ifTrue: [xStones] ifFalse: [yStones]) remove: aStonePosition.
	self putStoneAt: aStonePosition + (1@1).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Excercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 16:24:31'!
cannotAddStoneOnAnOccupiedPositionErrorMessage

	^'Dale gil no podes hacr eso'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 16:28:11'!
cannotAddStoneOutOfBoundsErrorMessage
	^ 'dale gato'! !

!TerniLapilli class methodsFor: 'exceptions' stamp: 'FL 10/16/2019 16:30:32'!
cannotAddStoneWhenPlayerHasMaximumStonesErrorMessage
	^'No podes hacer eso'.! !
