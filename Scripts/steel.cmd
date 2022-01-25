# combine with ingot1 & crucible, etc... and ingotmaker

# Makes a forging ingot of steel
var IngotMat steel
var NuggetMat iron
var OrderNumber 7
var CoalNumber 2

var HC 0
IF_2 var HC 1

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
  var FORGEROOM 418
  var CRUCIBLEROOM 411
  var TOOLSROOM 413
  var SUPPLYROOM 415
  var PRESTIGEROOM 407
}

if $roomid != %SUPPLYTOOM then gosub GO_ROOM %SUPPLYROOM

var IngotCount 0
var CoalCount 0

BUY_INGOTS:
if %IngotCount < 21 then
{
	put order %OrderNumber;order %OrderNumber
	pause 0.5
	gosub put my %NuggetMat nugget in my $craftpack
	pause 0.5
	math IngotCount add 1
	goto BUY_INGOTS
}
BUY_COAL:
if %CoalCount < 42 then
{
	put order %CoalNumber;order %CoalNumber
	pause 0.5
	gosub put my coal nugget in my $craftpack
	pause 0.5
	math CoalCount add 1
	goto BUY_COAL
}

var IngotCount 0
MAKE_INGOTS:
if %IngotCount >= 2 then goto COMBINE_INGOTS
var NuggetCount 0
if %IngotCount = 0 then var NuggNeeded 11
else var NuggNeeded 10
var CoalCount 0
if %IngotCount = 0 then var CoalNeeded 22
else var CoalNeeded 20

goto SMELT_COAL

SMELT_COAL:
if $roomid != %CRUCIBLEROOM then gosub GO_ROOM %CRUCIBLEROOM
if %CoalCount < %CoalNeeded then
{
	gosub get coal nugget from my $craftpack
	gosub put my coal nugget in crucible
	pause 0.5
	math CoalCount add 1
	goto SMELT_COAL
}

SMELT_NUGGETS:
if $roomid != %CRUCIBLEROOM then gosub GO_ROOM %CRUCIBLEROOM
if %NuggetCount < %NuggNeeded then
{
	gosub get %NuggetMat nugget from my $craftpack
	gosub put my %NuggetMat nugget in crucible
	pause 0.5
	math NuggetCount add 1
	goto SMELT_NUGGETS
}

CRUCIBLE:
  put .crucible %IngotMat
  waitfor Ingot Smelted
  if "$righthandnoun" <> "" then gosub put my $righthandnoun in my $craftpack
  if "$lefthandnoun" <> "" then gosub put my $lefthandnoun in my $craftpack
  math IngotCount add 1
  #gosub get ingot from my satchel
  #gosub put ingot in crucible
  #put .crucible iron flux
  #waitfor Ingot Smelted
  GOTO MAKE_INGOTS

COMBINE_INGOTS:
  gosub get my steel ingot from my $craftpack
  gosub put my steel ingot in crucible
  gosub get my steel ingot from my $craftpack
  gosub put my steel ingot in crucible

RESMELT:
	put .crucible %IngotMat
	waitfor Ingot Smelted
	goto DONE

DONE:
put #parse Ingot Made
exit


### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

include includes.cmd
