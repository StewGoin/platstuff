#debug 5
put #echo >Log DarkBlue,LightYellow Starting Training.

# SHEL --> add shardwest
# AIN --> add Theren
# Riverhaven --> Add River

var TRAIN_LOCATION CROSSING|FANG|SHEL|RIVERHAVEN|SHARD|AIN|CROSSLUMBER|THERENLUMBER
#|LETH|KRESH
var TRAIN_LOCATION_MAX 0
var TRAIN_LOCATION_COUNT $train_location_count
put #echo >Log DarkBlue,LightYellow (train) TRAIN_LOCATION %TRAIN_LOCATION($train_location_count)

var SurfacePolNum 4
var ThreadNum 6
var PinsNum 5
var wounded 0
var hib_startroom 411

#action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
gosub SKIN_COUNT
put awaken

if contains("$scriptlist", "geniehunter.cmd") then goto MAP_CHECK

gosub health_check
put stance set $normalstance
put #var save

if $train_hunt 1 then
{
  put store default backpack
}
else
{
  put store default bright.pouch
}
put #var train_loreOnly 0
if "%1" = "lore" then put #var train_loreOnly 1
# always circleOnly for now
put #var train_circleOnly 1
if "%1" = "circle" then put #var train_circleOnly 1

pause 0.5
put wear my $shield
pause 0.5
put stow;stow left
pause 0.5

goto map_check

### Includes & GOSUBS
include includes.cmd

### Lore things
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
ORIGAMI:
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  if $Outfitting.LearningRate < 31 then
  {
    put .origami
    waitfor Origami Complete
    if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
    if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  }
  return

#LOCKS:
#  put .locks
#  waitfor Done Locks
#  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
#  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
#  return
  
MAP_CHECK:
put #echo >Log DarkBlue,LightYellow (train) MAP_CHECK
  var location unknown
  if "$zoneid" = "1" then var location crossing
  if "$zoneid" = "4" then var location crossw
  if "$zoneid" = "6" then var location crossn
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
  if "$zoneid" = "66" then var location shardn
	if "$zoneid" = "67" then var location shard
	if "$zoneid" = "68" then var location shardsouth
	if "$zoneid" = "69" then var location shardwest
	if "$zoneid" = "68a" then var location icecave
  if "$zoneid" = "114" then var location ain
  if "$zoneid" = "113" then var location aindock
  if "$zoneid" = "107" then var location kresh
	if "$zoneid" = "116" then var location hib
	if "$zoneid" = "123" then var location shel
	if "$zoneid" = "126" then var location hawk
	if "$zoneid" = "127" then var location boar
  if "$zoneid" = "150" then var location fang
  if "$roomname" = "Private Home Interior" then var location home
  
  if "%location" = "unknown" then
  {
    put #echo Unknown Zone
    exit
  }

ROOM_CHECK:
put #echo >Log DarkBlue,LightYellow (train) ROOM_CHECK
  var home_rooms 0
  var hib_rooms 75|17|159|163|164|193|218|298|314|386|407|409|410|411|412|413|418|427|432|116|96|287
  var crossing_rooms 51|468|469|487|488|476|146
  var crossw_rooms 1|117
  var crossn_rooms 22|2
  var dirge_rooms 70|186|187|189|301|302|14
  var ntr_rooms 318|268
  var shel_rooms 24|32|168
  var stone_rooms 1|2
  var fang_rooms 85|87|89|88|7|137|222
  var riverhaven_rooms 28|73|1|331|328|26
  var rivernorth_rooms 2|48
  var riverwest_rooms 2|135|1|27
  var river2theren_rooms 30|14
  var shard_rooms 146|148|248|206|207
  var shardsouth_rooms 2|34
  var shardwest_rooms 10|15|37|14|391|392|395|460|476|481|535
  var shardn_rooms 65|39
  var icecave_rooms 31
  var ain_rooms 34|2|1
  var aindock_rooms 4|8
  var kresh_rooms 77|106|111|112
  var ross_rooms 136|8
  var rauders_rooms 2|214
  var theren_rooms 141|212|199
	if contains("|%%location_rooms|", "|$roomid|") then goto %location_$roomid

	else
  {
    put #echo >Log Red,LightYellow Unhandled roomid: %location_$roomid
    gosub go_room %%location_rooms(0)
  }
	goto room_check


