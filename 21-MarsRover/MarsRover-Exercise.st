!classDefinition: #MarsRoverTests category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'assertions' stamp: 'FL 10/9/2019 19:01:08'!
assert: aMarsRover isOver: aPosition lookingAt: aCardinalPoint

self assert: aPosition equals: aMarsRover position.
self assert: aCardinalPoint equals: aMarsRover direction.! !


!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:11:15'!
test01EmptyInstructionsSamePositionAndDirection
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: ''.

self assert: mr isOver: 0@0 lookingAt: CardinalPointNorth new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:10:06'!
test02MovingForwardToTheNorthIncrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'f'.

self assert: mr isOver: 0@1 lookingAt: CardinalPointNorth new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:09:42'!
test03MovingBackwardToTheNorthDecrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'b'.

self assert: mr isOver: 0@-1 lookingAt: CardinalPointNorth new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/10/2019 15:04:35'!
test04RotatingTowardsRightFromTheNorthChangesTheDirectionToEast
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'r'.

self assert: mr isOver: 0@0 lookingAt: CardinalPointEast new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:09:07'!
test05RotatingTowardsLeftFromTheNorthChangesTheDirectionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'l'.

self assert: mr isOver: 0@0 lookingAt: CardinalPointWest new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:08:42'!
test06MovingForwardToWestIncrementsOnePositionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointWest new.

mr do: 'f'.

self assert: mr isOver: -1@0 lookingAt: CardinalPointWest new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:08:00'!
test07MovingForwardToSouthIncrementsOnePositionToSouth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointSouth new.

mr do: 'f'.

self assert: mr isOver: 0@-1 lookingAt: CardinalPointSouth new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:07:34'!
test08MovingForwardToEastIncrementsOnePositionToEast
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointEast new.

mr do: 'f'.

self assert: mr isOver: 1@0 lookingAt: CardinalPointEast new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:06:07'!
test09MovingBackwardDecrementsOnePositionToPointingDirection
| mr_w mr_e mr_n mr_s |

mr_w := MarsRover at: 0@0 directedTo: CardinalPointWest new.
mr_e := MarsRover at: 0@0 directedTo: CardinalPointEast new.
mr_s := MarsRover at: 0@0 directedTo: CardinalPointSouth new.
mr_n := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr_w do: 'b'.
mr_e do: 'b'.
mr_s do: 'b'.
mr_n do: 'b'.

self assert: mr_w isOver: 1@0 lookingAt: CardinalPointWest new.
self assert: mr_e isOver: -1@0 lookingAt: CardinalPointEast new.
self assert: mr_s isOver: 0@1 lookingAt: CardinalPointSouth new.
self assert: mr_n isOver: 0@-1 lookingAt: CardinalPointNorth new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:16:33'!
test10RotatingTowardsRightChangesDirectionToTheRightOne
| mr_w mr_e mr_n mr_s |

mr_w := MarsRover at: 0@0 directedTo: CardinalPointWest new.
mr_e := MarsRover at: 0@0 directedTo: CardinalPointEast new.
mr_s := MarsRover at: 0@0 directedTo: CardinalPointSouth new.
mr_n := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr_w do: 'r'.
mr_e do: 'r'.
mr_s do: 'r'.
mr_n do: 'r'.

self assert: mr_w isOver: 0@0 lookingAt: CardinalPointNorth new.
self assert: mr_e isOver: 0@0 lookingAt: CardinalPointSouth new.
self assert: mr_s isOver: 0@0 lookingAt: CardinalPointWest new.
self assert: mr_n isOver: 0@0 lookingAt: CardinalPointEast new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:34:59'!
test11RotatingTowardsLeftChangesDirectionToTheLeftOne
| mr_w mr_e mr_n mr_s |

mr_w := MarsRover at: 0@0 directedTo: CardinalPointWest new.
mr_e := MarsRover at: 0@0 directedTo: CardinalPointEast new.
mr_s := MarsRover at: 0@0 directedTo: CardinalPointSouth new.
mr_n := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr_w do: 'l'.
mr_e do: 'l'.
mr_s do: 'l'.
mr_n do: 'l'.

