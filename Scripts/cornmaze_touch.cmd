IF_1 goto %1
goto start

## Movement ################################
MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Obvious
   send %Dir
   matchwait

go_room:
	pause 0.2
	match good_move YOU HAVE ARRIVED
	match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return
good_MOVE_2:
    PAUSE 0.2
    MATCH ACTION YOU HAVE ARRIVED
    MATCH good_MOVE_2 MOVE FAILED
    PUT #goto $1 $2
    MATCHWAIT
    ACTION:
    return

RETURN:
   return
        
1:
start:
gosub go_room 5
put touch stones
gosub go_room 16
put touch rake
gosub go_room 17
put touch hay
gosub go_room 22
put touch pail
gosub go_room 26
put touch fencepost
gosub go_room 30
put touch burrow
gosub go_room 15
put touch wagon
gosub go_room 38
put touch statue
gosub go_room 42
put touch hut
gosub go_room 47
put touch straw
exit

2:
gosub go_room 103
put touch statue
gosub go_room 104
put touch spiderweb
gosub go_room 111
put touch rake
gosub go_room 115
put touch stones
gosub go_room 120
put touch hay
gosub go_room 125
put touch boulder
gosub go_room 147
put touch wheelbarrow
gosub go_room 141
put touch boulder
gosub go_room 133
put touch wheelbarrow
gosub go_room 137
put touch boulder
exit

3:
gosub go_room 52
put touch wood
gosub go_room 59
put touch basket
gosub go_room 61
put touch stones
gosub go_room 79
put touch hay
gosub go_room 99
put touch rake
gosub go_room 69
put touch boulder
gosub go_room 86
put touch wheelbarrow
gosub go_room 93
put touch boulder
gosub go_room 96
put touch spiderweb
gosub go_room 231
put touch spiderweb
exit


