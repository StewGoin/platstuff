## Start outside portal to FC in Crossing
#debug 5
put #echo >Log DarkBlue,LightYellow Starting MoneyHunt.
put #class arena off
put #var symbiosis 0
#var TRAIN_LOCATION CROSSING|FANG|SHARD
#var TRAIN_LOCATION_MAX 0
#var TRAIN_LOCATION_COUNT $train_location_count
#put #echo >Log DarkBlue,LightYellow (moneyhunt) TRAIN_LOCATION %TRAIN_LOCATION($train_location_count)
#action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put .rexp

var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox

var wounded 0
gosub SKIN_COUNT
gosub POUCH_TYPE

goto map_check

### Includes & GOSUBS
include includes.cmd

MAP_CHECK:
put #echo >Log DarkBlue,LightYellow (moneyhunt) MAP_CHECK
	var location unknown
	if "$zoneid" = "1" then var location crossing
	if "$zoneid" = "4" then var location crosswest
	if "$zoneid" = "6" then var location crossnorth
	if "$zoneid" = "7" then var location ntr
	if "$zoneid" = "10" then var location stone
	if "$zoneid" = "13" then var location dirge
	if "$zoneid" = "30" then var location riverhaven
	if "$zoneid" = "32" then var location rivernorth
	if "$zoneid" = "33" then var location riverwest
	if "$zoneid" = "33a" then var location river2theren
	if "$zoneid" = "34" then var location ross
	if "$zoneid" = "40" then var location theren
	if "$zoneid" = "41" then var location rauders
	if "$zoneid" = "65" then var location undergondola
	if "$zoneid" = "66" then var location shardnorth
	if "$zoneid" = "67" then var location shard
	if "$zoneid" = "68" then var location shardsouth
	if "$zoneid" = "68a" then var location icecave
	if "$zoneid" = "69" then var location shardwest
	if "$zoneid" = "150" then var location fang
	if "$zoneid" = "116" then var location hib
	if "$roomname" = "Private Home Interior" then var location home

	if "%location" = "unknown" then
	{
		put #echo Unknown Zone
		exit
	}

ROOM_CHECK:
put #echo >Log DarkBlue,LightYellow (moneyhunt) ROOM_CHECK
	var home_rooms 0
	var crossing_rooms 50|483
	var crosswest_rooms 1|117
	var crossnorth_rooms 22|2
	var dirge_rooms 70|68|198|187
	var ntr_rooms 268|318|116
	var stone_rooms 1|2
	var fang_rooms 85|87|89|88|7|137|222|127|153
	var riverhaven_rooms 28|73|1|331|328|26
	var rivernorth_rooms 2|48
	var riverwest_rooms 2|135|1|27
	var river2theren_rooms 30|14
	var ross_rooms 136|8
	var rauders_rooms 2|214
	var theren_rooms 141|212|199
	var undergondola_rooms 2|41
	var shard_rooms 146|148|248|206|207|43
	var shardsouth_rooms 2|31
	var icecave_rooms 31
	var shardwest_rooms 10|15|37|14|391|392|395|460|476|481|535|231|320
	var shardnorth_rooms 65|70|163|39
	var hib_rooms 75|17|159|163|164|193|218|298|314|386|407|409|410|411|412|413|418|427|432|116|96|287
	if contains("|%%location_rooms|", "|$roomid|") then goto %location_$roomid
	else
	{
		put #echo >Log Red,LightYellow Unhandled roomid: %location_$roomid
		gosub go_room %%location_rooms(0)
	}
	goto room_check

## Armor Swap to Defense
crossing_50:
crossing_483:
CROSSING_PORTAL:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSING_PORTAL

	# wound check / bundle check

	put .armor on defense
	waitfor Script Done
	if "$pouch" = "lore" then
	{
		gosub go_room portal
		gosub move go meeting.portal
		goto BATTLE_POUCH
	}
	gosub DAMAGE_CHECK
	if %armor_damage = 1 then gosub ITEM_REPAIR
	goto CROSSING_TO_DIRGE
