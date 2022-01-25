# Update and fix buying

# get a workorder
# Toolroom sells

# This script needs to know the following variables ahead of time: $craftpack

var IngotMade 0
var IngotMats platinum|bronze|iron|steel
var IngotMatNum 0
var WorkShort \b(bl|we|arm|car|sha|tin)(.+)?
var WorkLong blacksmith|weapon|armor|carving|shaping|tinkering
var MetalTypesShort bra|bro|cop|cov|iro|lea|nic|ora|pew|ste|tin|zin|ani|aur|dam|dar|ele|gla|gol|har|ker|lum|nin|ori|pla|tyr
var MetalTypesLong brass|bronze|copper|covellite|iron|lead|nickel|oravir|pewter|steel|tin|zinc|animite|audrualm|damite|darkstone|electrum|glaes|gold|haralun|kertig|lumium|niniam|orichalcum|platinum|tyrium

var BADITEMS none

#debug 5

if ("%1" = "") then
{
	echo USAGE .workorder <weapon|black|carving|tinkering>
	exit
}
if_2 var IngotMats %2|%IngotMats

eval WorkMatch tolower("%1")
if matchre(("%WorkMatch"), "(%WorkShort)") then
{
	if matchre("%WorkLong", "\|($1(\w+)?)\|") then var WorkType $1
	else exit
	shift
}
else
{
	echo USAGE .workorder <weapon|black|carving|tinkering>
	exit
}
if matchre("blacksmith|weapon|armor", "%WorkType") then var LogType forging
if matchre("carving|shaping|tinkering", "%WorkType") then var LogType engineering
var WorkOrdersCount 0
var WorkOrdersMax 100

if_1 then var WorkOrdersMax %1

GO_TO_MASTER:
#  if $zoneid = 67 then
#  {
#    var LOCATION SHARD
#    var MASTER Serric
#    var FORGEROOM 657
#    var CRUCIBLEROOM 656
#    var TOOLSROOM 653
#    var SUPPLYROOM 658
#    var PRESTIGEROOM 645
#  }
  if $zoneid = 116 then
  {
    var LOCATION HIB
    var MASTER Juln
    var FORGEROOM 412
    var CRUCIBLEROOM 405
    var TOOLSROOM 407
    var SUPPLYROOM 409
    var PRESTIGEROOM 401
  }
  if $zoneid = 30 then
  {
    var LOCATION RIVER
    var MASTER Paarupensteen
    var CARVEROOM 347
    var TOOLSROOM 465
    var SUPPLYROOM 466
    var PRESTIGEROOM 461
  }
  goto %LOCATION_$roomid

#MASTER_SHARD:
#	if $roomid != 645 then gosub GO_ROOM 645
#	gosub MASTER_CHECK
#	if $roomid != 644 then gosub GO_ROOM 644
#	gosub MASTER_CHECK
#	if $roomid != 661 then gosub GO_ROOM 661
#	gosub MASTER_CHECK
#	if $roomid != 646 then gosub GO_ROOM 646
#	gosub MASTER_CHECK
#	if $roomid != 658 then gosub GO_ROOM 658
#	gosub MASTER_CHECK
#	if $roomid != 655 then gosub GO_ROOM 655
#	gosub MASTER_CHECK
# if $roomid != 652 then gosub GO_ROOM 653
#	gosub MASTER_CHECK
# if $roomid != 654 then gosub GO_ROOM 654
#	gosub MASTER_CHECK
# if $roomid != 650 then gosub GO_ROOM 650
# gosub MASTER_CHECK
#	if $roomid != 649 then gosub GO_ROOM 649
# gosub MASTER_CHECK
#	goto MASTER_SHARD

