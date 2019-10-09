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

!MarsRoverTests methodsFor: 'test' stamp: 'FL 10/9/2019 19:09:23'!
test04RotatingTowardsRightFromTheNorthChangesTheDirectionEast
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


!classDefinition: #CardinalPoints category: #'MarsRover-Exercise'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'FL 10/8/2019 09:21:56'!
moveBackward: aMarsRover
	
	self subclassResponsibility ! !

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:38:34'!
moveForward: aaaaa
self subclassResponsibility.! !


!classDefinition: #CardinalPointEast category: #'MarsRover-Exercise'!
CardinalPoints subclass: #CardinalPointEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPointEast methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:04'!
moveBackward: aMarsRover
aMarsRover moveBackwardEast.! !

!CardinalPointEast methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:04'!
moveForward: aMarsRover
aMarsRover moveForwardEast.! !

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

!CardinalPointNorth methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:26'!
moveBackward: aMarsRover
aMarsRover moveBackwardNorth.! !

!CardinalPointNorth methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:26'!
moveForward: aMarsRover
aMarsRover moveForwardNorth.! !

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

!CardinalPointSouth methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:37'!
moveBackward: aMarsRover
aMarsRover moveBackwardSouth.! !

!CardinalPointSouth methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:37'!
moveForward: aMarsRover
aMarsRover moveForwardSouth.! !

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

!CardinalPointWest methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:47'!
moveBackward: aMarsRover
aMarsRover moveBackwardWest.! !

!CardinalPointWest methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:39:47'!
moveForward: aMarsRover
aMarsRover moveForwardWest.! !

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

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:11:43'!
direction
	^direction! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/7/2019 21:54:52'!
do: aCommand

'f' = aCommand ifTrue: [
	direction moveForward: self.
].
'b' = aCommand ifTrue: [ 
	direction moveBackward: self.
].
'r' = aCommand ifTrue: [ direction := CardinalPointEast new ].
'l' = aCommand ifTrue: [ direction := CardinalPointWest new ].! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:07:40'!
initializeAt: aPosition directedTo: aDirection 

position := aPosition.
direction := aDirection.! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:11:13'!
position
	^position! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'XXX' stamp: 'LEB 10/3/2019 21:09:11'!
at: XXXX directedTo: YYYY
	^ self new initializeAt: XXXX directedTo: YYYY! !

CardinalPointEast initialize!
CardinalPointNorth initialize!
CardinalPointSouth initialize!
CardinalPointWest initialize!