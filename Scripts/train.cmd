#debug 5
put #echo >Log DarkBlue,LightYellow Starting Training.
var TRAIN_LOCATION CROSSING|FANG|SHARD
var TRAIN_LOCATION_MAX 0
var TRAIN_LOCATION_COUNT $train_location_count
#put #echo >Log DarkBlue,LightYellow (train) TRAIN_LOCATION %TRAIN_LOCATION($train_location_count)
put .rexp
put #var symbiosis 1

gosub POUCH_TYPE
if "$pouch" = "lore" then
{
  echo WRONG BRIGHT POUCH
  exit
}
var wounded 0
put #var humming 0
put #class afk False
put #class arena False
put #class arrive False
put #class chatter True
put #class circuit False
put #class combat True
put #class cornmaze False
put #class decayed False
put #class default True
put #class disabled False
put #class dolphin False
put #class drx True
put #class first_aid True
put #class forest False
put #class highlight True
put #class hunt_timer True
put #class joust False
put #class mana False
put #class maneuver_timers True
put #class racial False
put #class reminder True
put #class rp False
put #class ryken True
put #class shortwounds False
put #class silence False
put #class spawn_timer True
put #class spelltrack True
put #class tarantula_timer True
put #class tattoo_timer True
put #class wounds False

#action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
gosub SKIN_COUNT
put awaken

if contains("$scriptlist", "geniehunter.cmd") then goto MAP_CHECK

gosub health_check
put stance set $normalstance
put #var save


# $train_hunt 1
put store default backpack

pause 0.5
put wear my $shield
pause 0.5
put stow;stow left
pause 0.5

goto map_check

### Includes & GOSUBS
include includes.cmd

  
MAP_CHECK:
put #echo >Log DarkBlue,LightYellow (train) MAP_CHECK
  var location unknown
  if "$zoneid" = "1" then var location crossing
  if "$zoneid" = "4" then var location crossw
  if "$zoneid" = "6" then var location crossn
  if "$zoneid" = "7" then var location ntr
  if "$zoneid" = "10" then var location stone
  if "$zoneid" = "13" then var location dirge
  if "$zoneid" = "65" then var location undergondola
  if "$zoneid" = "66" then var location shardn
	if "$zoneid" = "67" then var location shard
	if "$zoneid" = "69" then var location shardwest
  if "$zoneid" = "107" then var location kresh
  if "$zoneid" = "150" then var location fang
  if "$zoneid" = "116" then var location hib
  if "$roomname" = "Private Home Interior" then var location home
  
  if "%location" = "unknown" then
  {
    put #echo Unknown Zone
    exit
  }

ROOM_CHECK:
put #echo >Log DarkBlue,LightYellow (train) ROOM_CHECK
  var home_rooms 0
  var crossing_rooms 51|50|468|469|470|472|483|487|488|473|476|146
  var crossw_rooms 1|117
  var crossn_rooms 22|2
  var dirge_rooms 68|69|70|186|187|188|189|301|302|14|51|141|215|217|218|142|139
  var ntr_rooms 318|268
  var stone_rooms 1|2
  var kresh_rooms 78|77|43
  var fang_rooms 85|87|89|88|7|137|222
  var undergondola_rooms 2|41
  var shard_rooms 146|148|248|206|207|43
  var shardwest_rooms 10|15|37|14|391|392|395|460|476|481|535|231|320
  var shardn_rooms 65|70|163|39
  var hib_rooms 75|17|159|163|164|193|218|298|314|386|407|409|410|411|412|413|418|427|432|116|96|287
	if contains("|%%location_rooms|", "|$roomid|") then goto %location_$roomid

	else
  {
    put #echo >Log Red,LightYellow Unhandled roomid: %location_$roomid
    gosub go_room %%location_rooms(0)
  }
	goto room_check


### Hunting
crossing_50:
fang_89:
HUNT_PREP:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP
  put #echo >Log DarkBlue,LightYellow Going Hunting!
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left
  # check wounds
HUNT_PREP_WOUNDS:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_WOUNDS
  var wounded 0
  gosub health_check
  pause 0.5
  if %wounded = 0 then goto HUNT_PREP_REPAIR
  if $zoneid = 150 then goto HUNT_PREP_WOUNDS_1
  gosub go_room portal
  gosub move go meeting.portal
HUNT_PREP_WOUNDS_1:
  if %wounded = 1 then gosub fang_HEALER