MASTER_HIB:
  HIB_401:
  if $roomid != 401 then gosub GO_ROOM 401
  gosub MASTER_CHECK
  HIB_402:
  if $roomid != 402 then gosub GO_ROOM 402
  gosub MASTER_CHECK
  HIB_403:
  if $roomid != 403 then gosub GO_ROOM 403
  gosub MASTER_CHECK
  HIB_404:
  if $roomid != 404 then gosub GO_ROOM 404
  gosub MASTER_CHECK
  HIB_405:
  if $roomid != 405 then gosub GO_ROOM 405
  gosub MASTER_CHECK
  HIB_406:
  if $roomid != 406 then gosub GO_ROOM 406
  gosub MASTER_CHECK
  HIB_407:
  if $roomid != 407 then gosub GO_ROOM 407
  gosub MASTER_CHECK
  HIB_408:
  if $roomid != 408 then gosub GO_ROOM 408
  gosub MASTER_CHECK
  HIB_409:
  if $roomid != 409 then gosub GO_ROOM 409
  gosub MASTER_CHECK
  HIB_410:
  if $roomid != 410 then gosub GO_ROOM 410
  gosub MASTER_CHECK
  HIB_411:
  if $roomid != 411 then gosub GO_ROOM 411
  gosub MASTER_CHECK
  HIB_412:
  if $roomid != 412 then gosub GO_ROOM 412
  gosub MASTER_CHECK
  HIB_413:
  if $roomid != 413 then gosub GO_ROOM 413
  gosub MASTER_CHECK
  goto MASTER_HIB

MASTER_RIVER:
  RIVER_347:
  RIVER_461:
  if $roomid != 461 then gosub GO_ROOM 461
  gosub MASTER_CHECK
  RIVER_462:
  if $roomid != 462 then gosub GO_ROOM 462
  gosub MASTER_CHECK
  RIVER_463:
  if $roomid != 463 then gosub GO_ROOM 463
  gosub MASTER_CHECK
  RIVER_464:
  if $roomid != 464 then gosub GO_ROOM 464
  gosub MASTER_CHECK
  RIVER_465:
  if $roomid != 465 then gosub GO_ROOM 465
  gosub MASTER_CHECK
  RIVER_466:
  if $roomid != 466 then gosub GO_ROOM 466
  gosub MASTER_CHECK
  goto MASTER_RIVER



MASTER_CHECK:
  if matchre("$roomobjs", "%MASTER") then goto GET_LOGBOOK
  else return

GET_LOGBOOK:
  gosub clear
	gosub GET my %LogType logbook
  if %LogType = engineering then
  {
    pause
    put get my stack
    pause
    if ("$lefthandnoun" != "stack" AND "$righthandnoun" != "stack") then
    {
      var curr_room $roomid
      gosub GO_ROOM %SUPPLYROOM
      put order 7; order 7
      pause
      put gosub GO_ROOM %curr_room
    }
  }

WORKORDER_REQUEST:
	action (workorder) var ItemNeeded $2 when Alright\, this is an order for (an?|some) (((\S+\s)+)?\S+)\. I
	action (workorder) var NumberNeeded $1 when I need (\d+) of.*quality\,
	action (workorder) var ItemMaterial $1 when , made from (.*) material
	action (workorder) var OrderTimer $1 when and due in (\d+) roisaen\.
	action (workorder) on
WORKORDER_REQUEST_1:
	matchre GET_LOGBOOK ^\w+ shakes his head and says
	matchre CHECK_WORKBOOK ^\w+ shuffles through some notes and says
	match WORKORDER_WAIT says, "I am sorry, but you just received a work order.  Try again a little later perhaps."
  match WORKORDER_WAIT stone
  match %LOCATION_$roomid To whom are you speaking?
	put ask %MASTER for hard weapon work
	matchwait 2
	goto WORKORDER_REQUEST_1

WORKORDER_WAIT:
	delay 65
	goto WORKORDER_REQUEST