### Hunting
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
  if "$zoneid" = "150" then goto HUNT_PREP_WOUNDS_1
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
  pause
  put store default backpack
  gosub get my almanac
  gosub put my almanac in my backpack
  pause 0.5
  put remove my bright pouch
  gosub put bright pouch in bottom drawer
  pause
  gosub POUCH_VAULT
  pause
  gosub POUCH_PORTAL
  pause
  gosub BUNDLE_VAULT
  pause
  gosub BUNDLE_PORTAL
  pause
#  gosub PECC_VAULT
  put close vault
  waitfor Carousel]
  pause
  gosub move out
HUNT_PREP_SUPPLIES:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_SUPPLIES
  # make sure we have enough bundling ropes and pouches / sell nuggets / cards / dira
  gosub BUNDLE_ROPE
  gosub go_room gem
  gosub GEM_SELL
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
  ## Back to Hib
  gosub go_room portal
  gosub move go exit.portal
HUNT_PREP_REPAIR:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PREP_REPAIR
  # repairstuff
  gosub ALMANAC_CHECK
  gosub DAMAGE_CHECK
  if %armor_damage = 1 then gosub ITEM_REPAIR
HUNT_TO_FIGHT:
put #echo >Log DarkBlue,LightYellow (train) HUNT_TO_FIGHT
  # travel to shard / shard west
  if $Performance.LearningRate > 30 then goto HUNT_FIGHT_PREP
HUNT_PRE_PERF:
put #echo >Log DarkBlue,LightYellow (train) HUNT_PRE_PERF
  if $zoneid != 116 then
  {
    put .ptravel hib
    waitfor Done Portalhax
  }
  #if $Performance.LearningRate > 30 then goto HUNT_FIGHT_PREP
  goto HUNT_FIGHT_PREP
  #if $roomid != 395 then gosub go_room 395
  #goto HIB_TWIDDLE


### TWIDDLES between circuits
HIB_TWIDDLE:
hib_427:
put #echo >Log DarkBlue,LightYellow (train) HIB_TWIDDLE
  if $roomid != 427 then gosub go_room 427
  gosub ALMANAC_CHECK
  if $Performance.LearningRate < 31 then gosub reckus
  gosub ALMANAC_CHECK
  goto HIB_TO_DRAKES

HOUSE_TO_DRAKES:
  gosub go_room shard
HUNT_FIGHT_PREP:
HIB_TO_DRAKES:
  put .ptravel crossing
  waitfor Done Portalhax
crossing_468:
  gosub BURGLE_CHECK
  if %burgling = 1 then
  {
    gosub go_room 468
    goto BURGLE_GO
  }
  gosub go_room NEGATE
  pause 0.5
  gosub go_room Dirge
  gosub go_room 186
  goto DRAKES_FIGHT_PREP
DRAKES_FIGHT_PREP:
dirge_186:
put #echo >Log DarkBlue,LightYellow (train) DRAKES_FIGHT_PREP
  if $roomid != 186 then gosub go_room 186
  gosub ALMANAC_CHECK
  put .armor on clown
  waitfor Script Done
  put .fight prep soul drakes
  waitfor FIGHT PREPPED
  put .cast aban 5 creature
  waitfor Spell Cast
  gosub ALMANAC_CHECK
  goto DRAKES_FIGHT
DRAKES_FIGHT:
dirge_189:
dirge_301:
dirge_302:
put #echo >Log DarkBlue,LightYellow (train) DRAKES_FIGHT
  if contains("$scriptlist", "geniehunter.cmd") then goto DRAKES_CYCLE_CHECK_1
  if $roomid != 301 then gosub go_room 301
  put .armor on clown
  waitfor Script Done
  put #var train_hunt 0
  # fight for one cycle
  put .fight drakes
  pause 0.5
  put .geniehunter multi $train_drake_gh_cycle_num
  pause 2
  put .gh_watch
  DRAKES_CYCLE_CHECK_1:
    waitfor Geniehunter Done.
  if ($train_gh_cycle_num = $GH_MULTI_CURR_NUM) then put #script abort geniehunter
  else goto DRAKES_CYCLE_CHECK_1
  put #var train_drake_gh_cycle_num $GH_MULTI_CURR_NUM
  goto DRAKES_DONE
DRAKES_DONE:
dirge_187:
put #echo >Log DarkBlue,LightYellow (train) DRAKES_DONE
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
  put release cyclic
  gosub go_room NTR
  put release cyclic
  gosub go_room Crossing

  goto HUNT_DONE_RETURN

