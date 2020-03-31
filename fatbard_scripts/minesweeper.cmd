# Minesweeper script
#debug 5

if "$zoneid" = "116" then
{
  put .ptravel CROSSING
  waitfor Done Portalhax
}

#action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
goto map_check

### Includes
include includes.cmd


map_check:
  var location unknown
  var MineZone $zoneid
  if "$zoneid" = "1" then
  {
    var location crossing
    var LastZone 114
  }
  if "$zoneid" = "10" then
  {
    var location stone
    var LastZone 114
  }
  if "$zoneid" = "13" then
  {
    var location dirge
    var LastZone 10
  }
  if "$zoneid" = "30" then
  {
    var location riverhaven
    var LastZone 68a
  }
  if "$zoneid" = "33" then
  {
    var location riverwest
    var LastZone 68a
  }
	if "$zoneid" = "66" then
  {
    var location str
    var LastZone 150
  }
	if "$zoneid" = "67" then
  {
    var location shard
    var LastZone 150
  }
	if "$zoneid" = "68" then
  {
    var location shardsouth
    var LastZone 150
  }
	if "$zoneid" = "69" then
  {
    var location shardwest
    var LastZone 150
  }
	if "$zoneid" = "68a" then
  {
    var location icecave
    var LastZone 150
  }
  if "$zoneid" = "114" then
  {
    var location ain
    var LastZone 68a
  }
  if "$zoneid" = "107" then
  {
    var location kresh
    var LastZone 33
  }
	if "$zoneid" = "116" then
  {
    var location hib
    var LastZone 33
  }
	if "$zoneid" = "123" then
  {
    var location shel
    var LastZone 33
  }
	if "$zoneid" = "126" then
  {
    var location hawk
    var LastZone 33
  }
	if "$zoneid" = "127" then
  {
    var location boar
    var LastZone 33
  }
  if "$zoneid" = "150" then
  {
    var location fang
    var LastZone 13
  }

  if "%location" = "unknown" then
  {
    echo Unknown Zone
    exit
  }

room_check:

  var hib_rooms 410|75|159|163|164|193|218|298|386|407|409|411|412|418
	var crossing_rooms 51|46|50|531|532|498|146
  var shel_rooms 24|32|168|6
  var stone_rooms 1|2
  var fang_rooms 85|7
  var riverhaven_rooms 28|73|1|331|328
  var dirge_rooms 70|14
  var riverwest_rooms 2|135|1
  var shard_rooms 146|148|248|206|207
  var shardsouth_rooms 2|34
  var icecave_rooms 31
  var ain_rooms 2|1|17
  var kresh_rooms 88|77|106|111
	if contains("|%%location_rooms|", "|$roomid|") then goto %location_$roomid

	else gosub go_room %%location_rooms(0)
	goto room_check

#Ain Ghazil
ain_3:
ain_2:
  put .prospect scan
  waitfor Script Done
ain_17:
  gosub go_room 2
  gosub move e
  put .travel hib
  waitforre ^You Have Arrived|^\*\*\* YOU HAVE ARRIVED \*\*\*
  put stow right;stow left
  goto map_check

# Crossing
crossing_51:
crossing_146:
crossing_531:
crossing_532:
  gosub go_room ntr
  gosub go_room stone
  gosub move w
  gosub move e
  goto map_check

cross_to_FANG:
  gosub go_room Portal
  gosub move go meeting portal
  goto map_check

crossing_46:
crossing_50:
  put .ptravel SHARD
  waitfor Done Portalhax
  goto map_check

### Fang Cove
# Mine Scan, mech at cove, sorcery
fang_85:
  put #echo >Log Purple Fang Cove Mining
  put .prospect scan
  waitfor Script Done
  goto fang_7

fang_7:
  gosub go_room 85
  gosub move go exit portal
  pause
  gosub move nw
  gosub move nw
  goto map_check

### Stone Clan
# Mine if super rare
stone_1:
  put #echo >Log Purple Stone Clan Mining
  put .prospect scan
  waitfor Script Done
  goto stone_2

stone_2:
  gosub go_room ntr
  if "%MineZone" = "%LastZone" then
  {
    gosub go_room crossing
    put .ptravel HIBARN
    waitfor Done Portalhax
    goto hib_75
  }
  gosub go_room dirge
  goto map_check

### Dirge
# Work mech, work sorcery, mine if super rare
dirge_70:
  put #echo >Log Purple Dirge Mining
  put .prospect scan
  waitfor Script Done
  goto dirge_14

dirge_14:
  gosub go_room ntr
  gosub go_room crossing
  gosub go_room portal
  if "%MineZone" = "%LastZone" then
  {
    gosub go_room crossing
    put .ptravel HIBARN
    waitfor Done Portalhax
    goto hib_75
  }
  goto cross_to_FANG


### Shard
# Climbing, mech, sorcery
shard_148:
  gosub go_room 146
shard_146:
  put .shard_climb
  waitfor Script Done
#  gosub go_room 248

shard_248:
#  put .origami
#  waitfor Origami Complete
#  put .cast
#  waitfor Casting Complete
  gosub go_room 199
  gosub move go gate
  goto map_check

shardsouth_2:
  gosub go_room 214
  goto map_check

