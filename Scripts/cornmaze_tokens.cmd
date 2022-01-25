IF_1 goto reset
goto start

include includes.cmd

reset:
put #var corn_tokenroom 2

start:
if $corn_tokenroom = "" then put #var corn_tokenroom 2
action var complete 1 when ASK HALFLING ABOUT TASK again\.$
gosub go_room $corn_tokenroom

loop:
put search
var CORN_TOKENROOM $corn_tokenroom
evalmath CORN_TOKENROOM (%CORN_TOKENROOM + 1)
put #var corn_tokenroom %CORN_TOKENROOM
pause 0.5
if %complete = 1 then goto done
gosub go_room $corn_tokenroom
goto loop

done:
echo "Task Complete"