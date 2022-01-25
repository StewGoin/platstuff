# Clean, genie-ize, subs and include out

START:

if matchre("%1", "sc") then
{
	var walkOnly 1
	var scan 1
}
else
{
	var scan 0
	var walkOnly 0
}

if matchre("%1", "ri") then
{
	var rip 1
	var scan 0
}
else
{
	var rip 0
}

include var_mine.cmd

### Bards - Sings SIRE quietly to keep critters away and populate nearby rooms for HUNT.
###
### Non-Bards need to edit script to do PP as a separate section, or just use the built-in PP variables for automapper. 
### Illimin's script could be useful for guidance there.
###

PROSPECT_CYCLIC:
  put rel all
  put #var cam_leeched 1
  put #var cam_slipped 1
  gosub PREP_CYCLIC ALBREDA BALM 20

#unused for now	covellite|nickel|pewter|tin|zinc
action (log) put #echo >Log DimGray $2 found in room $roomid when ^(You are certain that ($mineIgnore) can be mined here\.)	
action (log) put #echo >Log PaleGreen $2 found in room $roomid when ^(You are certain that ($mineMassivePlus) can be mined here\.)	
action (log) put #echo >Log Lime $2 found in room $roomid when ^(You are certain that ($mineHugePlus) can be mined here\.)	
action (log) put #echo >Log Aqua $2 found in room $roomid when ^(You are certain that ($mineMediumPlus) can be mined here\.)	
action (log) put #echo >Log Red $2 found in room $roomid when ^(You are certain that ($mineAll) can be mined here\.)	
	
### 1 = HUNT, 0 = skip HUNTing
var hunting 0
if %hunting = 1 then gosub hunt
pause

### goto current room in the Map68a_Ice_Caves.xml map
goto cave_$roomid

MAIN:
SHARD_31:
  gosub go_room 32
SHARD_32:
  gosub PROS 1
  gosub go_room 33
SHARD_33:
  gosub PROS 1
  gosub go_room 34
SHARD_34:
  gosub PROS 1
  gosub go_room 35
SHARD_35:
  gosub PROS 1
  gosub go_room 36
SHARD_36:
  gosub PROS 1
#	put #script abort enc;stop sing
	pause
  gosub go_room 40
  goto SHARD_40
SHARD_37:
  pause
  gosub go_room 40
  goto SHARD_40
SHARD_38:
  pause
  gosub go_room 40
  goto SHARD_40
SHARD_39:
  pause
  gosub go_room 40
  goto SHARD_40
SHARD_40:
  pause
#	put .enc eye 20 41 loud
#	put .enc pyre 20 25 quiet
	pause 3
  gosub PROS 1
  gosub go_room 41
SHARD_41:
  pause
  gosub PROS 1
  gosub go_room 42
SHARD_42:
  gosub PROS 1
  gosub go_room 43
SHARD_43:
  gosub PROS 1
  gosub go_room 44
SHARD_44:
  gosub PROS 1
  gosub go_room 45
SHARD_45:
  gosub PROS 1
  gosub go_room 46
SHARD_46:
  gosub PROS 1
  gosub go_room 47
SHARD_47:
  gosub PROS 1
  gosub go_room 16

SHARD_16:
  gosub PROS 1
  gosub go_room 27
SHARD_27:
  gosub PROS 1
  gosub go_room 12
SHARD_12:
  gosub PROS 1
  gosub go_room 11
SHARD_11:
  gosub PROS 1
  gosub go_room 22
SHARD_22:
  gosub PROS 1
  gosub go_room 23
SHARD_23:
  gosub PROS 1
  gosub go_room 24
SHARD_24:
  gosub PROS 1
  gosub go_room 10
SHARD_10:
  gosub PROS 1
  gosub go_room 28
SHARD_28:
  gosub PROS 1
  gosub go_room 9
SHARD_9:
  gosub PROS 1
  gosub go_room 8
SHARD_8:
  gosub PROS 1
  gosub go_room 26
SHARD_26:
  gosub PROS 1
  gosub go_room 15
SHARD_15:
  gosub PROS 1
  gosub go_room 20
SHARD_20:
  gosub PROS 1
  gosub go_room 21
SHARD_21:
  gosub PROS 1
  gosub go_room 14
SHARD_14:
  gosub PROS 1
  gosub go_room 17
SHARD_17:
  gosub PROS 1
  gosub go_room 18
SHARD_18:
  gosub PROS 1
  gosub go_room 19
SHARD_19:
  gosub PROS 1
  gosub go_room 25
SHARD_25:
  gosub PROS 1
  gosub go_room 13
SHARD_13:
  gosub PROS 1
  gosub go_room 7

#if ($Outdoorsmanship.LearningRate >= 32 ) then goto DONE_1

SHARD_7:
  gosub PROS 2
#	put #script abort enc;stop sing
	pause
  gosub go_room 6
SHARD_6:
	pause
#	put .enc eye 20 41 loud
#	put .enc pyre 20 25 quiet
#	pause 3
  gosub PROS 2
  gosub go_room 5
SHARD_5:
  gosub PROS 2
  gosub go_room 4
SHARD_4:
  gosub PROS 2
  gosub go_room 3
SHARD_3:
  gosub PROS 2
  gosub go_room 1
SHARD_2:
  gosub PROS 2
  gosub go_room 29
	if %rip = 1 then goto DONE_1
	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1))  then goto DONE_1
  gosub go_room 214
  goto MAIN

	if %rip = 1 then goto DONE_1
	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1))  then goto DONE_1
	else goto MAIN

PROS:
  if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
  var SIDE $1
	if %rip = 1 then goto PROS_1
  if (($Outdoorsmanship.LearningRate >= 32 ) && (%scan = 0)) then goto DONE_%SIDE
PROS_1:
  if ("$roomplayers"="") then
  {
	if %rip = 1 then match MINEIT ^You are certain that ($mineIgnore) can be mined here\.
	matchre MINEIT ^You are certain that ($mineMediumPlus|$mineMassivePlus|$mineHugePlus) can be mined here\.
	matchre MINEIT_CAREFUL ^You are certain that ($mineAll) can be mined here\.
	matchre MINEIT ^Miners stand ready to trade resources in for deeds|deed resources
	matchre PROS_1 ^\.\.\.wait|you may only type
	matchre PROSPECTED ^Roundtime
	put pros
	matchwait 2
	goto PROS_1
  }

MINEIT_CAREFUL:
#	if %walkOnly = 1 then return
	action (log) off
  if matchre("$1", "$mineRip") then put .mine 1 2
	else put .mine
	waitfor Mining Done
	action (log) on
	return
		
MINEIT:
	if %walkOnly = 1 then return
	action (log) off
	if %rip = 1 then put .mine 1 2
	else put .mine
	waitfor Mining Done
	action (log) on
	return
	
PROSPECTED:
#  if (%t > 80) then goto hunt
#  else return
return
  
hunt:
	pause
	matchre hunt ^\.\.\.wait|you may only type
	matchre no_hunting You find yourself unable to hunt
	matchre hunted Roundtime
	send hunt
	matchwait 3
	goto hunt

hunted:
	timer clear
	timer start
	return

no_hunting:
	return

DONE_1:
	pause
	gosub go_room 31
	pause
	put #parse Script Done
	exit

DONE_2:
	pause
	gosub go_room 29
	gosub go_room 214
	pause
	put #parse Script Done
	exit

include includes.cmd