HUNT_DONE_RETURN:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_RETURN
crossing_469:
  gosub BURGLE_CHECK
  if %burgling = 1 then
  {
    gosub go_room 469
    goto BURGLE_GO
  }
  # return to hib
  put .armor swap main
  waitfor Script Done
# off to FANG  
  gosub go_room portal
  gosub move go meeting.portal
fang_88:
HUNT_DONE_WOUNDS:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_WOUNDS
  # check wounds
  var wounded 0
  gosub health_check
  pause 0.5
  if %wounded = 1 then gosub fang_HEALER
HUNT_DONE_SUPPLIES:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_SUPPLIES
  # stay in FC so we're in doks
  # make sure we have enough bundling ropes and pouches / sell nuggets / cards / dira
fang_137:
  gosub SKIN_COUNT
  if %skincount > 5 then gosub BUNDLE_SELL
  gosub BUNDLE_ROPE
  gosub go_room gem
  gosub GEM_SELL
HUNT_DONE_BANK:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_SUPPLIES
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
  # drop off bright pouch & any tight bundles / gem pouches
  gosub go_room 87
  gosub move go cave.mouth
  put go third arch
  waitfor Carousel Chamber]
  pause
  gosub get bright pouch from bottom drawer
  put wear my bright pouch
  pause
  put store default bright pouch
  pause
  gosub POUCH_VAULT
  pause
  gosub POUCH_PORTAL
  pause
  gosub BUNDLE_VAULT
  pause
  gosub BUNDLE_PORTAL
  pause
#  gosub PECC_VAULT
  put close vault
  waitfor Carousel]
  gosub move out
  pause
## Back to Hib
  gosub go_room portal
  gosub move go exit.portal
  if "$zoneid" != "116" then
  {
    put .ptravel HIB
    waitfor Done Portalhax
    gosub go_room portal
  }
HUNT_DONE_REPAIR:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_REPAIR
  # repairstuff
  gosub DAMAGE_CHECK
  if %armor_damage = 1 then
  {
    gosub ITEM_REPAIR
    gosub go_room portal
  }
HUNT_DONE_CYCLE:
put #echo >Log DarkBlue,LightYellow (train) HUNT_DONE_CYCLE
  goto map_check

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
  gosub go_room ladar
  put .repairstuff ladar
  waitfor Stuff Repaired
  return

POUCH_VAULT:
  match POUCH_SHELF You tap a
  match RETURN I could not find what you were referring to.
  put tap gem.pouch in my pale.pouch
  matchwait 2
  goto POUCH_VAULT

POUCH_SHELF:
  gosub get gem.pouch from my pale.pouch
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

PECC_VAULT:
  gosub get saddle.peccary
  gosub put saddle.peccary in croissant on large shelf
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
    put tap third gem.pouch in my backpack
    matchwait 2
    goto POUCH_CHECK
  POUCH_ASK:
    put ask rasiya for gem pouch
    pause 0.5
    gosub put my gem pouch in my backpack
    goto POUCH_CHECK

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
  put get drake.fang from my bundle;get wyvern.claw from my bundle
  pause
  put sell my bundle
  pause
  put bundle
  pause
  put wear my bundle
  pause
  return

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

BURGLE_GO:
  var returnZone $zonename
  var returnRoom $roomid
  put #echo >Log DarkBlue,LightYellow Burgling Time!
  put .ptravel Crossing
  waitfor Done Portalhax
  gosub go_room West
  gosub go_room Tiger
  var burgling 0
  put .burgle
  waitfor SCRIPT FINISHED!
  gosub go_room Gate
  gosub go_room Crossing
  gosub go_room Bard
  gosub move go portal
  put .moveitems sash bucket
  waitfor Done Moving Items.
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  put get worn.book from my sash;put worn book in bucket
  pause 0.5
  if "%returnZone" != "The Crossing" then
  {
    put .ptravel %returnZone
    waitfor Done Portalhax
  }
  gosub go_room %returnRoom
  goto MAP_CHECK

BURGLE_TOOMANY:
  put #echo >Log DarkBlue,LightYellow Can't burgle, INV CHECK failed!
  return

### Hib
HIB_ITEM_REPAIR:
  gosub go_room Ladar
hib_314:
  put .repairstuff ladar
  waitfor Stuff Repaired
  goto HUNT_POST_CHECK

fang_222:
    gosub go_room portal
    gosub move go exit.portal

