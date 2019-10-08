!classDefinition: #MarsRoverTests category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:09:43'!
test01EmptyInstructionsSamePosition
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: ''.

self assert: 0@0 equals: mr position.
self assert: CardinalPointNorth new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:25:44'!
test02MovingForwardToTheNorthIncrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'f'.
self assert: 0@1 equals: mr position.
self assert: CardinalPointNorth new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:25:51'!
test03MovingBackwardToTheNorthDecrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'b'.
self assert: 0@-1 equals: mr position.
self assert: CardinalPointNorth new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:26:04'!
test04RotatingTowardsRightFromTheNorthChangesTheDirectionEast
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'r'.
self assert: 0@0 equals: mr position.
self assert: CardinalPointEast new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:26:08'!
test05RotatingTowardsLeftFromTheNorthChangesTheDirectionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr do: 'l'.
self assert: 0@0 equals: mr position.
self assert: CardinalPointWest new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:28:11'!
test06MovingForwardToWestIncrementsOnePositionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointWest new.

mr do: 'f'.
self assert: -1@0 equals: mr position.
self assert: CardinalPointWest new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:29:07'!
test07MovingForwardToSouthIncrementsOnePositionToSouth
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointSouth new.

mr do: 'f'.
self assert: 0@-1 equals: mr position.
self assert: CardinalPointSouth new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:30:44'!
test08MovingForwardToEastIncrementsOnePositionToEast
| mr |

mr := MarsRover at: 0@0 directedTo: CardinalPointEast new.

mr do: 'f'.
self assert: 1@0 equals: mr position.
self assert: CardinalPointEast new equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/7/2019 21:30:07'!
test09MovingForwardToEastIncrementsOnePositionToEast
| mr_w mr_e mr_n mr_s |

mr_w := MarsRover at: 0@0 directedTo: CardinalPointWest new.
mr_e := MarsRover at: 0@0 directedTo: CardinalPointEast new.
mr_s := MarsRover at: 0@0 directedTo: CardinalPointSouth new.
mr_n := MarsRover at: 0@0 directedTo: CardinalPointNorth new.

mr_w do: 'b'.
mr_e do: 'b'.
mr_s do: 'b'.
mr_n do: 'b'.

self assert: 1@0 equals: mr_w position.
self assert: CardinalPointWest new equals: mr_w direction.

self assert: -1@0 equals: mr_e position.
self assert: CardinalPointEast new equals: mr_e direction.

self assert: 0@1 equals: mr_s position.
self assert: CardinalPointSouth new equals: mr_s direction.

self assert: 0@-1 equals: mr_n position.
self assert: CardinalPointNorth new equals: mr_n direction.! !


!classDefinition: #CardinalPoints category: #'MarsRover-Exercise'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'LEB 10/7/2019 21:50:15'!
= aCardinalPoint
^self class = aCardinalPoint class! !

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
