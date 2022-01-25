# combine with ingot1 & crucible, etc... and ingotmaker

# Makes a forging ingot of steel
var IngotMat steel
var NuggetMat iron
var OrderNumber 7
var CoalNumber 2

#gosub put my ingot in my $craftpack

if $zoneid = 67 then
{
  var LOCATION SHARD
  var MASTER Serric
  var FORGEROOM 657
  var CRUCIBLEROOM 656
  var TOOLSROOM 653
  var SUPPLYROOM 658
  var PRESTIGEROOM 645
}
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

if $roomid != %SUPPLYTOOM then gosub GO_ROOM %SUPPLYROOM

var IngotCount 0
var CoalCount 0

BUY_INGOTS:
if %IngotCount < 15 then
{
	put order %OrderNumber;order %OrderNumber
	pause 0.5
	gosub put my %NuggetMat nugget in my $craftpack
	pause 0.5
	math IngotCount add 1
	goto BUY_INGOTS
}
BUY_COAL:
if %CoalCount < 30 then
{
	put order %CoalNumber;order %CoalNumber
	pause 0.5
	gosub put my coal nugget in my $craftpack
	pause 0.5
	math CoalCount add 1
	goto BUY_COAL
}


var IngotCount 0
var CoalCount 0
goto SMELT_COAL

SMELT_COAL:
if $roomid != %CRUCIBLEROOM then gosub GO_ROOM %CRUCIBLEROOM
if %CoalCount < 30 then
{
	gosub get coal nugget from my $craftpack
	gosub put my coal nugget in crucible
	pause 0.5
	math CoalCount add 1
	goto SMELT_COAL
}

goto SMELT_INGOTS

SMELT_INGOTS:
if $roomid != %CRUCIBLEROOM then gosub GO_ROOM %CRUCIBLEROOM
if %IngotCount < 15 then
{
	gosub get %NuggetMat nugget from my $craftpack
	gosub put my %NuggetMat nugget in crucible
	pause 0.5
	math IngotCount add 1
	goto SMELT_INGOTS
}

CRUCIBLE:
  put .crucible quick %IngotMat
  waitfor Ingot Smelted
  var resmelt 0
  #gosub get ingot from my satchel
  #gosub put ingot in crucible
  #put .crucible iron flux
  #waitfor Ingot Smelted

CHECK_LEFTOVERS:
	 match LEFTOVERs_0 You tap
   match DONE I could not find what
   put tap %IngotMat ingot in my $craftpack
	 matchwait 1
goto CHECK_LEFTOVERS

LEFTOVERS_0:
  gosub put my %IngotMat ingot in crucible

LEFTOVERS:
	pause .2
  matchre LEFTOVERS ^\.\.\.wait|^Sorry
	match CHECK_DEED What were you referring to?
  matchre LEFTOVERS_1 ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up
  send get %IngotMat ingot from my $craftpack
  matchwait 2
	goto LEFTOVERS
LEFTOVERS_1:
	matchre LEFTOVERS_1 ^\.\.\.wait|^Sorry
	matchre LEFTOVERS_2 ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	match TOO_BIG Roundtime
	send put my %IngotMat ingot in crucible
	matchwait 2
	goto LEFTOVERS_1
LEFTOVERS_2:
  var resmelt 1

TOO_BIG:
	gosub put my %IngotMat ingot in bucket
	goto LEFTOVERS

CHECK_DEED:
  pause .2
  match UNDEED_INGOT You must be holding the deed before you turn it in
  match NO_DEED I could not find what you were referring to.
  send tap my %IngotMat deed in my $craftpack
  matchwait 2
  goto CHECK_DEED

UNDEED_INGOT:
  gosub GET %IngotMat deed from my $craftpack
  pause 0.5
DEED_CHECK:
  var DeedSize 0
  pause 0.5
  action (deeds) var DeedSize $1 when Volume:\s+(\d+)
  action (deeds) on
  put read my %IngotMat deed
  waitforre PhysicalResist|I could not find what you were referring to\.
  pause
DEED_DONE:
  action (deeds) off
  put tap my %IngotMat deed
  pause 0.5
#goto UNDEED_TOOMUCH
  if $righthandnoun != "ingot" && $lefthandnoun != "ingot" then gosub get %IngotMat ingot
  if %DeedSize > 60 then goto UNDEED_TOOMUCH
UNDEED_INGOT_1:
  pause 0.5
  matchre UNDEED_INGOT_2 ^You drop|^You put|^You reverently place|^What were you referring to\?|^You briefly twist the top|^As you put the
  matchre UNDEED_TOOMUCH You decide that smelting such a volume metal at once would be dangerous|You decide that smelting so many metal pieces at once would be dangerous|As you start to place
  put PUT my %IngotMat ingot in crucible
  matchwait 2
  goto UNDEED_INGOT_1

UNDEED_INGOT_2:
  var resmelt 1
  goto CHECK_DEED

UNDEED_TOOMUCH:
  gosub PUT my %IngotMat ingot in bucket
  goto CHECK_DEED

NO_DEED:
PLAT_NUGG_CHECK:
    matchre PLAT_NUGG_CHECK_1 ^You drop|^You put|^You reverently place
    matchre GOLD_NUGG_CHECK ^What were you referring to\?
  matchre NUGG_TOOMUCH ^You decide that smelting such a volume of metal at once would be dangerous|^You decide that smelting so many metal pieces at once would be dangerous
  put get my plat nugget;PUT my plat nugget in crucible
  matchwait 4
  goto PLAT_NUGG_CHECK

PLAT_NUGG_CHECK_1:
  var resmelt 1
  goto PLAT_NUGG_CHECK

GOLD_NUGG_CHECK:
    matchre GOLD_NUGG_CHECK_1 ^You drop|^You put|^You reverently place
    matchre DONE_NUGG_CHECK ^What were you referring to\?
  matchre NUGG_TOOMUCH ^You decide that smelting such a volume of metal at once would be dangerous, and stop\.|^You decide that smelting so many metal pieces at once would be dangerous, and stop\.
  put get my gold nugget;PUT my gold nugget in crucible
  matchwait 4
  goto GOLD_NUGG_CHECK

GOLD_NUGG_CHECK_1:
  var resmelt 1
  goto GOLD_NUGG_CHECK

NUGG_TOOMUCH:
  gosub put my nugget in my $craftpack
  goto RESMELT

DONE_NUGG_CHECK:
  goto RESMELT

RESMELT:
  if %resmelt = 0 then goto DONE
	put .crucible quick %IngotMat
	waitfor Ingot Smelted
	goto DONE

DONE:
if "$righthandnoun" <> "" then gosub put my $righthandnoun in my $craftpack
if "$lefthandnoun" <> "" then gosub put my $lefthandnoun in my $craftpack
put #parse Ingot Made
exit


### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

include includes.cmd