# Huntchecks post external cycles
HUNT_POST_CHECK:
hib_96:
hib_116:
hib_287:
hib_1:
hib_17:
hib_75:
hib_159:
hib_163:
hib_164:
hib_386:
hib_432:
  put #echo >Log DarkBlue,LightYellow (train) HUNT_POST_CHECK
  if %wounded = 1 then gosub hib_HEALER
  gosub SKIN_COUNT
  if %skincount > 5 then goto hib_BUNDLE
  gosub BURGLE_CHECK
  if %burgling = 1 then
  {
    goto BURGLE_GO
    put .ptravel Hib
    waitfor Done Portalhax
  }
  if $train_loreOnly = 1 then goto SKIP_COMBAT
  if $train_hunt = 1 then goto HUNT_PREP
  if $train_huntOnly = 1 then goto HUNT_PREP
  else
  {
    put #var train_hunt 1
    put #echo >Log DarkBlue,LightYellow Lore Time!
  }
SKIP_COMBAT:

LOREPOUCH_CHECK:
  match LOREPOUCH_ON You tap a
  match LOREPOUCH_OFF I could not find what you were referring to.
  put tap my bright pouch
  matchwait 2
  goto LOREPOUCH_CHECK

LOREPOUCH_OFF:
  # drop off bright pouch & any tight bundles / gem pouches
  gosub go_room portal
  gosub move go meeting.portal
  gosub go_room vault
  put go third arch
  waitfor Carousel Chamber]
  pause
  gosub get my almanac
  gosub put my almanac in my backpack
  pause 0.5
  gosub get bright pouch from bottom drawer
  put wear my bright pouch
  put store default bright pouch
  pause
  gosub POUCH_VAULT
  pause
  gosub BUNDLE_VAULT
  put close vault
  waitfor Carousel]
  pause
  gosub move out
  gosub go_room portal
  gosub move go exit.portal

LOREPOUCH_ON:
  put store default bright.pouch
  var doks 0
  action (money) var doks $1 when (\d+) copper Dokoras\)\.
  action (money) var doks 0 when No Dokoras\.
  action (money) on
  pause 0.5
  put wealth
  pause 2
  action (money) off
  if %doks < 100000 then goto hib_BANK
  gosub go_room 413
  goto hib_413

SKIN_COUNT:
  var skincount 0
  action var skincount $1 when ^You flip through the lumpy bundle and find (\d+) \w+ in it\.
  pause
  put -count my lumpy bundle
  pause 3
  return

hib_HEALER:
  gosub go_room portal
  gosub move go meet.portal
  gosub fang_HEALER
  gosub go_room portal
  gosub move go exit.portal
  return

###
  if $roomid!= 386 then gosub go_room 386
  put lie
  waitfor You sit up.
  pause
  var wounded 0
  put stand
  waitfor You stand back up.
  return

hib_218:
  gosub SKIN_COUNT
hib_BUNDLE:
put #echo >Log DarkBlue,LightYellow (train) HIB_BUNDLE
  if %skincount > 5 then
  {
    gosub go_room portal
    gosub move go meeting portal
    gosub BUNDLE_SELL
    gosub BUNDLE_ROPE
    gosub go_room portal
    gosub move go exit portal
  }
  gosub go_room 413
  goto hib_413

hib_193:
hib_BANK:
  if $roomid != 193 then gosub go_room 193
  gosub go_room 413
  goto hib_413

hib_409:
hib_418:
  gosub go_room 413
hib_413:
  #just in case we are pouchless
  put store default backpack
  pause 0.3
  put store default bright.pouch
  gosub health_check
  if %wounded = 1 then
  {
    gosub hib_HEALER
    gosub go_room 413
  }
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  gosub ALMANAC_CHECK
  if $Performance.LearningRate < 31 then gosub reckus
  #if $Outfitting.LearningRate < 31 then gosub origami
  put store default bright.pouch
  put rel cyclic
  if %loreOnly = 1 then
  {
    put app focus clock.shark
    waitforre Breakthrough\!|You are already under the effects of an appraisal focus\.|You can't seem to focus on that\.
  }
  if $Forging.LearningRate < 25 then
  {
    put #echo >Log DarkBlue,LightYellow Forging Things!
    put .workorder weapon 1
    waitfor Workorder Complete
  }
  else put #echo >Log DarkBlue,LightYellow Skipping Forging!

