# Compare to ClimbCross and pick on, then clean this and rename to new style

#Climb Crossing Walls
#This Script created by the player of Kraelyst
#debug 10

# standard = 2, premium = 3
var climb_done 0
action var climb_done 1 when eval $Athletics.LearningRate > 32
goto start

include includes.cmd

map_check:
	if "$zoneid" = "8" then
	{
		gosub go_room 43
		gosub move w
		return
	}
	if "$zoneid" = "7" then
	{
		gosub go_room 349
		gosub move w
		return
	}
	if "$zoneid" = "4" then
	{
		gosub go_room 14
		gosub move e
		return
	}
	if "$zoneid" = "6" then
	{
		gosub go_room 23
		gosub move e
		return
	}
	if "$zoneid" = "1" then return

exit

start:
gosub map_check
pause
put wield right my cuska
pause
put wield left my mallet
pause
if $roomid != 387 then gosub go_room 387

CLIMB-START:
put set roomname
put awake
#if ("$righthand" != "Empty") then put stow right
#if ("$lefthand" != "Empty") then put stow left
if $SpellTimer.HodiernasLilt.active = 0 then {
	put .cast hodi 20
	waitfor Spell Cast
	}
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
pause 0.5

CLIMB-001:
SAVE FAIL-001
match PASS-001 [Outside East Wall, Footpath]
match FAIL-001 You must be standing
match FAIL-001 steepness is intimidating
match FAIL-001 can't seem to find purchase
match FAIL-001 find it hard going.
match FAIL-001 your footing is questionable
match FAIL-001 slip after a few feet
match FAIL-001 A wave of dizziness hits you
match FAIL-001 Struck by vertigo
put climb break
matchwait

PASS-001:
pause
goto CLIMB-01

FAIL-001:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room E Gate
pause
gosub go_room 52
pause
goto CLIMB-01

CLIMB-01:
SAVE FAIL-01
match PASS-01 [Crossing, East Wall Battlements]
match FAIL-01 You must be standing
match FAIL-01 steepness is intimidating
match FAIL-01 can't seem to find purchase
match FAIL-01 find it hard going.
match FAIL-01 your footing is questionable
match FELL slip after a few feet
match FAIL-01 A wave of dizziness hits you
match FAIL-01 Struck by vertigo
put ClIMB wall
matchwait

PASS-01:
gosub move n
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room E Gate
pause
gosub go_room 45
pause
goto CLIMB-02

FAIL-01:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room 45
pause
goto CLIMB-02

CLIMB-02:
SAVE FAIL-02
match PASS-02 [Crossing, East Wall Battlements]
match FAIL-02 You must be standing
match FAIL-02 steepness is intimidating
match FAIL-02 can't seem to find purchase
match FAIL-02 find it hard going.
match FAIL-02 your footing is questionable
match FELL slip after a few feet
match FAIL-02 A wave of dizziness hits you
match FAIL-02 Struck by vertigo
put ClIMB wall
matchwait

PASS-02:
gosub move s
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room E Gate
pause
gosub go_room 44
pause
goto CLIMB-03

FAIL-02:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move s
goto CLIMB-03

CLIMB-03:
SAVE FAIL-03
match PASS-03 [Crossing, East Wall Battlements]
match FAIL-03 You must be standing
match FAIL-03 steepness is intimidating
match FAIL-03 can't seem to find purchase
match FAIL-03 find it hard going.
match FAIL-03 your footing is questionable
match FELL slip after a few feet
match FAIL-03 A wave of dizziness hits you
match FAIL-03 Struck by vertigo
put ClIMB wall
matchwait

PASS-03:
gosub move s
gosub move gO stair
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
goto CLIMB-04

FAIL-03:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move s
goto CLIMB-04

CLIMB-04:
SAVE FAIL-04
match PASS-04 [Crossing, East Gate Battlements]
match FAIL-04 You must be standing
match FAIL-04 steepness is intimidating
match FAIL-04 can't seem to find purchase
match FAIL-04 find it hard going.
match FAIL-04 your footing is questionable
match FELL slip after a few feet
match FAIL-04 A wave of dizziness hits you
match FAIL-04 Struck by vertigo
put ClIMB wall
matchwait

PASS-04:
pause
goto CLIMB-05

FAIL-04:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
gosub move gO stair
goto CLIMB-05

CLIMB-05:
SAVE FAIL-05
match PASS-05 [Eastern Tier, Outside Gate]
match FAIL-05 You must be standing
match FAIL-05 steepness is intimidating
match FAIL-05 can't seem to find purchase
match FAIL-05 find it hard going.
match FAIL-05 your footing is questionable
match FELL slip after a few feet
match FAIL-05 A wave of dizziness hits you
match FAIL-05 Struck by vertigo
put ClIMB embrasure
matchwait