## travel to dirge #68
CROSSING_TO_DIRGE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSING_TO_DIRGE
	gosub go_room ntr
ntr_268:
NTR_TO_DIRGE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) NTR_TO_DIRGE
	gosub go_room dirge
dirge_70:
DIRGE_TO_PREP:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_TO_PREP
	gosub go_room 68
dirge_68:
DIRGE_PREP:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_PREP
	if $roomid != 68 then gosub go_room 68
 	put .armor on defense
	waitfor Script Done
	pause 2
	put .fight reprep will cabal
	waitfor FIGHT PREPPED
	gosub TATTOO_CHECK
	gosub go_room 198
## boxhunt for cabalists (gh_watch), until all containers are full or in the exit room
dirge_198:
DIRGE_HUNT:
if contains("$scriptlist", "geniehunter.cmd") then goto DIRGE_HUNTING
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_HUNT
	put .fight cabal
	pause 0.5
	put .cast nexus 30 35 35
	waitfor Spell Cast
	put .geniehunter multi 1
	pause 2
DIRGE_HUNTING:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_HUNTING
	put .gh_watch
	waitfor Geniehunter Done.
dirge_187:
DIRGE_DONE_HUNTING:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_DONE_HUNTING
	put #script abort all except moneyhunt
	pause 0.5
	put wear my $shield
	pause 0.5
	put stow;stow left
	pause 0.5
	if matchre("$roomobjs", "(light kertig throwing axe)") then put stow throwing.axe
	if matchre("$roomobjs", "(senci stone shard)") then put stow stone.shard
	if matchre("$roomobjs", "(matte indurium sphere)") then put stow sphere
	if matchre("$roomobjs", "(icc-adder bolt)") then put stow ice-adder.bolt
	if matchre("$roomobjs", "(cuska)" then put stow cuska
	if matchre("$roomobjs", "(throwing mallet)") then put stow mallet
	if matchre("$roomobjs", "(chakram)") then put stow chakram
	put release cyclic;-2 release cyclic
DIRGE_TO_JISI:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_TO_JISI
	gosub go_room ntr
ntr_116:
NTR_TO_JISI:
put #echo >Log DarkBlue,LightYellow (moneyhunt) NTR_TO_JISI
	put release cyclic;-2 release cyclic
	gosub go_room crossing
crossing_146:
CROSSING_TO_JISI:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSING_TO_JISI
	gosub go_room portal
	gosub move go meeting.portal
	gosub go_room jisi

fang_153:
JISI_POP:
put #echo >Log DarkBlue,LightYellow (moneyhunt) JISI_POP
	if (matchre("$lefthandnoun", "(%boxes)") || matchre("$righthandnoun", "(%boxes)") then
	{
		matchre JISI_POP You drop|What were you
		put drop my $1
		matchwait 2
		goto JISI_POP
	}
	pause 0.5
	put .boxes
	waitfor All Boxes Opened
	pause 0.5
	gosub go_room gem
fang_127:
fang_85:
FANG_GEM:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_GEM
	## goto gem shop, sell nuggets
	gosub GEM_SELL
	gosub POUCH_LOOT
	put .moveitems deep.sash bucket
	waitfor Done Moving Items.
	pause 0.5
	gosub health_check
	pause 0.5
	if %wounded = 1 then gosub fang_HEALER
	goto FANG_POUCH_VAULT
fang_17:
	pause 0.5
	gosub health_check
	pause 0.5
	if %wounded = 1 then gosub fang_HEALER
	else goto FANG_POUCH_VAULT
FANG_HEALER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_HEALER
	if $roomid!= 17 then gosub go_room 17
	put join list
	#gosub ALMANAC_CHECK
	waitfor Yrisa crosses Ryken's name from the list
	pause
	var wounded 0
	return
fang_87:
FANG_POUCH_VAULT:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_POUCH_VAULT
	gosub go_room vault
	put go third arch
	waitfor Carousel Chamber]
	pause 0.5
	put look in my portal
	pause 0.5
	gosub POUCH_VAULT
	pause 0.5
	gosub POUCH_PORTAL
	pause 0.5
	put close vault
	waitfor Carousel]
	gosub move out
	pause 0.5
	goto FANG_BANK

