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
cave_70:
cave_14:
  gosub go_room 132
cave_132:
  gosub PROS 1
  gosub go_room 133
cave_133:
  gosub PROS 1
  gosub go_room 134
cave_134:
  gosub PROS 1
  gosub go_room 135
cave_135:
  gosub PROS 1
  gosub go_room 137
cave_137:
  gosub PROS 1
  gosub go_room 138
cave_138:
  gosub PROS 1
  gosub go_room 139
cave_139:
  pause
  gosub PROS 1
  gosub go_room 140
cave_140:
  gosub PROS 1
  gosub go_room 154
cave_154:
  gosub PROS 1
  gosub go_room 155
cave_155:
  gosub PROS 1
  gosub go_room 156
cave_156:
  gosub PROS 1
  gosub go_room 157
cave_157:
  gosub PROS 1
  gosub go_room 158
cave_158:
  gosub PROS 1
  gosub go_room 159
cave_159:
  gosub PROS 1
  gosub go_room 161
cave_161:
  gosub PROS 1
  gosub go_room 160
cave_160:
  gosub PROS 1
  gosub go_room 141
cave_141:
  gosub PROS 1
  gosub go_room 145
cave_145:
  gosub PROS 1
  gosub go_room 146
cave_146:
  gosub PROS 1
  gosub go_room 147
cave_147:
  gosub PROS 1
  gosub go_room 148
cave_148:
  gosub PROS 1
  gosub go_room 149
cave_149:
  gosub PROS 1
  gosub go_room 150
cave_150:
  gosub PROS 1
  gosub go_room 151
cave_151:
  gosub PROS 1
  gosub go_room 152
cave_152:
  gosub PROS 1
  gosub go_room 153
cave_153:
  gosub PROS 1
  gosub go_room 142
cave_142:
  gosub PROS 1
  gosub go_room 143
cave_143:
  gosub PROS 1
  gosub go_room 14

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
	gosub go_room 2
	pause
	put #parse Script Done
	exit

include includes.cmd