hib_412:
  if $roomid != 412 then gosub go_room 412
  gosub ALMANAC_CHECK
  #if ((%TRAIN_LOCATION_COUNT = 0) || (%TRAIN_LOCATION_COUNT = 3)) then
  #{
  #  if $Scholarship.LearningRate < 32 then
  #  {
  #    put .schol
  #    waitfor Done Scholarship
  #  }
  #}

#  if ((%TRAIN_LOCATION_COUNT = 1) || (%TRAIN_LOCATION_COUNT = 2) || (%TRAIN_LOCATION_COUNT = 4) || (%TRAIN_LOCATION_COUNT = 5)) then
#  {
  if ("$lefthandnoun" <> "") then gosub put stow left
  if ("$righthandnoun" <> "") then gosub put stow right
  gosub ALMANAC_CHECK
  if $Performance.LearningRate < 31 then gosub reckus
  #if $Outfitting.LearningRate < 31 then gosub origami
#  }

hib_411:
  gosub ALMANAC_CHECK
  if $train_circleOnly = 1 then
  {
    put #echo >Log DarkBlue,LightYellow (train) Skipping non-circle items
    gosub go_room portal
    gosub move go meeting.portal
    gosub go_room 89
    goto fang_89
  }
  ###
  if (($Engineering.LearningRate > 25) && ($Outfitting.LearningRate > 25)) then
  {
    put #echo >Log DarkBlue,LightYellow Skipping Engineering / Outfitting!
    goto hib_410
  }
# if ($Engineering.LearningRate > 25) then goto hib_410

  STACK_DEED_CHECK:
    var ClothDeedSize 0
    var StackDeedSize 0
	  pause 0.5
	  action (deeds) var StackDeedSize $1 when Pieces:\s+(\d+)
    action (deeds) var ClothDeedSize $1 when Yards:\s+(\d+)
	  action (deeds) on
	  put read my wolf deed in my $craftpack
	  waitforre PhysicalResist|I could not find what you were referring to\.
	  pause
	STACK_DEED_DONE:

	STACK_CHECK:
	  var StackSize %StackDeedSize
	  pause 0.5
	  action (stack) var StackSize $1 when You count out (\d+) pieces of material there
    action (stack) var ClothSize $1 when You count out (\d+) yards of material there
	  action (stack) on
    if %StackSize > 0 then goto CLOTH_DEED_CHECK
	  put count my stack
	  waitforre pieces of material there|I could not find what you were referring to\.
	STACK_CHECK_DONE:

  CLOTH_DEED_CHECK:
    var ClothDeedSize 0
#	  pause 0.5
#	  put read my linen deed in my $craftpack
#	  waitforre Physical Resist|I could not find what you were referring to\.
#	  pause
	CLOTH_DEED_DONE:
	  action (deeds) off

  CLOTH_CHECK:
    pause 0.5
    var ClothSize %ClothDeedSize
    if %ClothSize > 0 then goto CLOTH_CHECK_DONE
	  put count my linen.cloth
	  waitforre yards of material there|I could not find what you were referring to\.
	  pause
	CLOTH_CHECK_DONE:
	  action (stack) off
    if ((%StackSize <= 10) || (%ClothSize <= 10)) then goto STACK_MAKE
#    if (%StackSize <= 10) then goto STACK_MAKE
		else goto CARVE_IT


	STACK_MAKE:
	  if %StackSize <= 10 then
    {
      if %StackDeedSize > 0 then
      {
        gosub get my wolf deed
        gosub put my wolf deed in bucket
      }
      else
      {
        gosub get my stack
        gosub put my stack in bucket
      }
    }
    else gosub put my stack in my $craftpack
	  if %ClothSize <= 10 then
    {
      if %ClothDeedSize > 0 then
      {
        gosub get my linen deed
        gosub put my linen deed in bucket
      }
      else
      {
        gosub get my linen cloth
        gosub put my linen cloth in bucket
      }
    }
    else gosub put my linen cloth in my $craftpack
	  gosub go_room 193
	  put withdraw 1 plat dokora
	  pause 0.5
	  put exchange 1 plat dokora for lirum
	  pause 0.5