shardsouth_34:
  gosub go_room 2
  gosub move go gate
  gosub move n
  gosub move n
  goto map_check

# mining out south gate
icecave_31:
  put #echo >Log Purple Ice Caves Mining
  put .prospect scan
  waitfor Script Done
  goto map_check

# sell gem pouch
shard_206:
shard_207:
	var gemcount 0
	action var gemcount $1 when pouch and find (\d+) gems in it\.
	pause
	put -count my gem pouch
	pause 3
	if %gemcount > 300 then
  {
    gosub go_room 129
    gosub go_room Gems
    put get my gem pouch;remove my gem pouch
	  pause
	  put sell my gem pouch;sell my gem pouch
	  pause
	  put wear my gem pouch
    gosub go_room 31
  }
  gosub go_room gem
  S_PLAT_NUGG_SELL:
    matchre S_PLAT_NUGG_SELL ^You drop|^You put|^You reverently place
    matchre S_GOLD_NUGG_SELL ^What were you referring to\?
  put get my plat nugget;sell my plat nugget in crucible
  matchwait 2
  goto S_PLAT_NUGG_SELL

  S_GOLD_NUGG_SELL:
    matchre S_GOLD_NUGG_SELL ^\w+ scrutinizes the \w+ nugget carefully, then hands you
    matchre S_DONE_NUGG_SELL ^What were you referring to\?
  put get my gold nugget;sell my gold nugget
  matchwait 2
  goto S_GOLD_NUGG_SELL

  S_DONE_NUGG_SELL:

  if "%MineZone" = "%LastZone" then
  {
    put .ptravel HIBARN
    waitfor Done Portalhax
    goto hib_75
  }
  put .ptravel  RIVER
  waitfor Done Portalhax
  goto map_check

### Riverhaven
# Work mech, work sorcery
# Head to west gate
riverhaven_28:
riverhaven_73:
riverhaven_328:
  gosub go_room w gate
  goto map_check

### Riverhaven West Gate Area
# Run mines
riverwest_2:
  put #echo >Log Purple Riverhaven Mining
  put .prospect scan
  waitfor Script Done
  goto riverwest_135

riverwest_135:
  gosub go_room riverhaven
riverhaven_1:
  if "%MineZone" = "%LastZone" then
  {
    put .ptravel HIBARN
    waitfor Done Portalhax
    goto hib_75
  }
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check

# Workorder, reckus
hib_163:
hib_to_SHEL:
  gosub go_room Raven
  gosub go_room 24
  goto map_check


shel_to_AIN:
  gosub go_room 6
shel_6:
  put .travel Ain
  waitforre ^You Have Arrived|^\*\*\* YOU HAVE ARRIVED \*\*\*
  put stow right;stow left
  gosub move west
  pause
  goto map_check 

### Himineldar Shel
# Mine Scan, mech at Mamas, sorcery
shel_168:
  gosub go_room 24
  goto shel_24

shel_24:
  put #echo >Log Purple Hib Mining
  put .prospect scan
  waitfor Script Done
  goto shel_32

shel_32:
  if "%MineZone" = "%LastZone" then
  {
    goto hib_75
  }
  goto shel_to_AIN

hib_1:

hib_75:
hib_159:
hib_164:
hib_407:
  if %wounded = 1 then gosub hib_HEALER
hib_to_GEM:
  gosub go_room Gem
hib_298:
  PLAT_NUGG_SELL:
    matchre PLAT_NUGG_SELL ^You drop|^You put|^You reverently place
    matchre GOLD_NUGG_SELL ^What were you referring to\?
  put get my plat nugget;sell my plat nugget in crucible
  matchwait 2
  goto PLAT_NUGG_SELL

  GOLD_NUGG_SELL:
    matchre GOLD_NUGG_SELL ^\w+ scrutinizes the \w+ nugget carefully, then hands you
    matchre DONE_NUGG_SELL ^What were you referring to\?
  put get my gold nugget;sell my gold nugget
  matchwait 2
  goto GOLD_NUGG_SELL

  DONE_NUGG_SELL:

 	var skincount 0
	action var skincount $1 when ^You flip through the lumpy bundle and find (\d+) \w+ in it\.
	pause
	put -count my lumpy bundle
	pause 3
	if %skincount > 5 then
  {
    gosub go_room 218
    goto hib_BUNDLE
  }
  else
  {
    gosub go_room 193
    goto hib_BANK
  }

hib_386:
hib_HEALER:
  gosub go_room 386
  put lie
  waitfor You sit up.
  var wounded 0
  put stand
  waitfor You stand back up.
  return

hib_218:
hib_BUNDLE:
 	if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
	if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
 	pause
	put get eye from my bundle
 	pause
 	put stow eye
 	pause
 	put remove my bundle
 	pause
 	put sell my bundle
 	pause
 	put get rope from my cloak
 	pause
 	put get my eye
 	pause
 	put bundle
 	pause
 	put wear my bundle
 	pause 
  gosub go_room 193
  goto hib_BANK

hib_193:
hib_BANK:
  put excd
  pause 3
  put depall
  pause 2
  put withdraw 5 plat dok
  pause
  gosub go_room 411
  goto hib_411

hib_409:
hib_418:
  gosub go_room 410
hib_410:
  put #parse Minesweeper Done
  pause 0.5
  exit
