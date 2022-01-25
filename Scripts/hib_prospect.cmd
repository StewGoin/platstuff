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
  gosub PREP_CYCLIC $spell_prospect $spell_prospectmana

action (log) put #echo >Log DimGray $2 found in room $roomid when ^(You are certain that ($mineIgnore) can be mined here\.)	
action (log) put #echo >Log PaleGreen $2 found in room $roomid when ^(You are certain that ($mineMassivePlus) can be mined here\.)	
action (log) put #echo >Log Lime $2 found in room $roomid when ^(You are certain that ($mineHugePlus) can be mined here\.)	
action (log) put #echo >Log Aqua $2 found in room $roomid when ^(You are certain that ($mineMediumPlus) can be mined here\.)	
action (log) put #echo >Log Red $2 found in room $roomid when ^(You are certain that ($mineAll) can be mined here\.)	
	
### goto current room in the Map123_Himineldar_Shel.xml map
goto cave_$roomid

MAIN:
cave_24:
  gosub go_room 203
	goto cave_203
cave_198:
  gosub go_room 203
	goto cave_203
cave_199:
  gosub go_room 203
	goto cave_203
cave_200:
  gosub go_room 203
	goto cave_203
cave_201:
  gosub go_room 203
	goto cave_203
cave_202:
  gosub go_room 203
	goto cave_203
cave_203:
	pause 6
  gosub move se
	pause
	if $roomid = 203 then goto cave_203
cave_204:
  pause
	put kneel
	pause
  gosub move go dark hole
	pause
	if $roomid = 204 then goto cave_204
cave_205:
cave_206:
cave_207:
cave_208:
cave_209:
cave_210:
cave_211:
cave_212:
cave_213:
cave_214:
cave_215:
cave_216:
cave_217:
cave_218:
cave_219:
cave_220:
cave_221:
### Swimming Section
cave_222:
	gosub go_room 223
	if $roomid = 223 then goto cave_223
	else goto cave_25
cave_223:
  gosub PROS 1
  gosub go_room 224
cave_224:
  gosub PROS 1
  gosub go_room 225
cave_225:
  gosub PROS 1
  gosub go_room 226
cave_226:
  gosub PROS 1
  gosub go_room 227
### Done Swimming
cave_227:
  gosub PROS 1
  gosub go_room 228
### Retch Fiends
cave_228:
  gosub PROS 1
  gosub go_room 229
cave_229:
  gosub PROS 1
  gosub go_room 230
cave_230:
  gosub PROS 1
  gosub go_room 231
cave_231:
  gosub PROS 1
  gosub go_room 232
cave_232:
  gosub PROS 1
  gosub go_room 233
cave_233:
  gosub PROS 1
  gosub go_room 236
cave_234:
  gosub go_room 236
	goto cave_236
cave_235:
  gosub go_room 236
	goto cave_236
cave_236:
  gosub PROS 1
  gosub go_room 237
cave_237:
  gosub PROS 1
  gosub go_room 238
cave_238:
  gosub PROS 1
  gosub go_room 239
cave_239:
  gosub PROS 1
  gosub go_room 240
cave_240:
  gosub PROS 1
  gosub go_room 241
cave_241:
  gosub PROS 1
  gosub go_room 242
cave_242:
  gosub PROS 1
  gosub go_room 243
cave_243:
  gosub PROS 1
  gosub go_room 244
cave_244:
  gosub PROS 1
  gosub go_room 245
cave_245:
  gosub PROS 1
  gosub go_room 246
cave_246:
  gosub PROS 1

	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1)) then goto DONE
	else gosub go_room 223
	goto cave_223


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
	gosub go_room 246
	gosub go_room 32
	pause
  put rel cyclic
	put #parse Script Done
	exit
	
include includes.cmd