#	  put .ptravel RIVERHAVEN
#	  waitfor Done Portalhax
    gosub go_room portal
    gosub move go meeting portal
    #gosub go_room 209

   goto STACK_MAKE_1
  STACK_MAKE_1:
    if %StackSize <= 10 then
    {
      gosub go_room 208
  		put .bonestack 95
	  	waitfor Stack Made
      var StackDeedSize 0
    }
    gosub go_room 209
  POLISHBUY_1:
    match POLISHBUY_DONE You tap a
    match POLISHBUY_2 I could not find what you were referring to.
    put tap my third surface.polish in my $craftpack
    matchwait 2
    goto POLISHBUY_1
  POLISHBUY_2:
    pause
    put order %SurfacePolNum;order %SurfacePolNum
    gosub put my surface.polish in my $craftpack
    goto POLISHBUY_1
  POLISHBUY_DONE:
  CLOTH_MAKE:
	  gosub go_room 187
    if %ClothSize <= 10 then
    {
  		put .clothstack 95
	  	waitfor Cloth Made
      var ClothDeedSize 0
    }
  THREADBUY_1:
    match THREADBUY_DONE You tap some
    match THREADBUY_2 I could not find what you were referring to.
    put tap my third thread in my $craftpack
    matchwait 2
    goto THREADBUY_1
  THREADBUY_2:
    pause
    put order %ThreadNum;order %ThreadNum
    gosub put my thread in my $craftpack
    goto THREADBUY_1
  THREADBUY_DONE:
    gosub go_room 186
  PINSBUY_1:
    match PINSBUY_DONE You tap some
    match PINSBUY_2 I could not find what you were referring to.
    put tap my third pins in my $craftpack
    matchwait 2
    goto PINSBUY_1
  PINSBUY_2:
    pause
    put order %PinsNum;order %PinsNum
    gosub put my pins in my $craftpack
    goto PINSBUY_1
  PINSBUY_DONE:


  STACK_MAKE_RETURN:
    gosub go_room portal
    gosub move go exit portal
	  gosub go_room 411
  CARVE_IT:
  gosub ALMANAC_CHECK
  STACK_UNDEED:
    if ($Engineering.LearningRate > 25) then
    {
      put #echo >Log DarkBlue,LightYellow Skipping Engineering!
      goto CLOTH_UNDEED
    }
    if %StackDeedSize > 0 then
    {
  	  gosub GET wolf deed from my $craftpack
	    pause 0.5
	    put tap my wolf deed
	    pause 0.5
  	  gosub get wolf stack
      gosub put my wolf stack in my $craftpack
    }
    put #echo >Log DarkBlue,LightYellow Engineering!
    put .engineer carv $engineer_train_item wolf 20 dump
	  waitfor Done Engineering
    gosub get my stack
    gosub get my packet
    put push my stack with my packet
    pause 0.5
    gosub put my deed in my $craftpack
    gosub put my packet in my $craftpack
CLOTH_UNDEED:
    gosub ALMANAC_CHECK
    if ($Outfitting.LearningRate > 25) then
    { 
      put #echo >Log DarkBlue,LightYellow Skipping Outfitting!
      goto HIB_410
    }
  	if %ClothDeedSize > 0 then
    {
  	  gosub GET linen deed from my $craftpack
	    pause 0.5
	    put tap my linen deed
  	  pause 0.5
	    gosub get linen cloth
      gosub put my linen cloth in my craftpack
    }
    put #echo >Log DarkBlue,LightYellow Outfitting!
    put .outfit tailor $fitting_train_item linen.cloth 20 dump
    waitfor Done Outfitting
    #gosub get my linen.cloth
    #gosub get my packet
    #put push my cloth with my packet
    #pause 0.5
    #gosub put my deed in my $craftpack
    #gosub put my packet in my $craftpack
    if $train_loreOnly = 1 then exit
	  goto hib_410

hib_410:
  pause 0.5
  gosub ALMANAC_CHECK
  PACKET_CHECK_0:
    match PACKET_CHECK_DONE You tap a large packet of deed claim forms inside your
    match PACKET_CHECK_BUY I could not find what you were referring to
    put tap my second deed.packet
    matchwait 3
    goto PACKET_CHECK_DONE

  PACKET_CHECK_BUY:
    if $roomid != 409 then gosub go_room 409
    put .order 16 1
    waitfor All bought!
    goto PACKET_CHECK_0

  PACKET_CHECK_DONE:

