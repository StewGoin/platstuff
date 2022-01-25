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
put .var_mine
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

MINE_LOCATION:

if "$zoneid" = "114" then var LOCATION AIN
if "$zoneid" = "13" then var LOCATION DIRGE
if "$zoneid" = "10" then var LOCATION STONE
if "$zoneid" = "150" then var LOCATION FANG
if "$zoneid" = "33" then var LOCATION RIVER
if "$zoneid" = "68a" then var LOCATION SHARD
if "$zoneid" = "123" then var LOCATION HAWK
if "$zoneid" = "42" then var LOCATION THEREN


### Bards - Sings SIRE quietly to keep critters away and populate nearby rooms for HUNT.
###
### Non-Bards need to edit script to do PP as a separate section, or just use the built-in PP variables for automapper.
### Illimin's script could be useful for guidance there.
###

#unused for now	covellite|nickel|pewter|tin|zinc
## action (log) put #echo >Log DimGray $2 found in room $roomid when ^(You are certain that ($mineIgnore) can be mined here\.)
## action (log) put #echo >Log PaleGreen $2 found in room $roomid when ^(You are certain that ($mineMassivePlus) can be mined here\.)
## action (log) put #echo >Log Lime $2 found in room $roomid when ^(You are certain that ($mineHugePlus) can be mined here\.)
action (log) put #echo >Log Aqua $2 found in room $roomid when ^(You are certain that ($mineMediumPlus) can be mined here\.)
action (log) put #echo >Log Aqua $2 found in room $roomid when ^(You are certain that ($mineRip) can be mined here\.)
action (log) put #echo >Log Red $2 found in room $roomid when ^(You are certain that ($mineAll) can be mined here\.)

### 1 = HUNT, 0 = skip HUNTing
var hunting 0
if %hunting = 1 then gosub hunt
pause

goto %LOCATION_$roomid

END_CHECK:
	if %rip = 1 then goto DONE
	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1))  then goto DONE_1
	else goto %LOCATION

PROS:
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
	if %rip = 1 then goto PROS_1
  if (($Outdoorsmanship.LearningRate >= 32 ) && (%scan = 0)) then goto DONE_%SIDE
PROS_1:
  if ("$roomplayers"="") then
  {
	if %rip = 1 then match MINEIT ^You are certain that ($mineIgnore) can be mined here\.
	matchre MINEIT ^You are certain that ($mineMassivePlus|$mineHugePlus) can be mined here\.
  matchre RIPIT ^You are certain that ($mineRip) can be mined here\.
	matchre MINEIT_CAREFUL ^You are certain that ($mineMediumPlus|$mineAll) can be mined here\.
	matchre MINEIT ^Miners stand ready to trade resources in for deeds|deed resources
	matchre PROS_1 ^\.\.\.wait|you may only type
	matchre PROSPECTED ^Roundtime
	put pros
	matchwait 2
	goto PROS_1
  }
  else goto PROSPECTED

MINEIT_CAREFUL:
	#if %walkOnly = 1 then return
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	action (log) off
  if matchre("$1", "$mineRip") then put .mine 1 2
	else put .mine
	waitfor Mining Done
	action (log) on
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
	return

MINEIT:
	if %walkOnly = 1 then return
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	action (log) off
	if %rip = 1 then put .mine 1 2
	else put .mine
	waitfor Mining Done
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
  put rel cyclic
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
	pause
  if $zoneid = 42 then gosub go_room 116
  if $zoneid = 114 then gosub go_room 17
  if $zoneid = 13 then gosub go_room 2
  if $zoneid = 10 then gosub go_room 1
  if $zoneid = 150 then gosub go_room 7
  if $zoneid = 33 then gosub go_room 135
  if "$zoneid" = "68a" then gosub go_room 31
  # Hawk / Hib
  if $zoneid = 123 then
  {
    gosub go_room 246
    gosub go_room 32
  }
	pause
	put #parse Script Done
	exit

PROSPECT_CYCLIC:
  put rel all
  put #var cam_leeched 1
  put #var cam_slipped 1
  gosub PREP_CYCLIC $1 $2
  return

include includes.cmd

THEREN:
exit

### AIN GHAZIL Section
AIN:
AIN_34:
  gosub go_room 17
AIN_3:
AIN_17:
AIN_2:
  gosub go_room 77
AIN_77:
  put #echo >Log Red "Prospect Scan of Ain Ghazil"
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub PROS 1
  gosub go_room 78
AIN_78:
  gosub PROS 1
  gosub go_room 84
AIN_84:
  gosub PROS 1
  gosub go_room 85
AIN_85:
  gosub PROS 1
  gosub go_room 86
