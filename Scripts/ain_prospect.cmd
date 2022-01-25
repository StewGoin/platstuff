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

MINE_LOCATION:

if $zone = 114 then VAR LOCATION AIN #ain ghazil
if $zone = 14 then var LOCATION DIRGE #dirge
if $zone = 10 then var LOCATION STONE #stone clan
if $zone = 150 then var LOCATION FANG #fang cove
if $zone = 33 then var LOCATION RIVER #riverhaven west gate
if $zone = 68a then var LOCATION SHARD #shard ice caves
if $zone = 126 then var LOCATION HAWK #Hib/Hawk road


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

goto %LOCATION_$roomid
goto %LOCATION

END_CHECK:
	if %rip = 1 then goto DONE
	if  (($Outdoorsmanship.LearningRate >= 32 ) || (%scan = 1))  then goto DONE_1
	else goto %LOCATION

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
	gosub go_room %LOCATION_DONEROOM
	pause
	put #parse Script Done
	exit

include includes.cmd

### AIN GHAZIL Section

AIN:
var AIN_DONEROOM 17

AIN_3:
AIN_17:
  gosub go_room 77
AIN_77:
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
AIN_CHECK:
  goto END_CHECK

### DIRGE SECTION
DIRGE:
var DIRGE_DONEROOM 2

DIRGE_70:
DIRGE_14:
  gosub go_room 132
DIRGE_132:
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
  gosub go_room 148
DIRGE_148:
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