FANG_BANK:
put #echo >Log DarkBlue,LightYellow (moneyhunt) HUNT_DONE_BANK
  gosub go_room exchange
fang_78:
  put excd
  pause
  gosub go_room teller
  pause
fang_90:
  put depall
  pause 2
  put withdraw 10 plat dok
  pause
  goto NEXT_LOOP

NEXT_LOOP:
	gosub go_room JISI
LORE_OR_BATTLE:
	matchre BATTLE_POUCH ^battle|^money
	matchre LORE_POUCH ^lore|^prospect
	echo put #parse battle or #parse lore to determine next loop
	matchwait 20
	goto LORE_OR_BATTLE

#GOTO BATTLE_POUCH
#GOTO LORE_POUCH

## swap pouches for prospect / lumberjacking (set a global for this state)
LORE_POUCH:
put #echo >Log DarkBlue,LightYellow (moneyhunt) LORE_POUCH
	gosub POUCH_TYPE
	if "$pouch" = "lore" then goto LORE_POUCH_DONE
	gosub go_room vault
	put go third arch
	waitfor Carousel Chamber]
	pause
	gosub get my treatise
	gosub put my treatise in my backpack
	gosub get my almanac
	gosub put my almanac in my backpack
	pause 0.5
	put remove my bright pouch
	gosub put bright pouch in middle drawer
	gosub get bright.pouch from bottom drawer
	put wear my bright.pouch
	pause 0.5
	gosub POUCH_TYPE
	put close vault
	waitfor Carousel]
	pause 0.5
	gosub move out
	goto LORE_POUCH_DONE

LORE_POUCH_DONE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) LORE_POUCH_DONE
## check brush and deed packet supplies
	gosub go_room forging tools

fang_215:
TOOLS_CHECK:
BRUSH_CHECK_0:
    match BRUSH_CHECK_DONE You tap an iron wire brush inside your
    match BRUSH_CHECK_BUY I could not find what you were referring to
    put tap my third iron.brush in my bright.pouch
    matchwait 3
    goto BRUSH_CHECK_DONE

BRUSH_CHECK_BUY:
    if $roomid != 215 then gosub go_room 215
    put .order 10 1
    waitfor All bought!
    goto BRUSH_CHECK_0
	
BRUSH_CHECK_DONE:
OIL_CHECK_0:
    match OIL_CHECK_DONE You tap a flask of oil inside your
    match OIL_CHECK_BUY I could not find what you were referring to
    put tap my third oil in my bright.pouch
    matchwait 3
    goto OIL_CHECK_DONE

OIL_CHECK_BUY:
    if $roomid != 215 then gosub go_room 215
    put .order 6 1
    waitfor All bought!
    goto OIL_CHECK_0
	
OIL_CHECK_DONE:	
	gosub go_room deeds

fang_203:
DEED_CHECK:
PACKET_CHECK_0:
    match PACKET_CHECK_DONE You tap a large packet of deed claim forms inside your
    match PACKET_CHECK_BUY I could not find what you were referring to
    put tap my second deed.packet in my bright.pouch
    matchwait 3
    goto PACKET_CHECK_DONE

PACKET_CHECK_BUY:
    if $roomid != 409 then gosub go_room 409
    put .order 3 1
    waitfor All bought!
    goto PACKET_CHECK_0
	
PACKET_CHECK_DONE:
	goto PROSPECT_READY