HUNT_PREP_VAULT:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_VAULT
  # drop off bright pouch & any tight bundles / gem pouches
  gosub go_room 87
  gosub move go cave.mouth
  put go third arch
  waitfor Carousel Chamber]
  gosub POUCH_TYPE
  pause 0.5
  gosub POUCH_VAULT
  pause 0.5
  gosub POUCH_PORTAL
  pause 0.5
  gosub BUNDLE_VAULT
  pause 0.5
  gosub BUNDLE_PORTAL
  pause 0.5
  if "$pouch" = "lore" then 
  {
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
    gosub get bright.pouch
    put wear my bright.pouch
    pause 0.5
    gosub POUCH_TYPE
  }
  put close vault
  waitfor Carousel]
  pause 0.5
  gosub move out
HUNT_PREP_SUPPLIES:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_SUPPLIES
  # make sure we have enough bundling ropes and pouches / sell nuggets / cards / dira
  gosub BUNDLE_ROPE
HUNT_PREP_BANK:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_BANK
  gosub go_room exchange
  put excd
  pause
  gosub go_room teller
  pause 
  put depall
  pause 2
  put withdraw 10 plat dok
  pause
  ## Back to Crossing
  gosub go_room portal
  gosub move go exit.portal
HUNT_PREP_REPAIR:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_REPAIR
  # repairstuff
  gosub ALMANAC_CHECK
  if ("$righthandnoun" = "almanac" || "$lefthandnoun" = "almanac") then gosub put my almanac in my backpack
  if ("$righthandnoun" = "treatise" || "$lefthandnoun" = "treatise") then gosub put my treatise in my backpack
  gosub DAMAGE_CHECK
  if %armor_damage = 1 then gosub ITEM_REPAIR
HUNT_TO_PERF:
put #echo >Log DarkBlue,LightYellow (train) HUNT_TO_PERF
  if $zoneid = 150 then
  {
    gosub go_room portal
    gosub move go meeting.portal
  }
  if $zoneid != 1 then
  {
    put .ptravel crossing
    waitfor Done Portalhax
  }
  goto HUNT_FIGHT_PREP

HOME_0:
  if $standing != 1 then put stand
  pause 0.5
#  put unlock door
#  pause 0.5
#  put open door
#  pause 0.5
#  put go door
#  pause 0.5
  #if $humming = 0 then put hum concerto masterful
  gosub move move door
  goto map_check
SHARDWEST_395:
HOUSE_TO_DRAKES:
  if $Attunement.LearningRate < 32 then put #var powerwalk 1
  gosub go_room shard
  goto HUNT_FIGHT_PREP

HUNT_FIGHT_PREP:
TRAVEL_TO_CROSSING:
  if $zoneid != 1 then
  {
    put .ptravel crossing
    waitfor Done Portalhax
  }
# Crossing Exit Portal
crossing_483:
crossing_468:
  put .rexp
  if $roomid != 468 then gosub go_room 468
  gosub BURGLE_CHECK
  if %burgling = 0 then goto HUNT_PRE_BARD
BURGLE_GO:
  put #echo >Log DarkBlue,LightYellow Burgling Time!
  put stop hum
  gosub go_room West
  if $Attunement.LearningRate < 32 then put #var powerwalk 1
  gosub go_room Tiger
  var burgling 0
  put .burgle
  waitfor SCRIPT FINISHED!
  if $humming = 0 then put hum concerto masterful
  gosub go_room Gate
  gosub go_room Crossing
  if $Attunement.LearningRate < 32 then put #var powerwalk 1
  gosub go_room Bard
#Prop room is 472, Conservancy is 473, Keg Alcove is 474, Balcony is 475
  gosub move go portal
crossing_470:
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  put get shakers from my sash;put shakers in bucket
  pause 0.5
  put get shakers from my sash;put shakers in bucket
  pause 0.5
  put get shakers from my sash;put shakers in bucket
  pause 0.5
  put .moveitems sash bucket
  waitfor Done Moving Items.
  put stop hum
  put practice breathing
  waitforre ^Your actions interrupt your practicing|^Try as you might, you are unable|^Finally, you open your eyes\.|^You hold your head straight up
  pause 2
  if ($Augmentation.LearningRate < 10 || $Utility.LearningRate < 10 || $Warding.LearningRate < 10) then gosub go_room 473
  else goto HUNT_PRE_BARD
crossing_473:
  if ($Augmentation.LearningRate < 10 || $Utility.LearningRate < 10 || $Warding.LearningRate < 10) then goto BARD_RESEARCH
  else goto HUNT_PRE_BARD
