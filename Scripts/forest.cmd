# Clean, genie-ize, subs and include out
# debug 5

var instrument cowbell
var style masterful
var song concerto
var playing 0
#if $Performance.LearningRate < 33 then var playinst 1
#else var playinst 0
var playinst 0

action var playing 1 when ^You begin a|^You continue playing on yourself
action var playing 0 when ^You finish playing a|^You cannot use the .* while in combat!

START:
put .var_lumber
gosub get my $shield
put wear my $shield
put stance set $shieldstance
#if %playinst = 1 then
#{
#  gosub get my %instrument
#  put swap
#}

if matchre("%1", "sc") then
{
  var walkOnly 1
  var scan 1
}
else
{
  var scan 0
  var walkOnly 1
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

LUMBER_LOCATION:

if "$zoneid" = "114" then var LOCATION AIN
if "$zoneid" = "13" then var LOCATION DIRGE
if "$zoneid" = "10" then var LOCATION STONE
if "$zoneid" = "150" then var LOCATION FANG
if "$zoneid" = "32" then var LOCATION RIVER
if "$zoneid" = "33a" then var LOCATION RIVER2THEREN
if "$zoneid" = "34" then var LOCATION ROSS
if "$zoneid" = "65" then VAR LOCATION GONDOLA
if "$zoneid" = "66" then var LOCATION SHARDN
if "$zoneid" = "68" then var LOCATION SHARD_SOUTH
if "$zoneid" = "69" then var LOCATION SHARDW
if "$zoneid" = "123" then var LOCATION HAWK
if "$zoneid" = "40" then var LOCATION THEREN
if "$zoneid" = "41" then var LOCATION RAUDERS
if "$zoneid" = "4" then var LOCATION CROSSW
if "$zoneid" = "6" then var LOCATION CROSSN
if "$zoneid" = "7" then var LOCATION NTR



### Bards - Sings SIRE quietly to keep critters away and populate nearby rooms for HUNT.
###
### Non-Bards need to edit script to do PP as a separate section, or just use the built-in PP variables for automapper.
### Illimin's script could be useful for guidance there.
###

#unused for now	covellite|nickel|pewter|tin|zinc
## action (log) put #echo >Log DimGray $2 found in room $roomid when ^(You are certain that ($mineIgnore) can be mined here\.)
## action (log) put #echo >Log PaleGreen $2 found in room $roomid when ^(You are certain that ($mineMassivePlus) can be mined here\.)
## action (log) put #echo >Log Lime $2 found in room $roomid when ^(You are certain that ($mineHugePlus) can be mined here\.)
action (log) put #echo >Log Red $2 found in room $roomid when ^(You are certain that ($lumberAll) trees can be harvested here\.)
action (log) put #echo >Log Aqua $roomid not valid when (^You scan the area and determine that it is not suitable for lumberjacking\.|^You feel certain this area contains no trees to lumberjack\.)

### 1 = HUNT, 0 = skip HUNTing
var hunting 0
if %hunting = 1 then gosub hunt
pause

goto %LOCATION_$roomid

END_CHECK:
	if %rip = 1 then goto DONE
	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1))  then goto DONE_1
	else goto %LOCATION

WATCH:
  #if $almanactime <= $gametime then
  #{
  #  put stop play
  #  #if (%playinst = 1) then gosub put my %instrument in my cloak
  #  gosub ALMANAC_CHECK
  #}
  #gosub TARANTULA_CHECK
  #if ($cam_slipped = 1 || $cam_leeched = 1) then gosub CAMB_CHARGE
  if (%playinst = 1 && $Performance.LearningRate >= 33) then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
    var playinst 0
  }
  if (%playinst = 1 && %playing = 0) then
  {
    pause 0.5
    put play %song %style on my %instrument
  }
  var SIDE $1
	if %rip = 1 then goto WATCH_1
  if (($Outdoorsmanship.LearningRate >= 32 ) && (%scan = 0)) then goto DONE_%SIDE
WATCH_1:
  if ("$roomplayers"="") then
  {
	matchre LUMBERIT_CAREFUL ^You are certain that ($lumberAll) trees can be harvested here\.
	matchre LUMBERIT ^Loggers stand ready to trade wood in for deeds|deed resources
	matchre WATCH_1 ^\.\.\.wait|you may only type
	matchre WATCHED ^Roundtime
	put watch forest
	matchwait 2
	goto WATCH_1
  }
  else goto WATCHED

LUMBERIT_CAREFUL:
  #if %walkOnly = 1 then return
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	action (log) off
  #if matchre("$1", "$mineRip") then put .mine 1 2
  put wield right my mirror.axe
	put .lumberjacking
	waitfor Chopping Done
	action (log) on
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
	return

LUMBERIT:
	if %walkOnly = 1 then return
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	action (log) off
	#if %rip = 1 then put .mine 1 2
	#else put .mine
  put wield right my mirror.axe
  put .lumberjacking
	waitfor Chopping Done
	action (log) on
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
	return

RIPIT:
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
  action (log) off
  put .mine 1 2
  waitfor Mining Done
  action (log) on
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
  return