PROSPECT_READY:
put #echo >Log DarkBlue,LightYellow (moneyhunt) PROSPECT_READY
## ptravel order: Crossing, Aesry, Shard, Merkresh, Kresh, Riverhaven, Ratha, Elbain's, Theren, Muspari, Hibanevergonnaspellitright
## prospect / lumberjacking all the places
	gosub go_room 63

fang_63:
fang_64:
FANG_MINING:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_MINING
	put .prospect scan
 	waitfor Script Done
fang_7:
	gosub go_room 96
	goto FANG_LUMBER

fang_96:
FANG_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_LUMBER
	put .forest scan
 	waitfor Script Done
 	goto FANG_TO_CROSSINGG

FANG_TO_CROSSING:
put #echo >Log DarkBlue,LightYellow (moneyhunt) FANG_TO_CROSSING
	gosub go_room portal
	gosub move go exit.portal
	gosub go_room west

CROSSWEST_1:
CROSSWEST_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSWEST_LUMBER
	put .forest scan
 	waitfor Script Done

CROSSWEST_to_CROSSNORTH:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSWEST_to_CROSSNORTH
	gosub go_room n gate
CROSSNORTH_113:
	gosub go_room 22
CROSSNORTH_22:
CROSSNORTH_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSNORTH_LUMBER
	put .forest scan
 	waitfor Script Done

CROSSNORTH_TO_NTR:
put #echo >Log DarkBlue,LightYellow (moneyhunt) CROSSNORTH_TO_NTR
	gosub go_room ntr
ntr_318:
NTR_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) NTR_LUMBER
	put .forest scan
 	waitfor Script Done
NTR_TO_STONE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) NTR_TO_STONE
	gosub go_room Stone Clan
STONE_CLAN_MINING:
STONE_1:
STONE_2:
put #echo >Log DarkBlue,LightYellow (moneyhunt) STONE_CLAN_MINING
	put .prospect scan
	waitfor Script Done
	gosub go_room NTR
ntr_395:
	gosub go_room Dirge
	gosub go_room 14
	goto DIRGE_MINE
dirge_14:
DIRGE_MINE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_MINE
	put .prospect scan
	waitfor Script Done
dirge_2:
	GOTO DIRGE_TO_SHARD
#DIRGE_LUMBER:
#put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_LUMBER
#	put .forest scan
# 	waitfor Script Done
DIRGE_TO_SHARD:
put #echo >Log DarkBlue,LightYellow (moneyhunt) DIRGE_TO_SHARD
	gosub go_room ntr
	gosub go_room crossing
	put .ptravel shard
  	waitfor Done Portalhax

shard_146:
SHARDBANK_TO_SHARDSOUTH:
put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDBANK_TO_SHARDSOUTH
	gosub go_room south gate

shardsouth_2:
SHARDSOUTH_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDSOUTH_LUMBER
	put .forest scan
 	waitfor Script Done
 SHARDSOUTH_TO_ICECAVE:
 put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDSOUTH_TO_ICECAVE
 	gosub go_room ice caves
icecave_31:
ICECAVE_MINE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) ICECAVE_MINE
	put .prospect scan
	waitfor Script Done
icecave_2:
	gosub go_room shard south
shardsouth_34:
	gosub go_room sgate
SHARD_TO_SHARDWEST:
put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARD_TO_SHARDWEST
	gosub go_room west gate
shardwest_10:
SHARDWEST_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDWEST_LUMBER
	put .forest scan
 	waitfor Script Done
#SHARDWEST_TO_SHARDNORTH:
#put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDWEST_TO_SHARDNORTH
# 	gosub go_room STR
#shardnorth_
#SHARDNORTH_LUMBER:
#put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARDNORTH_LUMBER
#	put .forest scan
shardnorth_39:
SHARD_TO_RIVER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) SHARD_TO_RIVER
 	waitfor Script Done
 	gosub go_room egate
 	put .ptravel river
  	waitfor Done Portalhax

