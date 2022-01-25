# Pond == 427
# Several fleas drop onto you and vanish into your clothing.
# You think that you've disarmed enough traps and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.

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
    pause 0.5
    put stand
    pause 0.5
    if $standing != 1 then goto standup
    else return
    
reset:
put #var corn_traproom 2

start:
if $corn_traproom = "" then put #var corn_traproom 2
action var complete 1 when ASK HALFLING ABOUT TASK again\.$
action put #echo >Log Red You have fleas... when Several fleas drop onto you and vanish into your clothing\.
gosub go_room $corn_traproom

loop:
put search
pause 0.5
put disarm trap
var CORN_TRAPROOM $corn_traproom
evalmath CORN_TRAPROOM (%CORN_TRAPROOM + 1)
put #var corn_traproom %CORN_TRAPROOM
pause 0.5
if $standing != 1 then gosub standup
if %complete = 1 then goto done
gosub go_room $corn_traproom
goto loop

done:
echo "Task Complete"