WATCHED:
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
  put rel cyclic
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	pause
  if "$zoneid" = "42" then gosub go_room 116
  if "$zoneid" = "114" then gosub go_room 17
  if "$zoneid" = "13" then gosub go_room 2
  if "$zoneid" = "10" then gosub go_room 1
  if "$zoneid" = "150" then gosub go_room 7
  if "$zoneid" = "33" then gosub go_room 135
  if "$zoneid" = "68" then gosub go_room 2
  if "$zoneid" = "66" then gosub go_room 39
  # Hawk / Hib
  if "$zoneid" = "123" then
  {
    gosub go_room 246
    gosub go_room 32
  }
	pause
	put #parse Script Done
	exit

WATCH_CYCLIC:
  put rel cyclic
  put #var cam_leeched 1
  put #var cam_slipped 1
  gosub PREP_CYCLIC $1 $2
  return

include includes.cmd

#THEREN:
#exit


SHARDW:
  if $roomid != 10 then gosub go_room 10
SHARDW_10:
  put #echo >Log Lime "Forest Scan of Shard West"
  gosub go_room 24
SHARDW_24:
  gosub WATCH 1
  gosub go_room 25
SHARDW_25:
  gosub WATCH 1
  gosub go_room 26
SHARDW_26:
  gosub WATCH 1
  gosub go_room 27
SHARDW_27:
  gosub WATCH 1
  gosub go_room 28
SHARDW_28:
  gosub WATCH 1
  gosub go_room 29
SHARDW_29:
  gosub WATCH 1
  gosub go_room 30
SHARDW_30:
  gosub WATCH 1
  gosub go_room 32
SHARDW_32:
  gosub WATCH 1
  gosub go_room 33
SHARDW_33:
  gosub WATCH 1
  gosub go_room 34
SHARDW_34:
  gosub WATCH 1
  gosub go_room 35
SHARDW_35:
  gosub WATCH 1
  gosub go_room 36
SHARDW_36:
  gosub WATCH 1
  gosub go_room 37
SHARDW_37:
  gosub WATCH 1
  gosub go_room 1
  goto LUMBER_LOCATION
#Avoiding Telga Oreks for now

SHARDW_CHECK:
  goto END_CHECK

SHARDN:
SHARDN_44:
SHARDN_65:
  if $roomid != 115 then gosub go_room 115
SHARDN_115:
  put #echo >Log Lime "Forest Scan of Shard North"
  gosub WATCH 1
  gosub go_room 116
SHARDN_116:
  gosub WATCH 1
  gosub go_room 117
SHARDN_117:
  gosub WATCH 1
  gosub go_room 118
SHARDN_118:
  gosub WATCH 1
  gosub go_room 119
SHARDN_119:
  gosub WATCH 1
  gosub go_room 120
SHARDN_120:
  gosub WATCH 1
  gosub go_room 121
SHARDN_121:
  gosub WATCH 1
  gosub go_room 141
SHARDN_141:
  gosub WATCH 1
  gosub go_room 196
SHARDN_196:
  gosub WATCH 1
  gosub go_room 122
SHARDN_122:
  gosub WATCH 1
  gosub go_room 140
SHARDN_140:
  gosub WATCH 1
  gosub go_room 123
SHARDN_123:
  gosub WATCH 1
  gosub go_room 124
SHARDN_124:
  gosub WATCH 1
  gosub go_room 131
SHARDN_131:
  gosub WATCH 1
  gosub go_room 151
SHARDN_151:
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  #gosub WATCH 1
  gosub go_room 645
SHARDN_645:
  gosub WATCH 1
  gosub go_room 653
SHARDN_653:
  gosub WATCH 1
  gosub go_room 654
SHARDN_654:
  gosub WATCH 1
  gosub go_room 651
SHARDN_651:
  gosub WATCH 1
  gosub go_room 652
SHARDN_652:
  gosub WATCH 1
  gosub go_room undergondola
  goto LUMBER_LOCATION

SHARDN_163:
  put rel cyclic
  gosub go_room 14
SHARDN_14:
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  gosub WATCH 1
  gosub go_room 15
SHARDN_15:
  gosub WATCH 1
  gosub go_room 16
SHARDN_16:
  gosub WATCH 1
  gosub go_room 17
SHARDN_17:
  gosub WATCH 1
  gosub go_room 18
SHARDN_18:
  gosub WATCH 1
  goto END_CHECK

GONDOLA:
GONDOLA_2:
  put #echo >Log Lime "Forest Scan of Undergondola"
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  gosub go_room 3
GONDOLA_3:
  gosub WATCH 1
  gosub go_room 4
GONDOLA_4:
  gosub WATCH 1
  gosub go_room 5
GONDOLA_5:
  gosub WATCH 1
  gosub go_room 6
GONDOLA_6:
  gosub WATCH 1
  gosub go_room 7
GONDOLA_7:
  gosub WATCH 1
  gosub go_room 8
GONDOLA_8:
  gosub WATCH 1
  gosub go_room 10
GONDOLA_10:
  gosub WATCH 1
  gosub go_room 11
GONDOLA_11:
  gosub WATCH 1
  gosub go_room 12
GONDOLA_12:
  gosub WATCH 1
  gosub go_room 13