river_73:
RIVER_TO_RIVERNORTH:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVER_TO_RIVERNORTH
	gosub go_room n gate
rivernorth_2:
RIVERNORTH_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVERNORTH_LUMBER
	put .forest scan
 	waitfor Script Done
river_48:
RIVERNORTH_TO_RIVERWEST:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVERNORTH_TO_RIVERWEST
	gosub go_room riverhaven
river_26:
	gosub go_room w gate
riverwest_2:
RIVERWEST_MINING:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVERWEST_MINING
	put .prospect scan
	waitfor Script Done
riverwest_135:
RIVERWEST_TO_RIVER2THEREN:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVERWEST_TO_RIVER2THEREN
	gosub go_room theren
river2theren_30:
RIVER2THEREN_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVER2THEREN_LUMBER
	put .forest scan
 	waitfor Script Done
river2theren_14:
RIVERWEST_TO_RIVER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVERWEST_TO_RIVER
	gosub go_room riverhaven
riverwest_27:
	gosub go_room riverhaven

river_1:
RIVER_TO_THEREN:
put #echo >Log DarkBlue,LightYellow (moneyhunt) RIVER_TO_THEREN
## Theren / Marauders / Rossman's Lumberjacking
	put .ptravel theren
  	waitfor Done Portalhax

## Theren / Rauders / Rossmans
theren_141:
THEREN_LUMBER:
put #echo >Log DarkBlue,LightYellow (moneyhunt) THEREN_LUMBER
	put .forest scan
 	waitfor Script Done

theren_199:
THEREN_TO_HIB:
put #echo >Log DarkBlue,LightYellow (moneyhunt) THEREN_TO_HIB
	put .ptravel hib
  	waitfor Done Portalhax

hib_75:
HIB_TO_AIN:
put #echo >Log DarkBlue,LightYellow (moneyhunt) HIB_TO_AIN
  gosub go_room travel start point
  put .travel ain.ghazil 34
  waitfor REACHED YOUR DESTINATION
  pause
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left

ain_34:
AIN_MINE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) AIN_MINE
	put .prospect scan
	waitfor Script Done

ain_17:
AIN_TO_HAWK:
put #echo >Log DarkBlue,LightYellow (moneyhunt) AIN_TO_HAWK
	put .travel hib 1
	waitfor REACHED YOUR DESTINATION
	pause
	if "$righthand" != "Empty" then put stow right
	if "$lefthand" != "Empty" then put stow left

hib_1:
	gosub go_room e gate
	gosub go_room mine
hawk_24:
HAWK_MINE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) HAWK_MINE
	put .prospect scan
	waitfor Script Done

hawk_32:
HAWK_TO_HIB:
put #echo >Log DarkBlue,LightYellow (moneyhunt) HAWK_TO_HIB
	gosub go_room hib
	gosub DAMAGE_CHECK
	if %armor_damage = 1 then gosub ITEM_REPAIR
	gosub go_room portal
	gosub move go meeting.portal
	GOTO BATTLE_POUCH

## swap back pouches for combat (set a global for this state)
BATTLE_POUCH:
put #echo >Log DarkBlue,LightYellow (moneyhunt) BATTLE_POUCH
	gosub POUCH_TYPE
	if "$pouch" = "battle" then goto BATTLE_POUCH_DONE
	gosub go_room vault
	put go third arch
	waitfor Carousel Chamber]
	pause
	put store default my backpack
	pause 0.5
	gosub get my treatise
	gosub put my treatise in my backpack
	gosub get my almanac
	gosub put my almanac in my backpack
	pause 0.5
	put remove my bright pouch
	gosub put bright pouch in bottom drawer
	gosub get bright.pouch from middle drawer
	put wear my bright.pouch
	pause 0.5
	gosub POUCH_TYPE
	put close vault
	waitfor Carousel]
	pause 0.5
	gosub move out
	goto BATTLE_POUCH_DONE