CHECK_WORKBOOK:
  if matchre("%ItemNeeded", "%BADITEMS") then goto WORKORDER_WAIT
	put #echo >Log Orange Workorder for %NumberNeeded %ItemMaterial %ItemNeeded
	eval ItemNeeded replace("%ItemNeeded", " ", ".")
	eval ItemNeeded tolower("%ItemNeeded")
	eval ItemNeeded replacere("%ItemNeeded", " an?\.", " ")
	eval ItemNeeded replace("%ItemNeeded", " some.", " ")
	eval ItemNeeded replace("%ItemNeeded", "metal.", "")
  var ItemAssemble none
	gosub put my %LogType logbook in my $craftpack
	action (workorder) off
	action (itemreqs) var ItemVol $1 when ^\s+\(\d+\) refined metal ingot \((\d+) volume\)|^\s+\(\d+\) a bleached bone stack \((\d+) pieces\)
	action (itemreqs) var ItemAssemble $1 when ^\s+\(\d+\).* (hilt|haft|short \w+ cord|long \w+ cord|long \w+ pole|short \w+ pole)
	put .craftbook %WorkType %ItemNeeded
	waitfor Book Turned
	action (itemreqs) off
	#gosub put my book in my $craftpack
  evalmath OrderVolNeeded (%ItemVol * %NumberNeeded)
  goto TOOLBUY

TOOLBUY:
  var curr_room $roomid
  gosub go_room %TOOLSROOM
  if %LogType = engineering then goto POLISHBUY
BRUSHBUY:
  match OILBUY You tap a
  match BRUSHBUY_1 I could not find what you were referring to.
  put tap my third wire brush in my $craftpack
  matchwait 2
  goto BRUSHBUY
BRUSHBUY_1:
  pause
  put order 10;order 10
  gosub put my wire brush in my $craftpack
  goto BRUSHBUY
OILBUY:
#  var curr_room $roomid
#  gosub go_room 413
OILBUY_1:
  match OILBUY_DONE You tap a
  match OILBUY_2 I could not find what you were referring to.
  put tap my third of oil in my $craftpack
  matchwait 2
  goto OILBUY_1
OILBUY_2:
  pause
  put order 6;order 6
  gosub put my of oil in my $craftpack
  goto OILBUY_1
OILBUY_DONE:
  gosub go_room %curr_room
  goto INGOT_CHECK
POLISHBUY:
  match POLISHBUY_DONE You tap a
  match POLISHBUY_2 I could not find what you were referring to.
  put tap my second surface.polish in my $craftpack
  matchwait 2
  goto POLISHBUY_1
POLISHBUY_2:
  pause
  put order 8;order 8
  gosub put my surface.polish in my $craftpack
  goto POLISHBUY_1
POLISHBUY_DONE:
  gosub go_room %curr_room
  goto STACK_CHECK

DEED_CHECK:
  var DeedSize 0
  pause 0.5
  action (deeds) var DeedSize $1 when Volume:\s+(\d+)
  action (deeds) on
  put read my %ItemMaterial deed in my $craftpack
  waitforre PhysicalResist|I could not find what you were referring to\.
  pause
DEED_DONE:
  action (deeds) off
  return

UNDEED_INGOT:
  gosub GET %ItemMaterial deed from my $craftpack
  pause 0.5
  put tap my %ItemMaterial deed
  pause 0.5
  gosub get %ItemMaterial ingot
  pause 0.5
  gosub PUT my %ItemMaterial ingot in my $craftpack
  return

DEED_TOO_SMALL:
  gosub get %ItemMaterial deed from my $craftpack
  #if "%ItemMaterial" = "steel" then
  #{
  #  put put my steel deed in bucket
  #  put put my steel deed in bin
  #  put drop my steel deed
  #}
  #else gosub put my %ItemMaterial deed in my $pack
  return

DEED_INGOT:
  gosub get my %ItemMaterial ingot from my $craftpack
  gosub get my deed packet from my $deedpack
  pause 0.5
  put push my %ItemMaterial ingot with my deed packet
  pause 0.5
  gosub put my deed packet into my $deedpack
  gosub put my %ItemMaterial deed in my $craftpack
  return

