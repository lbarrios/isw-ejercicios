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

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:13:33'!
test02MovingForwardToADirectionIncrementsOnePositionOnThatDirection
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'f'.
self assert: 0@1 equals: mr position.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:13:37'!
test03MovingBackwardToADirectionDecrementsOnePositionOnThatDirection
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'b'.
self assert: 0@-1 equals: mr position.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:13:41'!
test04RotatingTowardsRightFromADirectionChangesTheDirectionToTheRight
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'r'.
self assert: #East equals: mr direction.! !

!MarsRoverTests methodsFor: 'test' stamp: 'LEB 10/3/2019 21:13:45'!
test05RotatingTowardsLeftFromADirectionChangesTheDirectionToTheLeft
| mr |

mr := MarsRover at: 0@0 directedTo: #North.

mr do: 'l'.
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

!MarsRover methodsFor: 'AAAA' stamp: 'LEB 10/3/2019 21:19:05'!
do: aCommand

'f' = aCommand ifTrue: [ position := 0@1 + position].
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