AIN_86:
  gosub PROS 1
  gosub go_room 87
AIN_87:
  gosub PROS 1
  gosub go_room 88
AIN_88:
  pause
  gosub PROS 1
  gosub go_room 89
AIN_89:
  gosub PROS 1
  gosub go_room 90
AIN_90:
  gosub PROS 1
  gosub go_room 79
AIN_79:
  gosub PROS 1
  gosub go_room 80
AIN_80:
  gosub PROS 1
  gosub go_room 81
AIN_81:
  gosub PROS 1
  gosub go_room 115
AIN_115:
  gosub PROS 1
  gosub go_room 116
AIN_116:
  gosub PROS 1
  gosub go_room 117
AIN_117:
  gosub PROS 1
  gosub go_room 118
AIN_118:
  gosub PROS 1
  gosub go_room 82
AIN_82:
  gosub PROS 1
  gosub go_room 83
AIN_83:
  gosub PROS 1
  gosub go_room 119
AIN_119:
  gosub PROS 1
  gosub go_room 120
AIN_120:
  gosub PROS 1
  gosub go_room 121
AIN_121:
  gosub PROS 1
  gosub go_room 122
AIN_122:
  gosub PROS 1
  gosub go_room 123
AIN_123:
  gosub PROS 1
  gosub go_room 124
AIN_124:
  gosub PROS 1
  gosub go_room 97
AIN_97:
  gosub PROS 1
  gosub go_room 98
AIN_98:
  gosub PROS 1
  gosub go_room 100
AIN_100:
  gosub PROS 1
  gosub go_room 99
AIN_99:
  gosub PROS 1
  gosub go_room 101
AIN_101:
  gosub PROS 1
  gosub go_room 102
AIN_102:
  gosub PROS 1
  gosub go_room 103
AIN_103:
  gosub PROS 1
  gosub go_room 104
AIN_104:
  gosub PROS 1
  gosub go_room 105
AIN_105:
  gosub PROS 1
  gosub go_room 106
AIN_106:
  gosub PROS 1
  gosub go_room 107
AIN_107:
  gosub PROS 1
  gosub go_room 108
AIN_108:
  gosub PROS 1
  gosub go_room 109
AIN_109:
  gosub PROS 1
  gosub go_room 110
AIN_110:
  gosub PROS 1
  gosub go_room 111
AIN_111:
  gosub PROS 1
  gosub go_room 112
AIN_112:
  gosub PROS 1
  gosub go_room 113
AIN_113:
  gosub PROS 1
  gosub go_room 114
AIN_114:
  gosub PROS 1
  gosub go_room 91
AIN_91:
  gosub PROS 1
  gosub go_room 92
AIN_92:
  gosub PROS 1
  gosub go_room 94
AIN_94:
  gosub PROS 1
  gosub go_room 125
AIN_125:
  gosub PROS 1
  gosub go_room 93
AIN_93:
  gosub PROS 1
  gosub go_room 95
AIN_95:
  gosub PROS 1
  gosub go_room 96
AIN_96:
  gosub PROS 1
AIN_CHECK:
  goto END_CHECK

### DIRGE SECTION
DIRGE:
  gosub go_room 14
DIRGE_70:
DIRGE_14:
  gosub go_room 132
DIRGE_132:
  put #echo >Log Red "Prospect Scan of Dirge"
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub PROS 1
  gosub go_room 133
DIRGE_133:
  gosub PROS 1
  gosub go_room 134
DIRGE_134:
  gosub PROS 1
  gosub go_room 135
DIRGE_135:
  gosub PROS 1
  gosub go_room 137
DIRGE_137:
  gosub PROS 1
  gosub go_room 138
DIRGE_138:
  gosub PROS 1
  gosub go_room 139
DIRGE_139:
  pause
  gosub PROS 1
  gosub go_room 140
DIRGE_140:
  gosub PROS 1
  gosub go_room 154
DIRGE_154:
  gosub PROS 1
  gosub go_room 155
DIRGE_155:
  gosub PROS 1
  gosub go_room 156
DIRGE_156:
  gosub PROS 1
  gosub go_room 157
DIRGE_157:
  gosub PROS 1
  gosub go_room 158
DIRGE_158:
  gosub PROS 1
  gosub go_room 159
DIRGE_159:
  gosub PROS 1
  gosub go_room 161
DIRGE_161:
  gosub PROS 1
  gosub go_room 160
DIRGE_160:
  gosub PROS 1
  gosub go_room 141
DIRGE_141:
  gosub PROS 1
  gosub go_room 145
DIRGE_145:
  gosub PROS 1
  gosub go_room 146
