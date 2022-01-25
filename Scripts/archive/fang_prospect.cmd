# Cleanup and stuff

#debug 5
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
  gosub PREP_CYCLIC $spell_prospect $spell_prospectmana creature

action (log) put #echo >Log DimGray $2 found in room $roomid when ^(You are certain that ($mineIgnore) can be mined here\.)	
action (log) put #echo >Log PaleGreen $2 found in room $roomid when ^(You are certain that ($mineMassivePlus) can be mined here\.)	
action (log) put #echo >Log Lime $2 found in room $roomid when ^(You are certain that ($mineHugePlus) can be mined here\.)	
action (log) put #echo >Log Aqua $2 found in room $roomid when ^(You are certain that ($mineMediumPlus) can be mined here\.)	
action (log) put #echo >Log Red $2 found in room $roomid when ^(You are certain that ($mineAll) can be mined here\.)	
	
### goto current room in the Map123_Himineldar_Shel.xml map
goto cave_$roomid

MAIN:
cave_85:
cave_63:
  gosub go_room 64
	goto cave_64
cave_64:
  gosub PROS 1
  gosub go_room 65
cave_65:
  gosub PROS 1
  gosub go_room 66
cave_66:
  gosub PROS 1
  gosub go_room 67
cave_68:
  gosub PROS 1
  gosub go_room 69
cave_69:
  gosub PROS 1
  gosub go_room 70
cave_70:
  gosub PROS 1
  gosub go_room 71
cave_71:
  gosub PROS 1
  gosub go_room 72
cave_72:
  gosub PROS 1
  gosub go_room 73
cave_73:
  gosub PROS 1
  gosub go_room 74
cave_74:
  gosub PROS 1
  gosub go_room 75
cave_75:
  gosub PROS 1
  gosub go_room 79
cave_79:
  gosub PROS 1
  gosub go_room 80
cave_80:
  gosub PROS 1
  gosub go_room 81
cave_82:
  gosub PROS 1
  gosub go_room 83
cave_83:
  gosub PROS 1
  gosub go_room 84
cave_84:
  gosub PROS 1
  gosub go_room 91
cave_91:
  gosub PROS 1
  gosub go_room 92
cave_92:
  gosub PROS 1
  gosub go_room 93
cave_93:
  gosub PROS 1
  gosub go_room 94
cave_95:
  gosub PROS 1
  gosub go_room 95


	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1)) then goto DONE
	else gosub go_room 63
	goto cave_63


PROS:
  if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
  var SIDE $1
  if (($Outdoorsmanship.LearningRate >= 32 ) && (%scan = 0)) then goto DONE
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

DONE:
	pause
	gosub go_room 85
	pause
  put rel cyclic
	put #parse Script Done
	exit
	
include includes.cmd

