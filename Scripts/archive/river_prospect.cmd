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
cave_135:
  gosub go_room 44
  goto cave_44
cave_2:
cave_36:
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
cave_48:
  gosub PROS 1
  gosub go_room 49
cave_49:
  gosub PROS 1
  gosub go_room 50
cave_50:
  pause
  gosub PROS 1
  gosub go_room 51
cave_51:
  gosub PROS 1
  gosub go_room 52
cave_52:
  gosub PROS 1
  gosub go_room 53
cave_53:
  gosub PROS 1
  gosub go_room 54
cave_54:
  gosub PROS 1
  gosub go_room 55
cave_55:
  gosub PROS 1
  gosub go_room 56
cave_56:
  gosub PROS 1
  gosub go_room 57
cave_57:
  gosub PROS 1
  gosub go_room 58
cave_58:
  gosub PROS 1
  gosub go_room 59
cave_59:
  gosub PROS 1
  gosub go_room 60
cave_60:
  put ret;ret
  pause
  put ret;ret
  put kneel
  put go passage
  waitfor Obvious exits: north.
cave_61:
  put stand
  gosub PROS 1
  gosub go_room 62
cave_62:
  gosub PROS 1
  gosub go_room 63
cave_63:
  gosub PROS 1
  gosub go_room 64
cave_64:
  gosub PROS 1
  gosub go_room 65
cave_65:
  gosub PROS 1
  gosub go_room 68
cave_68:
  gosub PROS 1
  gosub go_room 67
cave_67:
  gosub PROS 1
  gosub go_room 66
cave_66:
  gosub PROS 1
  gosub go_room 70
cave_70:
  gosub PROS 1
  gosub go_room 71
cave_71:
  gosub PROS 1
  gosub go_room 69
cave_69:
  gosub PROS 1
  gosub go_room 72
cave_72:
  gosub PROS 1
  gosub go_room 73
cave_73:
  gosub PROS 1
  gosub go_room 33
  gosub go_room 135


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
	gosub go_room 135
	pause
	put #parse Script Done
	exit

include includes.cmd

