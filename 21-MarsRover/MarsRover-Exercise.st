!classDefinition: #MarsRoverTests category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:09:43'!
test01EmptyInstructionsSamePosition
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: ''.

self assert: 0@0 equals: mr position.
self assert: #North equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:25:44'!
test02MovingForwardToTheNorthIncrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'f'.
self assert: 0@1 equals: mr position.
self assert: #North equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:25:51'!
test03MovingBackwardToTheNorthDecrementsOnePositionToTheNorth
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'b'.
self assert: 0@-1 equals: mr position.
self assert: #North equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:26:04'!
test04RotatingTowardsRightFromTheNorthChangesTheDirectionEast
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'r'.
self assert: 0@0 equals: mr position.
self assert: #East equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:26:08'!
test05RotatingTowardsLeftFromTheNorthChangesTheDirectionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'l'.
self assert: 0@0 equals: mr position.
self assert: #West equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:28:11'!
test06MovingForwardToWestIncrementsOnePositionToWest
| mr |

mr := MarsRover at: 0@0 directedTo: #West.

mr do: 'f'.
self assert: -1@0 equals: mr position.
self assert: #West equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:29:07'!
test07MovingForwardToSouthIncrementsOnePositionToSouth
| mr |

mr := MarsRover at: 0@0 directedTo: #South.

mr do: 'f'.
self assert: 0@-1 equals: mr position.
self assert: #South equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:30:44'!
test08MovingForwardToEastIncrementsOnePositionToEast
| mr |

mr := MarsRover at: 0@0 directedTo: #East.

mr do: 'f'.
self assert: 1@0 equals: mr position.
self assert: #East equals: mr direction.! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:11:43'!
direction
	^direction! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:29:43'!
do: aCommand

'f' = aCommand ifTrue: [ 
	#North = direction ifTrue: [position := 0@1 + position].
	#West = direction ifTrue: [position := -1@0 + position]. 
	#South = direction ifTrue: [position := 0@-1 + position]. 
	#East = direction ifTrue: [position := 1@0 + position]. 
].
'b' = aCommand ifTrue: [ position := 0@-1 + position].
'r' = aCommand ifTrue: [ direction := #East ].
'l' = aCommand ifTrue: [ direction := #West ].! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:07:40'!
initializeAt: aPosition directedTo: aDirection 

position := aPosition.
direction := aDirection.! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:11:13'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'XXX' stamp: 'LEB 10/3/2019 21:09:11'!
at: XXXX directedTo: YYYY
	^ self new initializeAt: XXXX directedTo: YYYY! !