BARD_RESEARCH:
put #echo >Log DarkBlue,LightYellow (train) BARD_RESEARCH
  if $SpellTimer.BlessingoftheFae.active = 0 then
  {
    put .cast botf 25
    waitfor Spell Cast
  }
  if $Augmentation.LearningRate < 10 then
  {
    put .research set 100 Augmentation
    pause 0.1
    put .research
    waitfor Done Research
  }
  if $Utility.LearningRate < 10 then
  {
    put .research set 100 Utility
    pause 0.1
    put .research
    waitfor Done Research
  }
  if $Warding.LearningRate < 10 then
  {
    put .research set 100 Warding
    pause 0.1
    put .research
    waitfor Done Research
  }
  put release cyclic
HUNT_PRE_BARD:
  put #echo >Log DarkBlue,LightYellow (train) HUNT_PRE_BARD
  if $humming = 0 then put hum concerto masterful
  goto HUNT_PRE_MINE
HUNT_PRE_MINE:
  put #echo >Log DarkBlue,LightYellow (train) HUNT_PRE_MINE
  gosub go_room NEGATE
  pause 0.5
  #if $Outdoorsmanship.LearningRate >= 30 then goto NTR_395
  goto NTR_395
NTR_268:
  goto NTR_395
#  gosub go_room Stone Clan
#STONE_CLAN_MINING:
#STONE_1:
#  put #echo >Log DarkBlue,LightYellow (train) STONE_CLAN_MINING
#STONE_2:
#  put .prospect scan
#  waitfor Script Done
#  gosub go_room NTR
NTR_395:
  if $Attunement.LearningRate < 32 then put #var powerwalk 1
  gosub go_room Dirge
dirge_70:
  #if $Outdoorsmanship.LearningRate >= 30 then goto HUNT_BARD_FIGHT
  goto HUNT_BARD_FIGHT
#DIRGE_MINE:
#  put #echo >Log DarkBlue,LightYellow (train) DIRGE_MINE
#  put .prospect scan
#  waitfor Script Done
dirge_14:
HUNT_BARD_FIGHT:
put #echo >Log DarkBlue,LightYellow (train) HUNT_BARD_FIGHT
  if $humming = 0 then put hum concerto masterful
  gosub go_room 51
### Change to moths, room 215 (ara in 216)
### prep room 51/141
  goto FIGHT_1_PREP
FIGHT_1_PREP:
dirge_51:
put #echo >Log DarkBlue,LightYellow (train) FIGHT_1_PREP
  if $humming = 0 then put hum concerto masterful
  if $roomid != 51 then gosub go_room 51
  gosub ALMANAC_CHECK
  if ("$righthandnoun" = "almanac" || "$lefthandnoun" = "almanac") then gosub put my almanac in my backpack
  if ("$righthandnoun" = "treatise" || "$lefthandnoun" = "treatise") then gosub put my treatise in my backpack
  put .armor on clown
  waitfor Script Done
  pause 2
  put .fight prep soul moths
  waitfor FIGHT PREPPED
  gosub TATTOO_CHECK
  gosub go_room 141
dirge_141:
  if $roomid != 141 then gosub go_room 141
  put .cast aban 5 creature
  waitfor Spell Cast
  gosub ALMANAC_CHECK
  if ("$righthandnoun" = "almanac" || "$lefthandnoun" = "almanac") then gosub put my almanac in my backpack
  if ("$righthandnoun" = "treatise" || "$lefthandnoun" = "treatise") then gosub put my treatise in my backpack
  goto FIGHT_1
FIGHT_1:
dirge_215:
put #echo >Log DarkBlue,LightYellow (train) FIGHT_1
  if contains("$scriptlist", "geniehunter.cmd") then goto FIGHT_CYCLE_CHECK_1
  if $roomid != 215 then gosub go_room 215
  put stop hum
  put .armor on clown
  waitfor Script Done
  put #var train_hunt 0
  # fight for one cycle
  put .fight moths
  pause 0.5
  put .cast nexus 30 35 35
  waitfor Spell Cast
  put .geniehunter multi 1
  pause 2
  put .gh_watch
  FIGHT_CYCLE_CHECK_1:
    waitfor Geniehunter Done.
  if ($train_gh_cycle_num = $GH_MULTI_CURR_NUM) then put #script abort geniehunter
  else goto FIGHT_CYCLE_CHECK_1
  put #var train_gh_cycle_num $GH_MULTI_CURR_NUM
  goto FIGHT_DONE_1