STACK_CHECK:
  if "%ItemMaterial" = "any" then var ItemMaterial deer-bone
  var StackSize 0
  pause 0.5
  action (stack) var StackVol $1 when You count out (\d+) pieces of material there
  action (stack) on
  put count my stack
  waitforre pieces of material there|I could not find what you were referring to\.
  pause
STACK_CHECK_DONE:
  action (stack) off
  if %StackVol < %OrderVolNeeded then goto STACK_MAKE
	if "%ItemAssemble" = "none" then goto CARVE_IT
	else goto ASSEMBLY_PURCHASE

STACK_MAKE:
	put .bonestack %OrderVolNeeded
	waitfor Stack Made
  var ItemMaterial deer
	if "%ItemAssemble" = "none" then goto CARVE_IT
	else goto ASSEMBLY_PURCHASE


INGOT_CHECK:
  if "%ItemMaterial" = "any" then var ItemMaterial %IngotMats(%IngotMatNum)
	action var IngotVol $1 when ^About (\d+) volume of metal was used in this item's construction\.
INGOT_CHECK_1:
	match INGOT_CHECK_2 Roundtime
#	if "%ItemMaterial" = "steel" then match INGOT_MAKE What were you referring to?
	matchre INGOT_TYPE_CHANGE What were you referring to\?|Analyze what\?
	put analyze my %ItemMaterial ingot in my $craftpack
	matchwait 2
	goto INGOT_CHECK_1
INGOT_CHECK_2:
	action remove ^About (\d+) volume of metal was used in this item's construction\.
#	gosub PUT my %ItemMaterial ingot in my $craftpack
	if %IngotVol < %OrderVolNeeded then goto INGOT_MAKE
	if "%ItemAssemble" = "none" then goto FORGE_IT
	else goto ASSEMBLY_PURCHASE

INGOT_TYPE_CHANGE:
  gosub DEED_CHECK %ItemMaterial
  if %DeedSize >= %OrderVolNeeded then
  {
    gosub UNDEED_INGOT
    goto INGOT_CHECK
  }
  if (%DeedSize > 0) && (%DeedSize < %OrderVolNeeded) then
  {
    gosub DEED_TOO_SMALL
    goto INGOT_CHECK
  }
  if "%ItemMaterial" = "steel" then goto INGOT_MAKE
	math IngotMatNum add 1
	var ItemMaterial %IngotMats(%IngotMatNum)
	goto INGOT_CHECK

INGOT_MAKE:
  if "%ItemMaterial" != "steel" then
  {
    gosub DEED_INGOT
    goto INGOT_CHECK
  }
	if %IngotMade != 0 then goto DONE_WORKORDERS
	put .ingot
	waitfor Ingot Made
	var IngotMade 1
  var ItemMaterial steel
	if "%ItemAssemble" = "none" then goto FORGE_IT
	else goto ASSEMBLY_PURCHASE


ASSEMBLY_PURCHASE:
	if $roomid != %TOOLSROOM then gosub GO_ROOM %TOOLSROOM
	eval ItemAssemble replace("%ItemAssemble", " ", ".")
	eval ItemAssemble replacere("%ItemAssemble", "leather\.|wooden\.|cloth\.", "")
	var AssemblyPurchaseCount 0
ASSEMBLY_PURCHASE_1:
	if %AssemblyPurchaseCount < %NumberNeeded then
	{
		pause
		put buy %ItemAssemble
		gosub PUT my %ItemAssemble in my $craftpack
		math AssemblyPurchaseCount add 1
		goto ASSEMBLY_PURCHASE_1
	}
	else goto FORGE_IT

FORGE_IT:
	if "%ItemMaterial" != "steel" then var IngotMade 1
	if $roomid != %FORGEROOM then gosub GO_ROOM %FORGEROOM
	put .forge weapon %ItemNeeded %ItemMaterial no no %NumberNeeded
	waitfor Items Forged
	goto TURN_IN_%LOCATION