self assert: mr_w isOver: 0@0 lookingAt: CardinalPointSouth new.
self assert: mr_e isOver: 0@0 lookingAt: CardinalPointNorth new.
self assert: mr_s isOver: 0@0 lookingAt: CardinalPointEast new.
self assert: mr_n isOver: 0@0 lookingAt: CardinalPointWest new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:55:30'!
test12MoreThanOneInstruccionAreProcessedSequentially
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'frblfl'.

self assert: mr isOver: -1@2 lookingAt: CardinalPointWest new.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/10/2019 14:56:28'!
test13TryingToProcessAnUndefinedCommandRaisesAnError
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

self should: [mr do: 'x'.]  raise: Error  withMessageText: MarsRover undefinedCommand.! !


!classDefinition: #CardinalPoints category: #'MarsRover-Exercise'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPoints methodsFor: 'mars rover operations' stamp: 'FL 10/8/2019 09:21:56'!
moveBackward: aMarsRover
	
	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 14:49:58'!
moveForward: aMarsRover
	
	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:01:30'!
rotateLeft: aMarsRover
	
	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:01:48'!
rotateRight: aMarsRover
	
	self subclassResponsibility ! !


!classDefinition: #CardinalPointEast category: #'MarsRover-Exercise'!
CardinalPoints subclass: #CardinalPointEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPointEast methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:04'!
moveBackward: aMarsRover
aMarsRover moveBackwardEast.! !

!CardinalPointEast methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:04'!
moveForward: aMarsRover
aMarsRover moveForwardEast.! !

!CardinalPointEast methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:02:18'!
rotateLeft: aMarsRover
aMarsRover rotateLeftEast.! !

!CardinalPointEast methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:03:42'!
rotateRight: aMarsRover
aMarsRover rotateRightEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPointEast class' category: #'MarsRover-Exercise'!
CardinalPointEast class
	instanceVariableNames: 'uniqueInstance'!

!CardinalPointEast class methodsFor: 'class initialization' stamp: 'FL 10/8/2019 09:20:28'!
initialize

	uniqueInstance := self basicNew! !


!CardinalPointEast class methodsFor: 'instance creation' stamp: 'FL 10/8/2019 09:21:10'!
new

	^uniqueInstance! !


!classDefinition: #CardinalPointNorth category: #'MarsRover-Exercise'!
CardinalPoints subclass: #CardinalPointNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPointNorth methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:26'!
moveBackward: aMarsRover
aMarsRover moveBackwardNorth.! !

!CardinalPointNorth methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:26'!
moveForward: aMarsRover
aMarsRover moveForwardNorth.! !

!CardinalPointNorth methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:03:17'!
rotateLeft: aMarsRover
aMarsRover rotateLeftNorth.! !

!CardinalPointNorth methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:03:53'!
rotateRight: aMarsRover
aMarsRover rotateRightNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPointNorth class' category: #'MarsRover-Exercise'!
CardinalPointNorth class
	instanceVariableNames: 'uniqueInstance'!

!CardinalPointNorth class methodsFor: 'class initialization' stamp: 'FL 10/8/2019 09:22:33'!
initialize

	uniqueInstance := self basicNew! !


!CardinalPointNorth class methodsFor: 'instance creation' stamp: 'FL 10/8/2019 09:23:27'!
new

	^uniqueInstance! !


!classDefinition: #CardinalPointSouth category: #'MarsRover-Exercise'!
CardinalPoints subclass: #CardinalPointSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPointSouth methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:37'!
moveBackward: aMarsRover
aMarsRover moveBackwardSouth.! !

!CardinalPointSouth methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:37'!
moveForward: aMarsRover
aMarsRover moveForwardSouth.! !

!CardinalPointSouth methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:03:25'!
rotateLeft: aMarsRover
aMarsRover rotateLeftSouth.! !

!CardinalPointSouth methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:04:03'!
rotateRight: aMarsRover
aMarsRover rotateRightSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPointSouth class' category: #'MarsRover-Exercise'!
CardinalPointSouth class
	instanceVariableNames: 'uniqueInstance'!

!CardinalPointSouth class methodsFor: 'class initialization' stamp: 'FL 10/8/2019 09:22:43'!
initialize

	uniqueInstance := self basicNew! !


!CardinalPointSouth class methodsFor: 'instance creation' stamp: 'FL 10/8/2019 09:23:35'!
new

	^uniqueInstance! !


