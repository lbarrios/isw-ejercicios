"
MarsRover:
==========
* f -> move forward
* b -> move backward
* r -> rotate right
* l -> rotate left
"

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: #MarsRoverTests category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTests methodsFor: 'test' stamp: 'Alguien 1/1/0001 01:01'!
test01EmptyInstructionsSamePosition
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: ''.

self assert: 0@0 equals: mr position.
self assert: #North equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'Alguien 1/1/0001 01:01'!
test02MovingForwardToADirectionIncrementsOnePositionOnThatDirection
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: 'f'.
self assert: 0@1 equals: mr position.! !

!MarsRoverTests methodsFor: 'test' stamp: 'Alguien 1/1/0001 01:01'!
test03MovingBackwardToADirectionDecrementsOnePositionOnThatDirection
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: 'b'.
self assert: 0@-1 equals: mr position.! !

!MarsRoverTests methodsFor: 'test' stamp: 'Alguien 1/1/0001 01:01'!
test04RotatingTowardsRightFromADirectionChangesTheDirectionToTheRight
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: 'r'.
self assert: #East equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'Alguien 1/1/0001 01:01'!
test05RotatingTowardsLeftFromADirectionChangesTheDirectionToTheLeft
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: 'l'.
self assert: #West equals: mr direction.

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!