#TURN_IN_SHARD:
#	if $roomid != 645 then gosub GO_ROOM 645
# gosub TURN_IN_CHECK
#	if $roomid != 644 then gosub GO_ROOM 644
#	gosub TURN_IN_CHECK
#	if $roomid != 661 then gosub GO_ROOM 661
#	gosub TURN_IN_CHECK
#	if $roomid != 646 then gosub GO_ROOM 646
#	gosub TURN_IN_CHECK
#	if $roomid != 658 then gosub GO_ROOM 658
#	gosub TURN_IN_CHECK
#	if $roomid != 655 then gosub GO_ROOM 655
#	gosub TURN_IN_CHECK
#	if $roomid != 652 then gosub GO_ROOM 653
#	gosub TURN_IN_CHECK
#	if $roomid != 654 then gosub GO_ROOM 654
#	gosub TURN_IN_CHECK
#	if $roomid != 650 then gosub GO_ROOM 650
#	gosub TURN_IN_CHECK
#	if $roomid != 649 then gosub GO_ROOM 649
#	gosub TURN_IN_CHECK
#	goto TURN_IN_SHARD

TURN_IN_HIB:
	if $roomid != 401 then gosub GO_ROOM 401
  gosub TURN_IN_CHECK
	if $roomid != 402 then gosub GO_ROOM 402
	gosub TURN_IN_CHECK
	if $roomid != 403 then gosub GO_ROOM 403
	gosub TURN_IN_CHECK
	if $roomid != 404 then gosub GO_ROOM 404
	gosub TURN_IN_CHECK
	if $roomid != 405 then gosub GO_ROOM 405
	gosub TURN_IN_CHECK
	if $roomid != 406 then gosub GO_ROOM 406
	gosub TURN_IN_CHECK
	if $roomid != 407 then gosub GO_ROOM 407
	gosub TURN_IN_CHECK
	if $roomid != 408 then gosub GO_ROOM 408
	gosub TURN_IN_CHECK
	if $roomid != 409 then gosub GO_ROOM 409
	gosub TURN_IN_CHECK
	if $roomid != 410 then gosub GO_ROOM 410
	gosub TURN_IN_CHECK
	if $roomid != 411 then gosub GO_ROOM 411
	gosub TURN_IN_CHECK
	if $roomid != 412 then gosub GO_ROOM 412
	gosub TURN_IN_CHECK
	if $roomid != 413 then gosub GO_ROOM 413
	gosub TURN_IN_CHECK
	goto TURN_IN_HIB

TURN_IN_CHECK:
  if matchre("$roomobjs", "%MASTER") then goto TURN_IN_1
  return

TURN_IN_1:
  gosub clear
	gosub GET my %LogType logbook
	put give %MASTER
#	if $roomid != %PRESTIGEROOM then gosub GO_ROOM %PRESTIGEROOM
#	put read my logbook
#	action put #echo >Log Orange $1 when In the weaponsmithing crafting Discipline, word of your ability has made you a (\S+ crafter) within the Society\.
#	pause 0.5
#	put read prestige board
#	pause
#	action remove In the weaponsmithing crafting Discipline, word of your ability has made you a (\S+ crafter) within the Society\.
  evalmath WorkOrdersCount (%WorkOrdersCount + 1)
	put #echo >Log Orange Workorder Completed.
	if (($Forging.LearningRate < 30) && (%WorkOrdersCount < %WorkOrdersMax)) then goto GO_TO_MASTER

DONE_WORKORDERS:
	if $roomid != %CRUCIBLEROOM then gosub GO_ROOM %CRUCIBLEROOM
  put put my logbook in my $craftpack
  gosub get my %ItemMaterial ingot from my $craftpack
  gosub get my deed packet from my $deedpack
  pause 0.5
  put push my %ItemMaterial ingot with my deed packet
  pause 0.5
  gosub put my deed packet into my $deedpack
  gosub put my %ItemMaterial deed in my $craftpack
  put release cyclic
	put #echo >Log Orange Workorders Done.
	put #parse Workorder Complete
	exit

### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

include includes.cmd
