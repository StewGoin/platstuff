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
  gosub PREP_CYCLIC $spell_prospect $spell_prospectmana

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
cave_1:
cave_2:
  gosub go_room 31
cave_31:
  gosub go_room 32
cave_32:
  gosub PROS 1
  gosub go_room 33
cave_33:
  gosub PROS 1
  gosub go_room 36
cave_36:
  gosub PROS 1
  gosub go_room 37
cave_37:
  gosub PROS 1
  gosub go_room 38
cave_38:
  gosub PROS 1
  gosub go_room 39
cave_39:
  pause
  gosub PROS 1
  gosub go_room 41
cave_41:
  gosub PROS 1
  gosub go_room 42
cave_42:
  gosub PROS 1
  gosub go_room 43
cave_43:
  gosub PROS 1
  gosub go_room 44
cave_44:
  gosub PROS 1
  gosub go_room 45
cave_45:
  gosub PROS 1
  gosub go_room 46
cave_46:
  gosub PROS 1
  gosub go_room 47
cave_47:
  gosub PROS 1
  gosub go_room 48
cave_49:
  gosub PROS 1
  gosub go_room 29
cave_29:
  gosub PROS 1
  gosub go_room 28
cave_28:
  gosub PROS 1
  gosub go_room 27
cave_27:
  gosub PROS 1
  gosub go_room 26
cave_26:
  gosub PROS 1
  gosub go_room 2

	if %rip = 1 then goto DONE
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
	gosub go_room 1
	pause
	put #parse Script Done
	exit

include includes.cmd