BATTLE_POUCH_DONE:
put #echo >Log DarkBlue,LightYellow (moneyhunt) BATTLE_POUCH_DONE
	gosub go_room portal
	gosub move go exit.portal
	goto ARMOR_CHECK

## armor fix
ARMOR_CHECK:
put #echo >Log DarkBlue,LightYellow (moneyhunt) ARMOR_CHECK
	gosub DAMAGE_CHECK
	if %armor_damage = 1 then gosub ITEM_REPAIR
	if $zoneid != 1 then
	{
		put .ptravel crossing
		waitfor Done Portalhax
	}
	else put .moneyhunt


### GOSUBS

POUCH_TYPE:
	match LOREPOUCH An elegant droluger-hide cover protects the vast accumulation of crafting lore contained within.
	match BATTLEPOUCH I could not find what you were referring to.
	put look at book in my bright pouch
	matchwait 5
	goto POUCH_TYPE

LOREPOUCH:
	put #var pouch lore
	send store default bright.pouch
	return
BATTLEPOUCH:
	put #var pouch battle
	send store default backpack
	return

DAMAGE_CHECK:
  var armor_damage 0
  action (damage) var armor_damage 1 when practically in mint condition|in good condition|rather scuffed up|some minor scratches|a few dents and dings|several unsightly notches|heavily scratched and notched|badly damaged|battered and practically destroyed
  action (damage) var armor_damage 0 when in pristine condition
  action (damage) on
  pause 0.5
  put appraise my $buckler quick
  pause 3
  action (damage) off
  return

ITEM_REPAIR:
  if $zoneid != 16 then
  {
    put .ptravel hib
    waitfor Done Portalhax
  }
  gosub go_room ladar
  put .repairstuff ladar
  waitfor Stuff Repaired
  if $zoneid != 1 then
  {
    put .ptravel crossing
    waitfor Done Portalhax
  }
  return

BUNDLE_VAULT:
  match BUNDLE_SHELF You tap a
  match RETURN I could not find what you were referring to.
  put tap my tight.bundle
  matchwait 2
  goto BUNDLE_VAULT

BUNDLE_SHELF:
  gosub get my tight.bundle
  gosub put my tight.bundle on small.shelf
  goto BUNDLE_VAULT

BUNDLE_PORTAL:
  match BUNDLE_PORTAL_SHELF You tap a
  match RETURN I could not find what you were referring to.
  put tap my tight.bundle in my portal
  matchwait 2
  goto BUNDLE_PORTAL

BUNDLE_PORTAL_SHELF:
  gosub get my tight.bundle from my portal
  gosub put my tight.bundle on small.shelf
  goto BUNDLE_PORTAL

BUNDLE_ROPE:
  gosub go_room bundle
  BUNDLE_ROPE_1:
    match RETURN You tap some
    match BUNDLE_ROPE_ASK I could not find what you were referring to.
    put tap my third bundling.rope
    matchwait 2
    goto BUNDLE_ROPE_1
  BUNDLE_ROPE_ASK:
    put ask clerk for bundling rope;ask attendant for bundling rope
    pause 0.5
    gosub put my bundling rope in my backpack
    goto BUNDLE_ROPE_1

BUNDLE_SELL:
  gosub go_room bundle
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  pause
  put remove my bundle
  pause
  put get moth.antenna from my bundle;get drake.fang from my bundle;get drake.hide from my bundle
  pause
  put sell my bundle
  pause
  put bundle
  pause
  put wear my bundle
  pause
  return