GONDOLA_13:
  gosub WATCH 1
  gosub go_room 14
GONDOLA_14:
  gosub WATCH 1
  gosub go_room 9
GONDOLA_9:
  gosub WATCH 1
  gosub go_room 15
GONDOLA_15:
  gosub WATCH 1
  gosub go_room 16
GONDOLA_16:
  gosub WATCH 1
  gosub go_room 17
GONDOLA_17:
  gosub WATCH 1
  gosub go_room 18
GONDOLA_18:
  gosub WATCH 1
  gosub go_room 19
GONDOLA_19:
  gosub WATCH 1
  gosub go_room 20
GONDOLA_20:
  gosub WATCH 1
  gosub go_room 21
GONDOLA_21:
  gosub WATCH 1
  gosub go_room 22
GONDOLA_22:
  gosub WATCH 1
  gosub go_room Shard
  goto LUMBER_LOCATION


NTR:
  if $roomid != 318 then gosub go_room 318
NTR_318:
  put #echo >Log Lime "Forest Scan of NTR"
  gosub WATCH 1
  gosub go_room 319
NTR_319:
  gosub WATCH 1
  gosub go_room 325
NTR_325:
  gosub WATCH 1
  gosub go_room 333
NTR_333:
  gosub WATCH 1
  gosub go_room 334
NTR_334:
  gosub WATCH 1
  gosub go_room 335
NTR_335:
  gosub WATCH 1
  gosub go_room 336
NTR_336:
  gosub WATCH 1
  gosub go_room 337
NTR_337:
  gosub WATCH 1
  gosub go_room 338
NTR_338:
  gosub WATCH 1
  gosub go_room 357
NTR_357:
  gosub WATCH 1
  gosub go_room 358
NTR_358:
  gosub WATCH 1
  gosub go_room 359
NTR_359:
  gosub WATCH 1
  gosub go_room 360
NTR_360:
  gosub WATCH 1
  gosub go_room 365
NTR_365:
  gosub WATCH 1
  gosub go_room 366
NTR_366:
  gosub WATCH 1
  gosub go_room 367
NTR_367:
  gosub WATCH 1
  gosub go_room 368
NTR_368:
  gosub WATCH 1
  gosub go_room 369
NTR_369:
  gosub WATCH 1
  gosub go_room 370
NTR_370:
  gosub WATCH 1
  gosub go_room 376
NTR_376:
  gosub WATCH 1
  gosub go_room 377
NTR_377:
  gosub WATCH 1
  gosub go_room 379
NTR_379:
  gosub WATCH 1
  gosub go_room 380
NTR_380:
  gosub WATCH 1
  gosub go_room 381
NTR_381:
  gosub WATCH 1
  gosub go_room 382
NTR_382:
  gosub WATCH 1
  gosub go_room 383
NTR_383:
  gosub WATCH 1
  gosub go_room 384
NTR_384:
  gosub WATCH 1
  gosub go_room 385
NTR_385:
  gosub WATCH 1
  gosub go_room 146
NTR_146:
  gosub WATCH 1
  gosub go_room 318
NTR_CHECK:
  goto END_CHECK

CROSSN:
  if $roomid != 22 then gosub go_room 22
CROSSN_22:
  put #echo >Log Lime "Forest Scan of Crossing North Gate"
  gosub WATCH 1
  gosub go_room 1
CROSSN_1:
  gosub WATCH 1
  gosub go_room 2
CROSSW_2:
  gosub WATCH 1
  gosub go_room 22
CROSSN_CHECK:
  goto END_CHECK

CROSSW:
  if $roomid != 1 then gosub go_room 1
CROSSW_1:
  put #echo >Log Lime "Forest Scan of Crossing West Gate"
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  gosub go_room 81
CROSSW_81:
  gosub WATCH 1
  gosub go_room 84
CROSSW_84:
  gosub WATCH 1
  gosub go_room 85
CROSSW_85:
  gosub WATCH 1
  gosub go_room 86
CROSSW_86:
  gosub WATCH 1
  gosub go_room 247
CROSSW_247:
  gosub WATCH 1
  gosub go_room 248
CROSSW_248:
  gosub WATCH 1
  gosub go_room 249
CROSSW_249:
  gosub WATCH 1
  gosub go_room 250
CROSSW_250:
  gosub WATCH 1
  gosub go_room 251
CROSSW_251:
  gosub WATCH 1
  gosub go_room 252
CROSSW_252:
  gosub WATCH 1
  gosub go_room 254
CROSSW_254:
  gosub WATCH 1
  gosub go_room 255
CROSSW_255:
  gosub WATCH 1
  gosub go_room 256
CROSSW_256:
  gosub WATCH 1
  gosub go_room 258
CROSSW_258:
  gosub WATCH 1
  gosub go_room 263
CROSSW_263:
  gosub WATCH 1
  gosub go_room 82
CROSSW_82:
  gosub WATCH 1
  gosub go_room 83
CROSSW_83:
  gosub WATCH 1
  gosub go_room 97
CROSSW_97:
  gosub WATCH 1
  gosub go_room 98
CROSSW_98:
  gosub WATCH 1
  gosub go_room 99
CROSSW_99:
  gosub WATCH 1
  gosub go_room 100
