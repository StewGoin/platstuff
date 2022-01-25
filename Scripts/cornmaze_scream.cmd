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

start:
gosub go_room 37
put scream

gosub go_room 51
put scream

gosub go_room 228
put scream

gosub go_room 151
put scream

gosub go_room 104
put scream