DIRGE_146:
  gosub PROS 1
  gosub go_room 147
DIRGE_147:
  gosub PROS 1
  gosub go_room 149
DIRGE_149:
  gosub PROS 1
  gosub go_room 150
DIRGE_150:
  gosub PROS 1
  gosub go_room 151
DIRGE_151:
  gosub PROS 1
  gosub go_room 152
DIRGE_152:
  gosub PROS 1
  gosub go_room 153
DIRGE_153:
  gosub PROS 1
  gosub go_room 142
DIRGE_142:
  gosub PROS 1
  gosub go_room 143
DIRGE_143:
  gosub PROS 1
  gosub go_room 14
DIRGE_CHECK:
  goto END_CHECK

### Fang Cove Section
FANG:
  gosub go_room 63
FANG_85:
FANG_63:
  gosub go_room 64
	goto FANG_64
FANG_64:
  put #echo >Log Red "Prospect Scan of Fang Cove"
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub PROS 1
  gosub go_room 65
FANG_65:
  gosub PROS 1
  gosub go_room 66
FANG_66:
  gosub PROS 1
  gosub go_room 67
FANG_68:
  gosub PROS 1
  gosub go_room 69
FANG_69:
  gosub PROS 1
  gosub go_room 70
FANG_70:
  gosub PROS 1
  gosub go_room 71
FANG_71:
  gosub PROS 1
  gosub go_room 72
FANG_72:
  gosub PROS 1
  gosub go_room 73
FANG_73:
  gosub PROS 1
  gosub go_room 74
FANG_74:
  gosub PROS 1
  gosub go_room 75
FANG_75:
  gosub PROS 1
  gosub go_room 79
FANG_79:
  gosub PROS 1
  gosub go_room 80
FANG_80:
  gosub PROS 1
  gosub go_room 81
FANG_82:
  gosub PROS 1
  gosub go_room 83
FANG_83:
  gosub PROS 1
  gosub go_room 84
FANG_84:
  gosub PROS 1
  gosub go_room 91
FANG_91:
  gosub PROS 1
  gosub go_room 92
FANG_92:
  gosub PROS 1
  gosub go_room 93
FANG_93:
  gosub PROS 1
  gosub go_room 94
FANG_94:
FANG_95:
  gosub PROS 1
  gosub go_room 95
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
  if %playinst = 1 then
  {
    pause
    put stop play
    #gosub put my %instrument in my cloak
  }
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
  put #echo >Log Red "Prospect Scan of Hib East"
  put .cast pyre 15 creature
  waitfor Spell Cast
  pause 5
	gosub go_room 223
	if $roomid = 223 then goto HAWK_223
	else goto HAWK_25
HAWK_223:
  #if %playinst = 1 then
  #{
  #  gosub get my %instrument
  #  put swap
  #}
  gosub PROS 1
  gosub go_room 224
HAWK_224:
  gosub PROS 1
  gosub go_room 225
HAWK_225:
  gosub PROS 1
  gosub go_room 226
HAWK_226:
  gosub PROS 1
  gosub go_room 227
### Done Swimming
HAWK_227:
  pause
  put stand
  gosub PROS 1
  gosub go_room 228
### Retch Fiends
HAWK_228:
  gosub PROS 1
  gosub go_room 229
HAWK_229:
  gosub PROS 1
  gosub go_room 230
HAWK_230:
  gosub PROS 1
  gosub go_room 231
HAWK_231:
  gosub PROS 1
  gosub go_room 232
HAWK_232:
  gosub PROS 1
  gosub go_room 233
HAWK_233:
  gosub PROS 1
  gosub go_room 236
HAWK_234:
  gosub go_room 236
	goto HAWK_236
HAWK_235:
  gosub go_room 236
	goto HAWK_236
HAWK_236:
  gosub PROS 1
  gosub go_room 237
HAWK_237:
  gosub PROS 1
  gosub go_room 238
HAWK_238:
  gosub PROS 1
  gosub go_room 239
HAWK_239:
  gosub PROS 1
  gosub go_room 240
HAWK_240:
  gosub PROS 1
  gosub go_room 241
HAWK_241:
  gosub PROS 1
  gosub go_room 242
HAWK_242:
  gosub PROS 1
  gosub go_room 243
HAWK_243:
  gosub PROS 1
  gosub go_room 244
HAWK_244:
  gosub PROS 1
  gosub go_room 245
HAWK_245:
  gosub PROS 1
  gosub go_room 246
HAWK_246:
  gosub PROS 1
HAWK_CHECK:
  goto END_CHECK

### Riverhaven Section
RIVER:
RIVER_135:
  gosub go_room 44
  goto RIVER_44