CROSSW_100:
  gosub WATCH 1
  gosub go_room 101
CROSSW_101:
  gosub WATCH 1
  gosub go_room 102
CROSSW_102:
  gosub WATCH 1
  gosub go_room 104
CROSSW_104:
  gosub WATCH 1
  gosub go_room 105
CROSSW_105:
  gosub WATCH 1
  gosub go_room 106
CROSSW_106:
  gosub WATCH 1
  gosub go_room 107
CROSSW_107:
  gosub WATCH 1
  gosub go_room 108
CROSSW_108:
  gosub WATCH 1
  gosub go_room 109
CROSSW_109:
  gosub WATCH 1
  gosub go_room 110
CROSSW_110:
  gosub WATCH 1
  gosub go_room 111
CROSSW_111:
  gosub WATCH 1
  gosub go_room 112
CROSSW_112:
  gosub WATCH 1
  gosub go_room 113
CROSSW_113:
  gosub WATCH 1
  gosub go_room 115
CROSSW_115:
  gosub WATCH 1
  gosub go_room 116
CROSSW_116:
  gosub WATCH 1
  gosub go_room 117
CROSSW_117:
  gosub WATCH 1
  gosub go_room 1
CROSSW_CHECK:
  goto END_CHECK

### AIN GHAZIL Section
AIN:
  gosub go_room 17
AIN_3:
AIN_17:
AIN_2:
  gosub go_room 77
AIN_77:
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub WATCH 1
  gosub go_room 78
AIN_78:
  gosub WATCH 1
  gosub go_room 84
AIN_84:
  gosub WATCH 1
  gosub go_room 85
AIN_85:
  gosub WATCH 1
  gosub go_room 86
AIN_86:
  gosub WATCH 1
  gosub go_room 87
AIN_87:
  gosub WATCH 1
  gosub go_room 88
AIN_88:
  pause
  gosub WATCH 1
  gosub go_room 89
AIN_89:
  gosub WATCH 1
  gosub go_room 90
AIN_90:
  gosub WATCH 1
  gosub go_room 79
AIN_79:
  gosub WATCH 1
  gosub go_room 80
AIN_80:
  gosub WATCH 1
  gosub go_room 81
AIN_81:
  gosub WATCH 1
  gosub go_room 115
AIN_115:
  gosub WATCH 1
  gosub go_room 116
AIN_116:
  gosub WATCH 1
  gosub go_room 117
AIN_117:
  gosub WATCH 1
  gosub go_room 118
AIN_118:
  gosub WATCH 1
  gosub go_room 82
AIN_82:
  gosub WATCH 1
  gosub go_room 83
AIN_83:
  gosub WATCH 1
  gosub go_room 119
AIN_119:
  gosub WATCH 1
  gosub go_room 120
AIN_120:
  gosub WATCH 1
  gosub go_room 121
AIN_121:
  gosub WATCH 1
  gosub go_room 122
AIN_122:
  gosub WATCH 1
  gosub go_room 123
AIN_123:
  gosub WATCH 1
  gosub go_room 124
AIN_124:
  gosub WATCH 1
  gosub go_room 97
AIN_97:
  gosub WATCH 1
  gosub go_room 98
AIN_98:
  gosub WATCH 1
  gosub go_room 100
AIN_100:
  gosub WATCH 1
  gosub go_room 99
AIN_99:
  gosub WATCH 1
  gosub go_room 101
AIN_101:
  gosub WATCH 1
  gosub go_room 102
AIN_102:
  gosub WATCH 1
  gosub go_room 103
AIN_103:
  gosub WATCH 1
  gosub go_room 104
AIN_104:
  gosub WATCH 1
  gosub go_room 105
AIN_105:
  gosub WATCH 1
  gosub go_room 106
AIN_106:
  gosub WATCH 1
  gosub go_room 107
AIN_107:
  gosub WATCH 1
  gosub go_room 108
AIN_108:
  gosub WATCH 1
  gosub go_room 109
AIN_109:
  gosub WATCH 1
  gosub go_room 110
AIN_110:
  gosub WATCH 1
  gosub go_room 111
AIN_111:
  gosub WATCH 1
  gosub go_room 112
AIN_112:
  gosub WATCH 1
  gosub go_room 113
AIN_113:
  gosub WATCH 1
  gosub go_room 114
AIN_114:
  gosub WATCH 1
  gosub go_room 91
AIN_91:
  gosub WATCH 1
  gosub go_room 92
AIN_92:
  gosub WATCH 1
  gosub go_room 94
AIN_94:
  gosub WATCH 1
  gosub go_room 125
AIN_125:
  gosub WATCH 1
  gosub go_room 93
AIN_93:
  gosub WATCH 1
  gosub go_room 95
AIN_95:
  gosub WATCH 1
  gosub go_room 96
AIN_96:
  gosub WATCH 1
AIN_CHECK:
  goto END_CHECK

### DIRGE SECTION
DIRGE:
  gosub go_room 14
DIRGE_70:
DIRGE_14:
  gosub go_room 132
DIRGE_132:
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub WATCH 1
  gosub go_room 133
DIRGE_133:
  gosub WATCH 1
  gosub go_room 134