FIGHT_DONE_1:
dirge_142:
put #echo >Log DarkBlue,LightYellow (train) FIGHT_DONE_1
  put #echo >Log DarkBlue,LightYellow Done Hunting!
  put #var train_hunt 0
  put #script abort all except train
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
  #gosub go_room 69
  #goto DIRGE_PERF
  goto FIGHT_DONE_2

dirge_69:
DIRGE_PERF:
  # if $Performance.LearningRate < 31 then gosub reckus
dirge_68:
  gosub ALMANAC_CHECK
  if $roomid != 68 then gosub go_room 68
  if ("$righthandnoun" = "almanac" || "$lefthandnoun" = "almanac") then gosub put my almanac in my backpack
  if ("$righthandnoun" = "treatise" || "$lefthandnoun" = "treatise") then gosub put my treatise in my backpack
  put .armor on clown
  waitfor Script Done
  pause 2
  put .fight reprep soul moths
  waitfor FIGHT PREPPED
  gosub TATTOO_CHECK
  gosub go_room 215
  goto FIGHT_1

dirge_217:
### Change to moths, room 217 (ara in 216)
FIGHT_2:
put #echo >Log DarkBlue,LightYellow (train) FIGHT_2
  if contains("$scriptlist", "geniehunter.cmd") then goto FIGHT_CYCLE_CHECK_2
  if $roomid != 217 then gosub go_room 217
  put .armor on clown
  waitfor Script Done
  put #var train_hunt 0
  # fight for one cycle
  put .fight secondary
  pause 0.5
  put .cast pyre 5 creature
  waitfor Spell Cast
  put .cast nexus 30 35 35
  waitfor Spell Cast
  put .geniehunter multi 1
  pause 2
  put .gh_watch
  FIGHT_CYCLE_CHECK_2:
    waitfor Geniehunter Done.
  if ($train_gh_cycle_num = $GH_MULTI_CURR_NUM) then put #script abort geniehunter
  else goto FIGHT_CYCLE_CHECK_2
  put #var train_gh_cycle_num $GH_MULTI_CURR_NUM
  goto FIGHT_DONE_2

FIGHT_DONE_2:
dirge_139:
put #echo >Log DarkBlue,LightYellow (train) DRAKES_DONE
  #put #echo >Log DarkBlue,LightYellow Done Hunting!
  if $humming = 0 then put hum concerto masterful
  put #var train_hunt 0
  put #script abort all except train
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
  put release cyclic
  gosub go_room NTR
  put release cyclic
  gosub go_room Crossing
  gosub go_room 469
  goto HUNT_DONE_RETURN

HUNT_DONE_RETURN:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_RETURN
crossing_469:
  if $humming = 0 then put hum concerto masterful
  put .armor swap main
  waitfor Script Done
  pause
  put .rexp
  pause
  put .collect
  waitfor Script Done
  pause
  put stop hum
  put practice stretching
  waitforre ^Your actions interrupt your practicing|^Try as you might, you are unable|^Finally, you open your eyes\.|^You hold your head straight up
  pause 2
  if $Sorcery.LearningRate > 30 then goto HUNT_POST_FANG
  if $roomid != 472 then gosub go_room 472
crossing_472:
HUNT_POST_SORCERY:
put #echo >Log DarkBlue,LightYellow (train) HUNT_POST_SORCERY
  if $Sorcery.LearningRate > 30 then goto HUNT_POST_FANG
  if ($Augmentation.LearningRate < 10 || $Utility.LearningRate < 10 || $Warding.LearningRate < 10) then goto BARD_RESEARCH_2
  else goto BARD_SORCERY
BARD_RESEARCH_2:
put #echo >Log DarkBlue,LightYellow (train) BARD_RESEARCH_2
  if $SpellTimer.BlessingoftheFae.active = 0 then
  {
    put .cast botf 25
    waitfor Spell Cast
  }
  if $Augmentation.LearningRate < 10 then
  {
    put .research set 100 Augmentation
    pause 0.1
    put .research
    waitfor Done Research
  }
  if $Utility.LearningRate < 10 then
  {
    put .research set 100 Utility
    pause 0.1
    put .research
    waitfor Done Research
  }
  if $Warding.LearningRate < 10 then
  {
    put .research set 100 Warding
    pause 0.1
    put .research
    waitfor Done Research
  }
BARD_SORCERY:
put #echo >Log DarkBlue,LightYellow (train) BARD_SORCERY
  put .sorcery
  waitfor Sorcery Complete
  put release cyclic
  put unhide
  pause 0.5
  gosub health_check
  pause 0.5
