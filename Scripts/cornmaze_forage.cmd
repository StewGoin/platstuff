IF_1 goto reset
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

reset:
put #var corn_forageroom 2

start:
if $corn_forageroom = "" then put #var corn_forageroom 2
action var complete 1 when ASK HALFLING ABOUT TASK again\.$
gosub go_room $corn_forageroom

loop:
put forage corn
var CORN_FORAGEROOM $corn_forageroom
evalmath CORN_FORAGEROOM (%CORN_FORAGEROOM + 1)
put #var corn_forageroom %CORN_FORAGEROOM
pause 0.5
if %complete = 1 then goto done
gosub go_room $corn_forageroom
goto loop

done:
echo "Task Complete"