DIRGE_134:
  gosub WATCH 1
  gosub go_room 135
DIRGE_135:
  gosub WATCH 1
  gosub go_room 137
DIRGE_137:
  gosub WATCH 1
  gosub go_room 138
DIRGE_138:
  gosub WATCH 1
  gosub go_room 139
DIRGE_139:
  pause
  gosub WATCH 1
  gosub go_room 140
DIRGE_140:
  gosub WATCH 1
  gosub go_room 154
DIRGE_154:
  gosub WATCH 1
  gosub go_room 155
DIRGE_155:
  gosub WATCH 1
  gosub go_room 156
DIRGE_156:
  gosub WATCH 1
  gosub go_room 157
DIRGE_157:
  gosub WATCH 1
  gosub go_room 158
DIRGE_158:
  gosub WATCH 1
  gosub go_room 159
DIRGE_159:
  gosub WATCH 1
  gosub go_room 161
DIRGE_161:
  gosub WATCH 1
  gosub go_room 160
DIRGE_160:
  gosub WATCH 1
  gosub go_room 141
DIRGE_141:
  gosub WATCH 1
  gosub go_room 145
DIRGE_145:
  gosub WATCH 1
  gosub go_room 146
DIRGE_146:
  gosub WATCH 1
  gosub go_room 147
DIRGE_147:
  gosub WATCH 1
  gosub go_room 149
DIRGE_149:
  gosub WATCH 1
  gosub go_room 150
DIRGE_150:
  gosub WATCH 1
  gosub go_room 151
DIRGE_151:
  gosub WATCH 1
  gosub go_room 152
DIRGE_152:
  gosub WATCH 1
  gosub go_room 153
DIRGE_153:
  gosub WATCH 1
  gosub go_room 142
DIRGE_142:
  gosub WATCH 1
  gosub go_room 143
DIRGE_143:
  gosub WATCH 1
  gosub go_room 14
DIRGE_CHECK:
  goto END_CHECK

### Fang Cove Section
FANG:
  gosub go_room 96
FANG_96:
  put #echo >Log Lime "Forest Scan of Fang Cove"
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub WATCH 1
  gosub go_room 97
FANG_97:
  gosub WATCH 1
  gosub go_room 99
FANG_99:
  gosub WATCH 1
  gosub go_room 98
FANG_98:
  gosub WATCH 1
  gosub go_room 100
FANG_100:
  gosub WATCH 1
  gosub go_room 101
FANG_101:
  gosub WATCH 1
  gosub go_room 105
FANG_105:
  gosub WATCH 1
  gosub go_room 106
FANG_106:
  gosub WATCH 1
  gosub go_room 102
FANG_102:
FANG_CHECK:
  goto END_CHECK

### Hib/Hawk Section
HAWK:
gosub go_room 24
HAWK_24:
  gosub go_room 203
	goto HAWK_203
HAWK_198:
  gosub go_room 203
	goto HAWK_203
HAWK_199:
  gosub go_room 203
	goto HAWK_203
HAWK_200:
  gosub go_room 203
	goto HAWK_203
HAWK_201:
  gosub go_room 203
	goto HAWK_203
HAWK_202:
  gosub go_room 203
	goto HAWK_203
HAWK_203:
	pause 6
  gosub move se
	pause
	if $roomid = 203 then goto HAWK_203
HAWK_204:
  pause
	put kneel
	pause
  gosub move go dark hole
	pause
	if $roomid = 204 then goto HAWK_204
HAWK_205:
HAWK_206:
HAWK_207:
HAWK_208:
HAWK_209:
HAWK_210:
HAWK_211:
HAWK_212:
HAWK_213:
HAWK_214:
HAWK_215:
HAWK_216:
HAWK_217:
HAWK_218:
HAWK_219:
HAWK_220:
HAWK_221:
### Swimming Section
HAWK_222:
  put .cast pyre 15 creature
  waitfor Spell Cast
  pause 5
	gosub go_room 223
	if $roomid = 223 then goto HAWK_223
	else goto HAWK_25
HAWK_223:
  gosub WATCH 1
  gosub go_room 224
HAWK_224:
  gosub WATCH 1
  gosub go_room 225
HAWK_225:
  gosub WATCH 1
  gosub go_room 226
HAWK_226:
  gosub WATCH 1
  gosub go_room 227
### Done Swimming
HAWK_227:
  pause
  put stand
  gosub WATCH 1
  gosub go_room 228
### Retch Fiends
HAWK_228:
  gosub WATCH 1
  gosub go_room 229
HAWK_229:
  gosub WATCH 1
  gosub go_room 230
HAWK_230:
  gosub WATCH 1
  gosub go_room 231
HAWK_231:
  gosub WATCH 1
  gosub go_room 232
HAWK_232:
  gosub WATCH 1
  gosub go_room 233
HAWK_233:
  gosub WATCH 1
  gosub go_room 236
HAWK_234:
  gosub go_room 236
	goto HAWK_236
HAWK_235:
  gosub go_room 236
	goto HAWK_236
HAWK_236:
  gosub WATCH 1
  gosub go_room 237
HAWK_237:
  gosub WATCH 1
  gosub go_room 238
