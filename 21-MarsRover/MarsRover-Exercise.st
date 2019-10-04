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

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:03:20'!
test05RotatingTowardsLeftFromADirectionChangesTheDirectionToTheLeft
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr doAction: 'l'.
self assert: #West equals: mr direction.! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:11:43'!
direction
	^direction! !

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:10:54'!
do: aString 
! !

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