hib_298:
  # rotate cities
  gosub ALMANAC_CHECK
  #if $Performance.LearningRate < 31 then gosub reckus
  #if $Outfitting.LearningRate < 31 then gosub origami
  if %TRAIN_LOCATION_COUNT >= %TRAIN_LOCATION_MAX then
  {
    var TRAIN_LOCATION_COUNT 0
    put #var train_location_count 0
  }
  else
  {
    evalmath TRAIN_LOCATION_COUNT (%TRAIN_LOCATION_COUNT + 1)
    put #var train_location_count %TRAIN_LOCATION_COUNT
  }
  var NEXTLOC %TRAIN_LOCATION(%TRAIN_LOCATION_COUNT)
  put #echo >Log DarkBlue,LightYellow (train) TRAIN_LOCATION %NEXTLOC
  goto hib_to_%NEXTLOC

hib_to_FANG:
  put #echo >Log DarkBlue,LightYellow Going to Fang Cove.
  gosub go_room Portal
  gosub move go meeting portal
  goto map_check

hib_to_SHEL:
  put #echo >Log DarkBlue,LightYellow Going to Himineldar Shel.
  gosub go_room e gate
  gosub go_room 24
  goto map_check

hib_to_AIN:
  put #echo >Log DarkBlue,LightYellow Going to Ain Ghazil.
  gosub go_room 75
  put .travel ain.ghazil 34
  waitfor REACHED YOUR DESTINATION
  pause
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left
  #gosub move west
  #pause
  goto map_check

hib_to_CROSSING:
  put #echo >Log DarkBlue,LightYellow Going to Crossing.
  put .ptravel CROSSING
  waitfor Done Portalhax
  goto map_check

hib_to_RIVERHAVEN:
  put #echo >Log DarkBlue,LightYellow Going to Riverhaven North/West.
  put .ptravel RIVERHAVEN
  waitfor Done Portalhax
  goto map_check

hib_to_SHARD:
  put #echo >Log DarkBlue,LightYellow Going to Shard.
  put .ptravel SHARD
  waitfor Done Portalhax
  goto map_check

hib_to_KRESH:
  put #echo >Log DarkBlue,LightYellow Going to Merkresh.
  put .ptravel KRESH
  waitfor Done Portalhax
  goto map_check

hib_to_CROSSLUMBER:
  put #echo >Log DarkBlue,LightYellow Going to Crossing (Lumber).
  put .ptravel CROSSING
  waitfor Done Portalhax
  gosub go_room w gate
  goto map_check

hib_to_THERENLUMBER:
  put #echo >Log DarkBlue,LightYellow Going to Theren (Lumber).
  put .ptravel THEREN
  waitfor Done Portalhax
  goto map_check

# THERENLUMBER

theren_141:
  put .forest scan
  waitfor Script Done
  goto map_check

theren_212:
  put .forest scan
  waitfor Script Done
  goto map_check

rauders_2:
  put .forest scan
  waitfor Script Done
  goto map_check

rauders_214:
  put .forest scan
  waitfor Script Done
  goto map_check

ross_136:
  put .forest scan
  waitfor Script Done
  goto map_check

ross_8:
  gosub go_room 137
  goto map_check

theren_199:
  put #echo >Log DarkBlue,LightYellow Theren back to Hib.
  put .ptravel HIB
  waitfor Done Portalhax
  goto map_check


# CROSSLUMBER
crossw:
crossw_1:
  put .forest scan
  waitfor Script Done
  gosub go_room crossing
  gosub go_room n gate

crossn:
crossn_22:
  put .forest scan
  waitfor Script Done
  gosub go_room ntr

ntr:
ntr_318:
  put .forest scan
  waitfor Script Done
  gosub go_room crossing
  put #echo >Log DarkBlue,LightYellow Crossing (Lumber) back to Hib.
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check

### Fang Cove
# Mine Scan, mech at cove, sorcery
fang_85:
  put .prospect scan
  waitfor Script Done
  gosub go_room 96
  goto fang_96

fang_96:
  put .forest scan
  waitfor Script Done

fang_7:
fang_87:
  gosub go_room 85
  put #echo >Log DarkBlue,LightYellow Fang Cove back to Hib.
  gosub move go exit portal
  put .ptravel HIBARN
  waitfor Done Portalhax
  gosub go_room 411
  goto map_check

fang_17:
fang_HEALER:
  if $roomid!= 17 then gosub go_room 17
  put join list
  gosub ALMANAC_CHECK
  waitfor Yrisa crosses Ryken's name from the list.
  pause
  var wounded 0
  return

### Himineldar Shel
# Mine Scan, mech at Mamas, sorcery
shel_168:
  gosub go_room 24
  goto shel_24