!classDefinition: #CardinalPointWest category: #'MarsRover-Exercise'!
CardinalPoints subclass: #CardinalPointWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPointWest methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:47'!
moveBackward: aMarsRover
aMarsRover moveBackwardWest.! !

!CardinalPointWest methodsFor: 'mars rover operations' stamp: 'LEB 10/7/2019 21:39:47'!
moveForward: aMarsRover
aMarsRover moveForwardWest.! !

!CardinalPointWest methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:03:33'!
rotateLeft: aMarsRover
aMarsRover rotateLeftWest.! !

!CardinalPointWest methodsFor: 'mars rover operations' stamp: 'LEB 10/10/2019 15:04:13'!
rotateRight: aMarsRover
aMarsRover rotateRightWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPointWest class' category: #'MarsRover-Exercise'!
CardinalPointWest class
	instanceVariableNames: 'uniqueInstance'!

!CardinalPointWest class methodsFor: 'class initialization' stamp: 'FL 10/8/2019 09:22:56'!
initialize

	uniqueInstance := self basicNew! !


!CardinalPointWest class methodsFor: 'instance creation' stamp: 'FL 10/8/2019 09:23:45'!
new

	^uniqueInstance! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'LEB 10/3/2019 21:07:40'!
initializeAt: aPosition directedTo: aDirection 

position := aPosition.
direction := aDirection.! !


!MarsRover methodsFor: 'operating' stamp: 'FL 10/9/2019 19:58:51'!
do: aCommandSet

aCommandSet do: [:c | self processCommand: c ].! !

!MarsRover methodsFor: 'operating' stamp: 'FL 10/9/2019 20:36:39'!
processCommand: aCommand

| commandMethod |

commandMethod _ self class commandsDictionary at: aCommand ifAbsent: [self error: MarsRover undefinedCommand.].

direction perform: commandMethod with: self.! !


!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:06'!
moveBackwardEast
position := -1@0 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:26'!
moveBackwardNorth
position := 0@-1 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:36'!
moveBackwardSouth
position := 0@1 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:44'!
moveBackwardWest
position := 1@0 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:06'!
moveForwardEast
position := 1@0 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:26'!
moveForwardNorth
position := 0@1 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:36'!
moveForwardSouth
position := 0@-1 + position.! !

!MarsRover methodsFor: 'moving' stamp: 'LEB 10/7/2019 21:45:44'!
moveForwardWest
position := -1@0 + position.! !


!MarsRover methodsFor: 'accessing' stamp: 'LEB 10/3/2019 21:11:43'!
direction
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'LEB 10/3/2019 21:11:13'!
position
	^position! !


!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:02:17'!
rotateLeftEast

	direction := CardinalPointNorth new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:03:17'!
rotateLeftNorth

	direction := CardinalPointWest new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:03:25'!
rotateLeftSouth

	direction := CardinalPointEast new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:03:33'!
rotateLeftWest

	direction := CardinalPointSouth new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:03:42'!
rotateRightEast

	direction := CardinalPointSouth new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:03:53'!
rotateRightNorth

	direction := CardinalPointEast new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:04:03'!
rotateRightSouth

	direction := CardinalPointWest new.! !

!MarsRover methodsFor: 'rotating' stamp: 'LEB 10/10/2019 15:04:13'!
rotateRightWest

	direction := CardinalPointNorth new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: 'commandsDictionary'!

!MarsRover class methodsFor: 'instance creation' stamp: 'FL 10/9/2019 20:37:32'!
at: aPosition directedTo: aDirection
	^ self new initializeAt: aPosition directedTo: aDirection! !


!MarsRover class methodsFor: 'error description' stamp: 'FL 10/9/2019 20:05:26'!
undefinedCommand

	^'Cannot process given command'! !


!MarsRover class methodsFor: 'class variables' stamp: 'FL 10/9/2019 20:26:56'!
commandsDictionary
	^commandsDictionary! !


!MarsRover class methodsFor: 'class initialization' stamp: 'LEB 10/10/2019 15:01:48'!
initialize

	commandsDictionary _ Dictionary newFromPairs: {$f . #moveForward: .$b . #moveBackward: . $r . #rotateRight: . $l . #rotateLeft:}.
	! !

CardinalPointEast initialize!
CardinalPointNorth initialize!
CardinalPointSouth initialize!
CardinalPointWest initialize!
MarsRover initialize!