HUNT_POST_FANG:
put #echo >Log DarkBlue,LightYellow (train) HUNT_POST_FANG
  pause 0.5
  put practice assessment dance
  pause 2
  if $humming = 0 then put hum concerto masterful
  gosub go_room portal
  gosub move go meeting.portal
fang_88:
HUNT_DONE_SUPPLIES:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_SUPPLIES
  if $humming = 0 then put hum concerto masterful
  # stay in FC so we're in doks
  # make sure we have enough bundling ropes and pouches / sell nuggets / cards / dira
fang_137:
  if $humming = 0 then put hum concerto masterful
  gosub SKIN_COUNT
  if %skincount > 5 then gosub BUNDLE_SELL
  gosub BUNDLE_ROPE
  gosub go_room gem
  gosub GEM_SELL
HUNT_DONE_BANK:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_BANK
  if $humming = 0 then put hum concerto masterful
  gosub go_room exchange
  put excd
  pause
  gosub go_room teller
  pause 
  put depall
  pause 2
  put withdraw 10 plat dok
  pause
HUNT_DONE_VAULT:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_VAULT
  if $humming = 0 then put hum concerto masterful
  # drop off bright pouch & any tight bundles / gem pouches
  gosub go_room 87
  gosub move go cave.mouth
  put go third arch
  waitfor Carousel Chamber]
  pause 0.5
  gosub POUCH_VAULT
  pause 0.5
  gosub POUCH_PORTAL
  pause 0.5
  gosub BUNDLE_VAULT
  pause 0.5
  gosub BUNDLE_PORTAL
  pause 0.5
  gosub QUIVER_VAULT
  pause 0.5
  put close vault
  waitfor Carousel]
  gosub move out
  pause 0.5
fang_17:
HUNT_DONE_WOUNDS:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_WOUNDS
  # check wounds
  var wounded 0
  gosub health_check
  pause 0.5
  if %wounded = 1 then gosub fang_HEALER
## Back to Crossing
  gosub go_room portal
  gosub move go exit.portal
  gosub go_room 51

crossing_51:
HUNT_DONE_DISSECT:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_DISSECT
  if $humming = 0 then put hum concerto masterful
  if ($Bow.LearningRate > 30) && ($First_Aid.LearningRate > 30) && ($Athletics.LearningRate > 30) then goto HUNT_DONE_REPAIR
  put .ptravel kresh
  waitfor Done Portalhax
  gosub go_room 43
  goto kresh_43

kresh_78:
  gosub go_room 43
kresh_43:
DISSECTING:
if ($Bow.LearningRate > 30) && ($First_Aid.LearningRate > 30) then goto DISSECT_DONE
put #echo >Log DarkBlue,LightYellow (train) DISSECTING
if contains("$scriptlist", "geniehunter.cmd") then goto DISSECT_CYCLE_CHECK
  #put .geniehunter aoe pyre PhoenixsPyre 20 dissect exp lootgem lootcoin lootjunk tattoo timer train worn normal brawl $buckler
  put .fight dissect
  put stop hum
  pause
  put .geniehunter multi 1
  pause 2
  put .gh_watch
  DISSECT_CYCLE_CHECK:
    waitfor Geniehunter Done.
  #if ($train_gh_cycle_num = $GH_MULTI_CURR_NUM) then put #script abort geniehunter
  #else goto DISSECT_CYCLE_CHECK
  #put #var train_gh_cycle_num $GH_MULTI_CURR_NUM  
  if ($Bow.LearningRate < 32) then
  {
    put .geniehunter multi 2
    waitfor Geniehunter Done.
  }
  pause 0.5
  put #script abort all except train
  put rel cyc

shardwest_231:
kresh_77:
DISSECT_DONE:
put #echo >Log DarkBlue,LightYellow (train) DISSECT_DONE
  if $humming = 0 then put hum concerto masterful
  pause 0.5
  put #script abort all except train
  put rel cyc
  put .rexp
  if $Athletics.LearningRate > 30 then
  {
    #gosub go_room shard
    goto HUNT_DONE_REPAIR
  }
  else
  {
    put .ptravel shard
    waitfor Done Portalhax
    gosub go_room ngate   
  }
  goto SHARDN_TO_CLIMB

SHARDWEST_CLIMB:
shardwest_2:
put #echo >Log DarkBlue,LightYellow (train) SHARDWEST_CLIMB
  if $humming = 0 then put hum concerto masterful
  gosub go_room ngate