HAWK_238:
  gosub WATCH 1
  gosub go_room 239
HAWK_239:
  gosub WATCH 1
  gosub go_room 240
HAWK_240:
  gosub WATCH 1
  gosub go_room 241
HAWK_241:
  gosub WATCH 1
  gosub go_room 242
HAWK_242:
  gosub WATCH 1
  gosub go_room 243
HAWK_243:
  gosub WATCH 1
  gosub go_room 244
HAWK_244:
  gosub WATCH 1
  gosub go_room 245
HAWK_245:
  gosub WATCH 1
  gosub go_room 246
HAWK_246:
  gosub WATCH 1
HAWK_CHECK:
  goto END_CHECK

### Riverhaven Section
RIVER:
RIVER_2:
  if $roomid != 44 then gosub go_room 44
RIVER_44:
  put #echo >Log Lime "Forest Scan of Riverhaven North"
  gosub WATCH 1
  gosub go_room 45
RIVER_45:
  gosub WATCH 1
  gosub go_room 46
RIVER_46:
  gosub WATCH 1
  gosub go_room 47
RIVER_47:
  gosub WATCH 1
  gosub go_room 48
RIVER_48:
  gosub WATCH 1
RIVER_CHECK:
  goto END_CHECK

RIVER2THEREN:
  if $roomid != 30 then gosub go_room 30
RIVER2THEREN_30:
  put #echo >Log Lime "Forest Scan of River2Theren"
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  gosub WATCH 1
  gosub go_room 29
RIVER2THEREN_29:
  gosub WATCH 1
  gosub go_room 28
RIVER2THEREN_28:
  gosub WATCH 1
  gosub go_room 27
RIVER2THEREN_27:
  gosub WATCH 1
  gosub go_room 26
RIVER2THEREN_26:
  gosub WATCH 1
  gosub go_room 25
RIVER2THEREN_25:
  gosub WATCH 1
  gosub go_room 24
RIVER2THEREN_24:
  gosub WATCH 1
  gosub go_room 23
RIVER2THEREN_23:
  gosub WATCH 1
  gosub go_room 22
RIVER2THEREN_22:
  gosub WATCH 1
  gosub go_room 21
RIVER2THEREN_21:
  gosub WATCH 1
  gosub go_room 20
RIVER2THEREN_20:
  gosub WATCH 1
  gosub go_room 19
RIVER2THEREN_19:
  gosub WATCH 1
  gosub go_room 18
RIVER2THEREN_18:
  gosub WATCH 1
  gosub go_room 17
RIVER2THEREN_17:
  gosub WATCH 1
  gosub go_room 16
RIVER2THEREN_16:
  gosub WATCH 1
  gosub go_room 15
RIVER2THEREN_15:
  gosub WATCH 1
  gosub go_room 14
RIVER2THEREN_14:
  gosub WATCH 1
RIVER2THEREN_CHECK:
  goto END_CHECK
   
### Theren Section
THEREN:
THEREN_141:
  if $roomid != 117 then gosub go_room 117
THEREN_117:
  put #echo >Log Lime "Forest Scan of Theren"
  gosub WATCH 1
  gosub go_room 118
THEREN_118:
  gosub WATCH 1
  gosub go_room 119
THEREN_119:
  gosub WATCH 1
  gosub go_room 120
THEREN_120:
  gosub WATCH 1
  gosub go_room 121
THEREN_121:
  gosub WATCH 1
  gosub go_room 122
THEREN_122:
  gosub WATCH 1
  gosub go_room 123
THEREN_123:
  gosub WATCH 1
  gosub go_room 124
THEREN_124:
  gosub WATCH 1
  gosub go_room 146
THEREN_146:
  gosub WATCH 1
  gosub go_room 376
