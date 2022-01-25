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

standup:
    pause 0.2
    put stand
    pause 0.2
    if $standing != 1 then goto standup
    else return

kneeldown:
    pause 0.2
    put kneel
    pause 0.2
    if $kneeling != 1 then goto kneeldown
    else return
    
reset:
put #var corn_weedroom 2

start:
if $corn_weedroom = "" then put #var corn_weedroom 2
action var complete 1 when ASK HALFLING ABOUT TASK again\.$
gosub go_room $corn_weedroom

loop:
if $kneeling != 1 then gosub kneeldown
put pull weeds
var CORN_WEEDROOM $corn_weedroom
evalmath CORN_WEEDROOM (%CORN_WEEDROOM + 1)
put #var corn_weedroom %CORN_WEEDROOM
pause 0.5
if $standing != 1 then gosub standup
if %complete = 1 then goto done
gosub go_room $corn_weedroom
goto loop

done:
echo "Task Complete"