shel_24:
  put .prospect scan
  waitfor Script Done
  goto shel_32

shel_32:
  put #echo >Log DarkBlue,LightYellow Himineldar Shel to Shard West.
  gosub go_room hib
  put .ptravel SHARD
  waitfor Done Portalhax
  gosub go_room w gate
  goto map_check

### Crossing
# Recall run, mech, sorcery
crossing_51:
crossing_146:
crossing_476:
crossing_487:
crossing_488:
  gosub BURGLE_CHECK
  if %burgling = 1 then goto BURGLE_GO
  if ($Athletics.LearningRate <= 32) then {
  put .cross_climb
  waitfor Script Done
  }
  put #echo >Log DarkBlue,LightYellow Crossing to Stone Clan.
  gosub go_room ntr
  gosub go_room stone clan
  goto map_check

### Stone Clan
# Mine if super rare
stone_1:
  put .prospect scan
  waitfor Script Done
  goto stone_2

stone_2:
  put #echo >Log DarkBlue,LightYellow Stone Clan to Dirge.
  gosub go_room ntr
  gosub go_room dirge
  goto map_check

### Dirge
# Work mech, work sorcery, mine if super rare
dirge_70:
  put .prospect scan
  waitfor Script Done
  goto dirge_14

dirge_14:
  put #echo >Log DarkBlue,LightYellow Dirge back to Hib.
  gosub go_room ntr
  gosub go_room crossing
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check


### Riverhaven
# Work mech, work sorcery
# Head to north gate
riverhaven_28:
riverhaven_73:
riverhaven_328:
  gosub go_room n gate
  goto map_check

rivernorth_2:
  put .forest scan
  waitfor Script Done

rivernoth_48:
  gosub go_room riverhaven
  goto map_check

riverhaven_26:
  gosub go_room w gate
  goto map_check

### Riverhaven West Gate Area
# Run mines
riverwest_2:
  put .prospect scan
  waitfor Script Done
  goto riverwest_135

riverwest_135:
  gosub go_room theren
  goto map_check

river2theren_30:
  put .forest scan
  waitfor Script Done
river2theren_14:
  gosub go_room riverhaven
  goto map_check

riverwest_27:
  gosub go_room riverhaven
riverhaven_1:
  put #echo >Log DarkBlue,LightYellow Riverhaven back to Hib.
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check

shardwest_10:
  put .forest scan
  waitfor Script Done
shardwest_37:
  put #echo >Log DarkBlue,LightYellow Shard West to Shard North.
  gosub go_room n gate
  goto map_check

shardn_65:
  put .forest scan
  waitfor Script Done
shardn_39:
  put #echo >Log DarkBlue,LightYellow Shard North back to Hib.
  gosub go_room e gate
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check

### Shard
# Climbing, mech, sorcery
shard_148:
#  gosub go_room 146
shard_146:
#  if ($Athletics.LearningRate < 33) then {
#  put .shard_climb
#  waitfor Script Done
#  }
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
  put .forest scan
  waitfor Script Done

  gosub go_room 2
  gosub move go gate
  gosub move n
  gosub move n
  goto map_check

# mining out south gate
icecave_31:
  put .prospect scan
  waitfor Script Done
  goto map_check

# sell gem pouch
shard_206:
shard_207:
#	var gemcount 0
#	action var gemcount $1 when pouch and find (\d+) gems in it\.
#	pause
#	put -count my gem pouch
#	pause 3
#	if %gemcount > 300 then
#  {
#    gosub go_room 129
#    gosub go_room Gems
#    put get my gem pouch;remove my gem pouch
#	  pause
#	  put sell my gem pouch;sell my gem pouch
#	  pause
#	  put wear my gem pouch
#    gosub go_room 31
#  }
  put .ptravel HIBARN
  waitfor Done Portalhax
  goto map_check

### Ain
# Ferry Travel to
ain_34:
ain_2:
  put .prospect scan
  waitfor Script Done
  pause
  gosub go_room 1

aindock_4:
    gosub move w
    goto ain_1
aindock_8:
    gosub move n
    goto ain_1
ain_1:
  put #echo >Log DarkBlue,LightYellow Ain Ghazil back to Hib.
  put .travel outer.hib 17
  waitfor REACHED YOUR DESTINATION
  pause
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left
  goto map_check


### Older Stuff, keeping in case we re-use