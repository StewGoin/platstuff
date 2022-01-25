var labyrinth_room 2
var left_room 50
var right_room 227
var neck_room 150
var leg_room 187
var back_room 352
action goto done when ASK HALFLING ABOUT TASK again\.$
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
gosub go_room %labyrinth_room

labyrinth_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath labyrinth_room (%labyrinth_room + 1)
    goto start
}
labyrinth_buildit:
match left_start You've already built a scarecrow here.
match left_start You put the finishing touches on your scarecrow.
match labyrinth_buildit Roundtime.
put build
matchwait 2
goto labyrinth_buildit

left_start:
gosub go_room %left_room

left_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath left_room (%left_room + 1)
    goto left_start
}
left_buildit:
match right_start You've already built a scarecrow here.
match right_start You put the finishing touches on your scarecrow.
match left_buildit Roundtime.
put build
matchwait 2
goto left_buildit

right_start:
gosub go_room %right_room

right_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath right_room (%right_room + 1)
    goto right_start
}
right_buildit:
match neck_start You've already built a scarecrow here.
match neck_start You put the finishing touches on your scarecrow.
match right_buildit Roundtime.
put build
matchwait 2
goto right_buildit

neck_start:
gosub go_room %neck_room

neck_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath neck_room (%neck_room + 1)
    goto neck_start
}
neck_buildit:
match leg_start You've already built a scarecrow here.
match leg_start You put the finishing touches on your scarecrow.
match neck_buildit Roundtime.
put build
matchwait 2
goto neck_buildit

leg_start:
gosub go_room %leg_room

leg_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath leg_room (%leg_room + 1)
    goto leg_start
}
leg_buildit:
match back_start You've already built a scarecrow here.
match back_start You put the finishing touches on your scarecrow.
match leg_buildit Roundtime.
put build
matchwait 2
goto leg_buildit

back_start:
gosub go_room %back_room

back_build:
if matchre("$roomobjs", "scarecrow") then
{
    evalmath back_room (%back_room + 1)
    goto back_start
}
back_buildit:
match done You've already built a scarecrow here.
match done You put the finishing touches on your scarecrow.
match back_buildit Roundtime.
put build
matchwait 2
goto back_buildit

done:
echo "Task Complete"