PASS-05:
gosub move gO gate
gosub move gO stair
FAIL-05:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move n
goto CLIMB-06

CLIMB-06:
SAVE FAIL-06
match PASS-06 [Outside East Wall, Footpath]
match FAIL-06 You must be standing
match FAIL-06 steepness is intimidating
match FAIL-06 can't seem to find purchase
match FAIL-06 find it hard going.
match FAIL-06 your footing is questionable
match FELL slip after a few feet
match FAIL-06 A wave of dizziness hits you
match FAIL-06 Struck by vertigo
put ClIMB break
matchwait

PASS-06:
gosub move s
gosub move gO gate
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO stair
gosub move n
goto CLIMB-07

FAIL-06:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
pause
goto CLIMB-07

CLIMB-07:
SAVE FAIL-07
match PASS-07 [Outside East Wall, Footpath]
match FAIL-07 You must be standing
match FAIL-07 steepness is intimidating
match FAIL-07 can't seem to find purchase
match FAIL-07 find it hard going.
match FAIL-07 your footing is questionable
match FELL slip after a few feet
match FAIL-07 A wave of dizziness hits you
match FAIL-07 Struck by vertigo
put ClIMB embrasure
matchwait

PASS-07:
gosub move s
gosub move s
gosub move gO gate
gosub move w
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto TRAVEL-NE

FAIL-07:
gosub move s
gosub move gO stair
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto TRAVEL-NE

TRAVEL-NE:
gosub go_room 387

CLIMB-NE-1:
SAVE CLIMB-NE-1
MATCH PASS-NE-1 [Outside East Wall, Footpath]
MATCHRE FAIL-NE-1 You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going.|your footing is questionable|A wave of dizziness hits you|Struck by vertigo
MATCH FELL slip after a few feet
put CLIMB break
matchwait

PASS-NE-1:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-NE-2

FAIL-NE-1:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-NE-3

CLIMB-NE-2:
SAVE CLIMB-NE-2
MATCH PASS-NE-2 [Crossing, East Wall Battlements]
MATCHRE FAIL-NE-2 You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going.|your footing is questionable|A wave of dizziness hits you|Struck by vertigo
MATCH FELL slip after a few feet
put CLIMB wall
matchwait

PASS-NE-2:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-NE-3

FAIL-NE-2:
pause
gosub go_room ne gate
gosub go_room crossing
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room 387
goto CLIMB-NE-3

CLIMB-NE-3:
SAVE CLIMB-NE-3
MATCH PASS-NE-3 [Northeast Wilds, Outside Northeast Gate]
MATCHRE FAIL-NE-3 You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going.|your footing is questionable|A wave of dizziness hits you|Struck by vertigo
MATCH FELL slip after a few feet
put CLIMB embrasure
matchwait

PASS-NE-3:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-NE-4

FAIL-NE-3:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room ne gate
goto CLIMB-NE-4

CLIMB-NE-4:
SAVE CLIMB-NE-4
MATCH PASS-NE-4 [Crossing, Northeast Gate Battlements]
MATCHRE FAIL-NE-4 You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going.|your footing is questionable|A wave of dizziness hits you|Struck by vertigo
MATCH FELL slip after a few feet
put CLIMB wall
matchwait

PASS-NE-4:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-NE-5

FAIL-NE-4:
pause
gosub go_room crossing
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub go_room 386
goto CLIMB-NE-5

CLIMB-NE-5:
SAVE CLIMB-NE-5
MATCH PASS-NE-5 [Northeast Wilds, Outside Northeast Gate]
MATCHRE FAIL-NE-5 You must be standing|steepness is intimidating|can't seem to find purchase|find it hard going.|your footing is questionable|A wave of dizziness hits you|Struck by vertigo
MATCH FELL slip after a few feet
put CLIMB embrasure
matchwait

PASS-NE-5:
pause
gosub go_room crossing
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto TRAVEL-08

FAIL-NE-5:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto TRAVEL-08

TRAVEL-08:
gosub go_room 399
pause

CLIMB-08:
SAVE FAIL-08
match PASS-08 [Mycthengelde, Flatlands]
match FAIL-08 You must be standing
match FAIL-08 steepness is intimidating
match FAIL-08 can't seem to find purchase
match FAIL-08 find it hard going.
match FAIL-08 your footing is questionable
match FELL slip after a few feet
match FAIL-08 A wave of dizziness hits you
match FAIL-08 Struck by vertigo
put ClIMB embrasure
matchwait

PASS-08:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-09

FAIL-08:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move n
gosub move go stair
gosub move go gate
gosub move nw
goto CLIMB-09

CLIMB-09:
SAVE FAIL-09
match PASS-09 [Crossing, West Wall Battlements]
match FAIL-09 You must be standing
match FAIL-09 steepness is intimidating
match FAIL-09 can't seem to find purchase
match FAIL-09 find it hard going.
match FAIL-09 your footing is questionable
match FELL slip after a few feet
match FAIL-09 A wave of dizziness hits you
match FAIL-09 Struck by vertigo
put ClIMB wall
matchwait