THEREN_376:
  waitfor [Ker'Leor, Deep Forest Path]
  put #mapper reset
  goto LUMBER_LOCATION

RAUDERS:
RAUDERS_2:
  put #echo >Log Lime "Forest Scan of Marauders"
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  gosub go_room 31
RAUDERS_31:
  gosub WATCH 1
  gosub go_room 32
RAUDERS_32:
  gosub WATCH 1
  gosub go_room 33
RAUDERS_33:
  gosub WATCH 1
  gosub go_room 34
RAUDERS_34:
  gosub WATCH 1
  gosub go_room 35
RAUDERS_35:
  gosub WATCH 1
  gosub go_room 36
RAUDERS_36:
  gosub WATCH 1
  gosub go_room 37
RAUDERS_37:
  gosub WATCH 1
  gosub go_room 38
RAUDERS_38:
  gosub WATCH 1
  gosub go_room 39
RAUDERS_39:
  gosub WATCH 1
  gosub go_room 40
RAUDERS_40:
  gosub WATCH 1
  gosub go_room 209
RAUDERS_209:
  gosub WATCH 1
  gosub go_room 210
RAUDERS_210:
  gosub WATCH 1
  gosub go_room 211
RAUDERS_211:
  gosub WATCH 1
  gosub go_room 212
RAUDERS_212:
  gosub WATCH 1
  gosub go_room 213
RAUDERS_213:
  gosub WATCH 1
  gosub go_room 214
RAUDERS_214:
  gosub WATCH 1
  put rel cyclic
  gosub go_room langenfirth
  waitfor [Theren Road]
  put #mapper reset
  goto LUMBER_LOCATION

THEREN_212:
  gosub go_room rossman
  goto LUMBER_LOCATION

ROSS_136:
  put #echo >Log Lime "Forest Scan of Rossman's"
  gosub WATCH 1
  gosub go_room 135
ROSS_135:
  gosub WATCH 1
  gosub go_room 134
ROSS_134:
  gosub WATCH 1
  gosub go_room 133
ROSS_133:
  gosub WATCH 1
  gosub go_room 132
ROSS_132:
  gosub WATCH 1
  gosub go_room 131
ROSS_131:
  gosub WATCH 1
  gosub go_room 130
ROSS_130:
  gosub WATCH 1
  gosub go_room 129
ROSS_129:
  gosub WATCH 1
  gosub go_room 128
ROSS_128:
  gosub WATCH 1
  gosub go_room 127
ROSS_127:
  gosub WATCH 1
  gosub go_room 126
ROSS_126:
  gosub WATCH 1
  gosub go_room 125
ROSS_125:
  gosub WATCH 1
  gosub go_room 124
ROSS_124:
  gosub WATCH 1
  gosub go_room 123
ROSS_123:
  gosub WATCH 1
  gosub go_room 122
ROSS_122:
  gosub WATCH 1
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
  gosub go_room 53
ROSS_53:
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
  gosub WATCH 1
  gosub go_room 52
ROSS_52:
  gosub WATCH 1
  gosub go_room 51
ROSS_51:
  gosub WATCH 1
  gosub go_room 50
ROSS_50:
  gosub WATCH 1
  gosub go_room 54
ROSS_54:
  gosub WATCH 1
  gosub go_room 55
ROSS_55:
  gosub WATCH 1
  gosub go_room 56
ROSS_56:
  gosub WATCH 1
  gosub go_room 57
ROSS_57:
  gosub WATCH 1
  gosub go_room 49
ROSS_49:
  gosub WATCH 1
  gosub go_room 48
ROSS_48:
  gosub WATCH 1
  gosub go_room 58
ROSS_58:
  gosub WATCH 1
  gosub go_room 45
ROSS_45:
  gosub WATCH 1
  gosub go_room 44
ROSS_44:
  gosub WATCH 1
  gosub go_room 46
ROSS_46:
  gosub WATCH 1
  gosub go_room 47
ROSS_47:
  gosub WATCH 1
  gosub go_room 43
ROSS_43:
  gosub WATCH 1
  gosub go_room 10
ROSS_10:
  put rel cyclic
  gosub WATCH 1
  gosub go_room 5
ROSS_5:
  gosub WATCH 1
  gosub go_room 4
ROSS_4:
  gosub WATCH 1
  gosub go_room 1
ROSS_1:
  gosub WATCH 1
  gosub go_room 2
ROSS_2:
  gosub WATCH 1
  gosub go_room 3
ROSS_3:
  gosub WATCH 1
  gosub go_room 6
ROSS_6:
  gosub WATCH 1
  gosub go_room 7
ROSS_7:
  gosub WATCH 1
  gosub go_room 8
ROSS_8:
  gosub WATCH 1
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
  gosub go_room 137
  goto END_CHECK

### Shard Section
SHARD_SOUTH:
  gosub go_room 2
SHARD_SOUTH_2:
  put #echo >Log Lime "Forest Scan of Shard South"
  put .cast pyre 20 creature
  waitfor Spell Cast
  pause 2
  #gosub WATCH 1
  gosub go_room 3
SHARD_SOUTH_3:
  gosub WATCH 1
  gosub go_room 4
SHARD_SOUTH_4:
  gosub WATCH 1
  gosub go_room 5
SHARD_SOUTH_5:
  gosub WATCH 1
  gosub go_room 6
SHARD_SOUTH_6:
  gosub WATCH 1
  gosub go_room 7
SHARD_SOUTH_7:
  gosub WATCH 1
  gosub go_room 28
SHARD_SOUTH_28:
  gosub WATCH 1
  gosub go_room 29
SHARD_SOUTH_29:
  gosub WATCH 1
  gosub go_room 30
SHARD_SOUTH_30:
  gosub WATCH 1
  gosub go_room 31
SHARD_SOUTH_31:
  gosub WATCH 1
  gosub go_room 32
SHARD_SOUTH_32:
  gosub WATCH 1
  gosub go_room 33
SHARD_SOUTH_33:
  gosub WATCH 1
  gosub go_room 34
SHARD_SOUTH_34:
  gosub WATCH 1
  gosub go_room 139
SHARD_SOUTH_139:
  gosub WATCH 1
  gosub go_room 140
SHARD_SOUTH_140:
  gosub WATCH 1
  gosub go_room 141
SHARD_SOUTH_141:
  gosub WATCH 1
  gosub go_room 142
SHARD_SOUTH_142:
  gosub WATCH 1
  gosub go_room 143
SHARD_SOUTH_143:
  gosub WATCH 1
  gosub go_room 144
SHARD_SOUTH_144:
  gosub WATCH 1
  gosub go_room 210
SHARD_SOUTH_210:
  gosub WATCH 1
  gosub go_room 209
SHARD_SOUTH_209:
  gosub WATCH 1
  gosub go_room 145
SHARD_SOUTH_145:
  gosub WATCH 1
  gosub go_room 146
SHARD_SOUTH_146:
  gosub WATCH 1
  gosub go_room 147
SHARD_SOUTH_147:
  gosub WATCH 1
  gosub go_room 148
SHARD_SOUTH_148:
  gosub WATCH 1
  gosub go_room 149
SHARD_SOUTH_149:
  gosub WATCH 1
  gosub go_room 150
SHARD_SOUTH_150:
  gosub WATCH 1
  gosub go_room 151
SHARD_SOUTH_151:
  gosub WATCH 1
  gosub go_room 152
SHARD_SOUTH_152:
  gosub WATCH 1
  gosub go_room 153
SHARD_SOUTH_153:
  gosub WATCH 1
  gosub go_room 154
SHARD_SOUTH_154:
  gosub WATCH 1
  gosub go_room 155
SHARD_SOUTH_155:
  gosub WATCH 1
  gosub go_room 156
SHARD_SOUTH_156:
  gosub WATCH 1
  gosub go_room 157
SHARD_SOUTH_157:
  gosub WATCH 1
  gosub go_room 158
SHARD_SOUTH_158:
  gosub WATCH 1
  gosub go_room 159
SHARD_SOUTH_159:
  gosub WATCH 1
  gosub go_room 160
SHARD_SOUTH_160:
  gosub WATCH 1
  gosub go_room 161
SHARD_SOUTH_161:
  gosub WATCH 1
  gosub go_room 162
SHARD_SOUTH_162:
  gosub WATCH 1
  gosub go_room 163
SHARD_SOUTH_163:
  gosub WATCH 1
  gosub go_room 164
SHARD_SOUTH_164:
  gosub WATCH 1
  gosub go_room 165
SHARD_SOUTH_165:
  gosub WATCH 1
  gosub go_room 166
SHARD_SOUTH_166:
  gosub WATCH 1
  gosub go_room 167
SHARD_SOUTH_167:
  gosub WATCH 1
  gosub go_room 168
SHARD_SOUTH_168:
  gosub WATCH 1
  gosub go_room 169
SHARD_SOUTH_169:
  gosub WATCH 1
  gosub go_room 170
SHARD_SOUTH_170:
  gosub WATCH 1
  gosub go_room 171
SHARD_SOUTH_171:
  gosub WATCH 1
  gosub go_room 172
SHARD_SOUTH_172:
  gosub WATCH 1
  gosub go_room 173
SHARD_SOUTH_173:
  gosub WATCH 1
  gosub go_room 174
SHARD_SOUTH_174:
  gosub WATCH 1
  gosub go_room 175
SHARD_SOUTH_175:
  gosub WATCH 1
  gosub go_room 176
SHARD_SOUTH_176:
  gosub WATCH 1
  gosub go_room 52
SHARD_SOUTH_52:
  gosub WATCH 1
  gosub go_room 53
SHARD_SOUTH_53:
  gosub WATCH 1
  gosub go_room 54
SHARD_SOUTH_54:
  gosub WATCH 1
  gosub go_room 55
SHARD_SOUTH_55:
  gosub WATCH 1
  gosub go_room 56
SHARD_SOUTH_56:
  gosub WATCH 1
  gosub go_room 57
SHARD_SOUTH_57:
  gosub WATCH 1
  gosub go_room 58
SHARD_SOUTH_58:
  gosub WATCH 1
  gosub go_room 59
SHARD_SOUTH_59:
  gosub WATCH 1
  gosub go_room 60
SHARD_SOUTH_60:
  gosub WATCH 1
  gosub go_room 61
SHARD_SOUTH_61:
  gosub WATCH 1
  gosub go_room 62
SHARD_SOUTH_62:
  gosub WATCH 1
  gosub go_room 63
SHARD_SOUTH_63:
  gosub WATCH 1
  gosub go_room 64
SHARD_SOUTH_64:
  gosub WATCH 1
  gosub go_room 65
SHARD_SOUTH_65:
  gosub WATCH 1
  gosub go_room 66
SHARD_SOUTH_66:
  gosub WATCH 1
  gosub go_room 67
SHARD_SOUTH_67:
  gosub WATCH 1
  gosub go_room 68
SHARD_SOUTH_68:
  gosub WATCH 1
  gosub go_room 74
SHARD_SOUTH_74:
  gosub WATCH 1
  gosub go_room 205
SHARD_SOUTH_205:
  gosub WATCH 1
  gosub go_room 69
SHARD_SOUTH_69:
  gosub WATCH 1
  gosub go_room 70
SHARD_SOUTH_70:
  gosub WATCH 1
  gosub go_room 71
SHARD_SOUTH_71:
  gosub WATCH 1
  gosub go_room 72
SHARD_SOUTH_72:
  gosub WATCH 1
  gosub go_room 73
SHARD_SOUTH_73:
  gosub WATCH 1
  gosub go_room 2
SHARD_SOUTH_CHECK:
  goto END_CHECK
