# CLean, genie-ize, subs & include out.

#debug 5
var climb_done 0
action var climb_done 1 when eval $Athletics.LearningRate > 32
goto start

include includes.cmd

MAP_CHECK:
	if "$zoneid" = "66" then
	{
		gosub go_room 216
		move w
		return
	}
	if "$zoneid" = "69" then
	{
		gosub go_room 31
		move e
		return
	}
	if "$zoneid" = "68" then
	{
		gosub go_room 1
		move e
		return
	}
	if "$zoneid" = "67" then return

exit

start:
pause
CLIMB_CYCLIC:
  put rel all
  put #var cam_leeched 1
  put #var cam_slipped 1
  put .cast hodi 20
  waitfor Spell Cast
pause
put wield right my nightstick
pause
put wield left my stake
pause
gosub map_check
pause

CLIMB.START:
put #var powerwalk 0
put set roomname
put awake
#if ("$righthand" != "Empty") then put stow right
#if ("$lefthand" != "Empty") then put stow left
#put stop sing
#put .enc lilt 20 loud on
pause 3

CLIMB-E:
if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if $roomid != 32 then gosub go_room 32
if $Athletics.LearningRate < 33 then gosub CLIMBEAST
else goto CLIMB-DONE

CLIMB-N:
if $roomid != 1 then gosub go_room 1
if $Athletics.LearningRate < 33 then gosub CLIMBNORTH
else goto CLIMB-DONE

CLIMB-W:
if $roomid != 43 then gosub go_room 43
if $Athletics.LearningRate < 33 then gosub CLIMBWEST
else goto CLIMB-DONE

CLIMB-S:
if $roomid != 199 then gosub go_room 199
if $Athletics.LearningRate < 33 then gosub CLIMBSOUTH
else goto CLIMB-DONE

CLIMB-CHECK:
#put #var powerwalk 0
if $Athletics.LearningRate < 33 then goto CLIMB-E
else goto CLIMB-DONE

CLIMB-DONE:
pause
put stow my stake
pause
put stow my nightstick
pause
gosub map_check
pause
#put #script abort enc;stop sing
put #parse Script Done
exit


CLIMBEAST:
	pause 0.5
	if "$roomname" != "Shard, East City Gates" then
	{
		put #goto 32
		waitfor YOU HAVE ARRIVED
		pause
	}
	move climb ladder
	move north
	gosub CLIMBIT embrasure
	if "$roomname" = "Shard, East Battlements" then
	{
		move south
		move climb ladder
		move go gate
	}
	gosub climbit wall
	if "$roomname" = "Shard, East Bridge" then put go gate
	else
	{
		move south
		move climb ladder
	}
	move n
	pause
	return

CLIMBNORTH:
	pause 0.5
	if "$roomname" != "Shard, North City Gates" then
	{
		put #goto 1
		waitfor YOU HAVE ARRIVED
		pause
	}
	move climb ladder
	move west
	gosub CLIMBIT embrasure
	if "$roomname" = "Shard, North Battlements" then
	{
		move east
		move climb ladder
		move go gate
	}
	gosub CLIMBIT wall
	if "$roomname" = "Shard, North Bridge" then put go gate
	else
	{
		move east
		move climb ladder
	}
	move w
	pause
	return

CLIMBWEST:
	pause 0.5
	if "$roomname" != "Shard, West City Gates" then
	{
		put #goto 43
		waitfor YOU HAVE ARRIVED
		pause
	}
	move climb ladder
	move south
	gosub CLIMBIT embrasure
	if "$roomname" = "Shard, West Battlements" then
	{
		move north
		move climb ladder
		move go gate
	}
	gosub CLIMBIT wall
	if "$roomname" = "Shard, West Bridge" then put go gate
	else
	{
		move north
		move climb ladder
	}
	move s
	pause
	return

CLIMBSOUTH:
	pause 0.5
	if !matchre("$roomobjs", "stairway to the tower battlements") then
	{
		put #goto 206
		waitfor YOU HAVE ARRIVED
		pause
	}
	move climb stair
	move east
	gosub CLIMBIT embrasure
	if "$roomname" = "The New Bridge, East Tower" then
	{
		move west
		move climb ladder
		move go gate
	}
	gosub CLIMBIT wall
	if "$roomname" = "Old Ilithi Trade Route, Journey's Rest" then put go gate
	else
	{
		move west
		move climb stair
	}
	move n
	pause
	return

CLIMBIT:
	var CLIMB $1
	pause 0.5
		matchre PASS_CLIMB Obvious (paths|exits)
		matchre FAIL_CLIMB You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going|your footing is questionable|slip after a few feet|A wave of dizziness hits you|Struck by vertigo|All this climbing back and forth is getting a bit tiresome
	put climb %CLIMB
		matchwait

PASS_CLIMB:
	pause 0.5
	return

FAIL_CLIMB:
	pause 0.5
	if $standing != 1 then
	{
		send stand
		goto FAIL_CLIMB
	}
	else return