PASS-09:
gosub move n
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-10

FAIL-09:
gosub move se
gosub move gO gate
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO stair
goto CLIMB-10

CLIMB-10:
SAVE FAIL-10
match PASS-10 [Mycthengelde, Flatlands]
match FAIL-10 You must be standing
match FAIL-10 steepness is intimidating
match FAIL-10 can't seem to find purchase
match FAIL-10 find it hard going.
match FAIL-10 your footing is questionable
match FELL slip after a few feet
match FAIL-10 A wave of dizziness hits you
match FAIL-10 Struck by vertigo
put ClIMB embrasure
matchwait

PASS-10:
gosub move gO gate
gosub move gO stair
FAIL-10:
gosub move e
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-11

CLIMB-11:
SAVE FAIL-11
match PASS-11 [Northwall Trail, Wooded Grove]
match FAIL-11 You must be standing
match FAIL-11 steepness is intimidating
match FAIL-11 can't seem to find purchase
match FAIL-11 find it hard going.
match FAIL-11 your footing is questionable
match FELL slip after a few feet
match FAIL-11 A wave of dizziness hits you
match FAIL-11 Struck by vertigo
put ClIMB break
matchwait

PASS-11:
gosub move s
gosub move gO gate
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO stair
gosub move e
goto CLIMB-12

FAIL-11:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-12

CLIMB-12:
SAVE FAIL-12
match PASS-12 [Northwall Trail, Wooded Grove]
match FAIL-12 You must be standing
match FAIL-12 steepness is intimidating
match FAIL-12 can't seem to find purchase
match FAIL-12 find it hard going.
match FAIL-12 your footing is questionable
match FELL slip after a few feet
match FAIL-12 A wave of dizziness hits you
match FAIL-12 Struck by vertigo
put ClIMB embrasure
matchwait

PASS-12:
pause
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
goto CLIMB-13

FAIL-12:
gosub move w
gosub move gO stair
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
gosub move gO trail
gosub move ne
goto CLIMB-13

CLIMB-13:
SAVE FAIL-13
match PASS-13 [Crossing, North Wall Battlements]
match FAIL-13 You must be standing
match FAIL-13 steepness is intimidating
match FAIL-13 can't seem to find purchase
match FAIL-13 find it hard going.
match FAIL-13 your footing is questionable
match FELL slip after a few feet
match FAIL-13 A wave of dizziness hits you
match FAIL-13 Struck by vertigo
put ClIMB wall
matchwait

PASS-13:
gosub move w
gosub move gO stair
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
gosub move gO trail
goto CLIMB-14

FAIL-13:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move sw
goto CLIMB-14

CLIMB-14:
SAVE FAIL-14
match PASS-14 [Crossing, North Wall Battlements]
match FAIL-14 You must be standing
match FAIL-14 steepness is intimidating
match FAIL-14 can't seem to find purchase
match FAIL-14 find it hard going.
match FAIL-14 your footing is questionable
match FELL slip after a few feet
match FAIL-14 A wave of dizziness hits you
match FAIL-14 Struck by vertigo
put ClIMB wall
matchwait

PASS-14:
gosub move w
gosub move gO stair
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
goto CLIMB-15

FAIL-14:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move s
goto CLIMB-15

CLIMB-15:
SAVE FAIL-15
match PASS-15 [Crossing, West Gate Battlements]
match FAIL-15 You must be standing
match FAIL-15 steepness is intimidating
match FAIL-15 can't seem to find purchase
match FAIL-15 find it hard going.
match FAIL-15 your footing is questionable
match FELL slip after a few feet
match FAIL-15 A wave of dizziness hits you
match FAIL-15 Struck by vertigo
put ClIMB wall
matchwait

PASS-15:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO stair
goto TRAVEL-15

FAIL-15:
#if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
if (%climb_done = 1) then goto doneclimbing
gosub move gO gate
goto TRAVEL-15

TRAVEL-15:
goto MORECLIMB

MORECLIMB:
gosub move e
pause 2
goto start

FELL:
pause
match STOOD You stand
match STOOD You are already standing
match FELL cannot manage to stand.
match FELL The weight of all your possessions
match FELL ...wait
put StAND
matchwait

STOOD:
goto %s

QUIT:
goto doneclimbing

PERCIT:
if ($Attunement.LearningRate < 32) then
{
	put perc
	pause
}
return

doneclimbing:
pause
if ("$righthandnoun" = "rope" || "$lefthandnoun" == "rope") then put coil my rope
if ("$righthand" != "Empty") then put stow right
if ("$lefthand" != "Empty") then put stow left
gosub map_check
pause
#put #script abort enc
put #parse Script Done