shardn_65:
shardn_70:
SHARDN_TO_CLIMB:
put #echo >Log DarkBlue,LightYellow (train) SHARDN_TO_CLIMB
  if $humming = 0 then put hum concerto masterful
  gosub go_room undergondola
undergondola_2:
  gosub go_room 41
undergondola_41:
UNDERGONDOLA_CLIMB:
put #echo >Log DarkBlue,LightYellow (train) UNDERGONDOLA_CLIMB
  if $humming = 0 then put hum concerto masterful
  put .climb_practice branch
  waitfor Script Done
  gosub go_room shard
shardn_163:
UNDERGONDOLA_TO_SHARD:
put #echo >Log DarkBlue,LightYellow (train) UNDERGONDOLA_TO_SHARD
  if $humming = 0 then put hum concerto masterful
  gosub go_room ngate

shard_1:
shard_43:
shard_146:
HUNT_DONE_REPAIR:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_REPAIR
  if $humming = 0 then put hum concerto masterful
  # repairstuff
  gosub DAMAGE_CHECK
  if %armor_damage = 1 then gosub ITEM_REPAIR
  else
  {
    put .ptravel crossing
    waitfor Done Portalhax
  }

HUNT_DONE_CYCLE:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_CYCLE
  if $humming = 0 then put hum concerto masterful
  goto map_check


### Hib
hib_314:
  gosub DAMAGE_CHECK
  if $humming = 0 then put hum concerto masterful
  if %armor_damage = 1 then gosub ITEM_REPAIR
  goto HUNT_FIGHT_PREP


### Fang Cove
fang_HEALER:
  if $humming = 0 then put hum concerto masterful
  if $roomid!= 17 then gosub go_room 17
  put join list
  #gosub ALMANAC_CHECK
  waitfor Yrisa crosses Ryken's name from the list
  if ("$righthandnoun" = "almanac" || "$lefthandnoun" = "almanac") then gosub put my almanac in my backpack
  if ("$righthandnoun" = "treatise" || "$lefthandnoun" = "treatise") then gosub put my treatise in my backpack
  pause
  var wounded 0
  return

#fang_222:
#    gosub go_room portal
#    gosub move go exit.portal

### GOSUBS

RECKUS:
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  {
    pause 0.001
    put remove my gloves;put gloves in my portal
    pause 0.001
    put .reckus strings
    waitfor Reckus Complete
    pause 0.001
    put get ring.gloves from my portal;wear my ring.gloves
    if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
    if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  }
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

QUIVER_VAULT:
  match QUIVER_VAULT_GET a brief flash of light emanates from inside.
  matchre return ^Lacking the power to activate|^What were you referring to\?
  put rub quiver on rack
  matchwait 5
  goto QUIVER_VAULT

QUIVER_VAULT_GET:
  put .moveitems quiver.on.rack my.carryall
  waitfor Done Moving Items.
  return

GEM_SELL:
  NUGG_SELL:
    matchre NUGG_SELL ^You drop|^You put|^You reverently place
    matchre CARD_CLEAN ^What were you referring to\?
    put get my nugget;sell my nugget
    matchwait 2
    goto NUGG_SELL

  CARD_CLEAN:
    gosub get my collector.case
  CARD_CLEAN_1:
    match CARD_CLEAN_1 You slide
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
    match DIRA_CLEAN_1 You slide
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

BURGLE_CHECK:
  var burgling 0
  match RETURN You should wait at least
  match BURGLE_CHECK_1 The heat has died down from your last caper.
  put burgle recall
  matchwait 5
  goto BURGLE_CHECK

BURGLE_CHECK_1:
  match BURGLE_TOOMANY You are carrying between 400 and 450 items on you
  match BURGLE_NOW INVENTORY HELP
  put inv check
  matchwait 5
  goto BURGLE_CHECK_1

BURGLE_NOW:
  var burgling 1
  return

BURGLE_TOOMANY:
  put #echo >Log DarkBlue,LightYellow Can't burgle, INV CHECK failed!
  return

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

POUCH_TYPE:
  match LOREPOUCH You tap a
  match BATTLEPOUCH I could not find what you were referring to.
  send tap my pale pouch
  matchwait 5
  goto POUCH_TYPE

LOREPOUCH:
  put #var pouch lore
  #send store default bright.pouch
  return
BATTLEPOUCH:
  put #var pouch battle
  #send store default backpack
  return