POUCH_LOOT:
	gosub POUCH_CHECKING map
	gosub POUCH_CHECKING package
	gosub POUCH_CHECKING scroll
	gosub POUCH_CHECKING tablet
	gosub POUCH_CHECKING card
	gosub POUCH_CHECKING vellum 
	gosub POUCH_CHECKING sheiska.leaf
	gosub POUCH_CHECKING ostracon
	gosub POUCH_CHECKING bark
	gosub POUCH_CHECKING papyrus.roll
	gosub POUCH_CHECKING smudged.parchment
	return

POUCH_CHECKING:
	var object $1
  	match POUCH_LOOTING You tap a
  	match CARRY_CHECKING I could not find what you were referring to.
  	put tap %object in my bright.pouch
  	matchwait 2
  	goto POUCH_CHECKING

POUCH_LOOTING:
	gosub get %object from my bright.pouch
	gosub put my %object in my backpack
	goto POUCH_CHECKING

CARRY_CHECKING:
  	match CARRY_LOOTING You tap a
  	match RETURN I could not find what you were referring to.
  	put tap %object in my carryall
  	matchwait 2
  	goto CARRY_CHECKING

CARRY_LOOTING:
	gosub get %object from my carryall
	gosub put my %object in my backpack
	goto CARRY_CHECKING

POUCH_VAULT:
  match POUCH_SHELF You tap a
  match RETURN I could not find what you were referring to.
  put tap gem.pouch in my kirmiko.pocket
  matchwait 2
  goto POUCH_VAULT

POUCH_SHELF:
  gosub get gem.pouch from my kirmiko.pocket
  gosub put my gem.pouch on small.shelf
  goto POUCH_VAULT

POUCH_PORTAL:
  match POUCH_PORTAL_SHELF You tap a
  match RETURN I could not find what you were referring to.
  put tap gem.pouch in my portal
  matchwait 2
  goto POUCH_PORTAL

POUCH_PORTAL_SHELF:
  gosub get gem.pouch from my portal
  gosub put my gem.pouch on small.shelf
  goto POUCH_PORTAL

GEM_SELL:
  NUGG_SELL:
    matchre NUGG_SELL ^You drop|^You put|^You reverently place|then hands you
    matchre CARD_CLEAN ^What were you referring to\?
    put get my nugget;sell my nugget
    matchwait 2
    goto NUGG_SELL

  CARD_CLEAN:
    gosub get my collector.case
  CARD_CLEAN_1:
    matchre CARD_CLEAN_1 ^You drop|^You slide
    match CARD_CLEAN_2 You must have a card in your left hand to do that.
    put get my card;card add;put my card in bucket;drop my card
    matchwait 2
    goto CARD_CLEAN_1
  CARD_CLEAN_2:
    gosub put my collector.case in my backpack
    goto DIRA_CLEAN

  DIRA_CLEAN:
    gosub get my coin.case
  DIRA_CLEAN_1:
    matchre DIRA_CLEAN_1 ^You drop|^You slide
    match DIRA_CLEAN_2 You'll need an Imperial dira
    put get my dira;dira add;put my dira in bucket;drop my dira
    matchwait 2
    goto DIRA_CLEAN_1
  DIRA_CLEAN_2:
    gosub put my coin.case in my backpack

  POUCH_CHECK:
    match RETURN You tap a
    match POUCH_ASK I could not find what you were referring to.
    put tap fourth gem.pouch in my backpack
    matchwait 2
    goto POUCH_CHECK

  POUCH_ASK:
    put ask rasiya for gem pouch;ask wickett for gem pouch;ask attendant for gem pouch
    pause 0.2
    put ask gem for gem pouch
    pause 0.5
    gosub put my gem pouch in my backpack
    goto POUCH_CHECK

SKIN_COUNT:
	var skincount 0
	action var skincount $1 when ^You flip through the lumpy bundle and find (\d+) \w+ in it\.
	pause
	put -count my lumpy bundle
	pause 3
	return

TATTOO_CHECK:
	if ("$heroic_tattoo" = "off") && ($gametime >= $tattootime) then
	{
		pause 0.1
		put invoke my tattoo
	}
	return