RIVER_2:
RIVER_36:
  gosub go_room 44
RIVER_44:
  put #echo >Log Red "Prospect Scan of Riverhaven"
  put .cast aban 15 creature
  waitfor Spell Cast
  gosub PROS 1
  gosub go_room 45
RIVER_45:
  gosub PROS 1
  gosub go_room 46
RIVER_46:
  gosub PROS 1
  gosub go_room 47
RIVER_47:
  gosub PROS 1
  gosub go_room 48
RIVER_48:
  gosub PROS 1
  gosub go_room 49
RIVER_49:
  gosub PROS 1
  gosub go_room 50
RIVER_50:
  pause
  gosub PROS 1
  gosub go_room 51
RIVER_51:
  gosub PROS 1
  gosub go_room 52
RIVER_52:
  gosub PROS 1
  gosub go_room 53
RIVER_53:
  gosub PROS 1
  gosub go_room 54
RIVER_54:
  gosub PROS 1
  gosub go_room 55
RIVER_55:
  gosub PROS 1
  gosub go_room 56
RIVER_56:
  gosub PROS 1
  gosub go_room 57
RIVER_57:
  gosub PROS 1
  gosub go_room 58
RIVER_58:
  gosub PROS 1
  gosub go_room 59
RIVER_59:
  gosub PROS 1
#  gosub go_room 60
# RIVER_60:
  put ret;ret
  pause
  put ret;ret
  gosub go_room 61
#  put kneel
#  put go passage
  #waitfor Obvious exits: north.
RIVER_61:
  put stand
  gosub PROS 1
  gosub go_room 62
RIVER_62:
  gosub PROS 1
  gosub go_room 63
RIVER_63:
  gosub PROS 1
  gosub go_room 64
RIVER_64:
  gosub PROS 1
  gosub go_room 65
RIVER_65:
  gosub PROS 1
  gosub go_room 68
RIVER_68:
  gosub PROS 1
  gosub go_room 67
RIVER_67:
  gosub PROS 1
  gosub go_room 66
RIVER_66:
  gosub PROS 1
  gosub go_room 70
RIVER_70:
  gosub PROS 1
  gosub go_room 71
RIVER_71:
  gosub PROS 1
  gosub go_room 69
RIVER_69:
  gosub PROS 1
  gosub go_room 72
RIVER_72:
  gosub PROS 1
  gosub go_room 73
RIVER_73:
  gosub PROS 1
  gosub go_room 33
  gosub go_room 135
RIVER_CHECK:
  goto END_CHECK

### Stone Clan Section
STONE:
  gosub go_room 1
STONE_1:
STONE_2:
	put stow right
	put stow left
	gosub go_room 30
STONE_30:
  put #echo >Log Red "Prospect Scan of Stone Clan"
	put .cast aban 15 creature
	waitfor Spell Cast
	gosub PROS 1
  gosub go_room 31
STONE_31:
	gosub PROS 1
  gosub go_room 34
STONE_34:
	gosub PROS 1
  gosub go_room 35
STONE_35:
  gosub PROS 1
  gosub go_room 36
STONE_36:
  gosub PROS 1
  gosub go_room 37
STONE_37:
  gosub PROS 1
  gosub go_room 39
STONE_39:
  pause
  gosub PROS 1
  gosub go_room 40
STONE_40:
  gosub PROS 1
  gosub go_room 41
STONE_41:
  gosub PROS 1
  gosub go_room 42
STONE_42:
  gosub PROS 1
  gosub go_room 43
STONE_43:
  gosub PROS 1
  gosub go_room 44
STONE_44:
  gosub PROS 1
  gosub go_room 45
STONE_45:
  gosub PROS 1
  gosub go_room 46
STONE_46:
  gosub PROS 1
  gosub go_room 47
STONE_47:
  gosub PROS 1
  gosub go_room 27
STONE_27:
  gosub PROS 1
  gosub go_room 26
STONE_26:
  gosub PROS 1
  gosub go_room 25
STONE_25:
  gosub PROS 1
  gosub go_room 24
STONE_24:
	gosub PROS 1
	gosub go_room 2

STONE_CHECK:
  goto END_CHECK

### Shard Section
SHARD:
  gosub go_room 31
SHARD_31:
  gosub go_room 32
SHARD_32:
  put #echo >Log Red "Prospect Scan of Ice Caves"
  put .cast aban 15 creature
  waitfor Spell Cast
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
SHARD_7:
  gosub PROS 2
	pause
  gosub go_room 6
SHARD_6:
	pause
  put rel all
  put .cast aban 15 creature
  waitfor Spell Cast
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
SHARD_CHECK:
  goto END_CHECK
