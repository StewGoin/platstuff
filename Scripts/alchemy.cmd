## Alchemy Script

### USAGE .outfit <name.of.item> <material> (number to make for workorder)
### Items in < > are required options, in ( ) are not.
### e.g.: .outfit tailor cloth.socks burlap.cloth 3

# variables this script needs to know to run: $craftpack, $needles, $slickstone, $yardstick, $scissors

var BooksShort \b(rem|poi|coo)(.+)?
var BooksLong	remedies|poisons|cooking

#debug 5


if ("%1" = "") then
{
	echo USAGE .outfit <remed|poison|cook> <item crafted> <material> (number to make for workorder)
	exit
}

eval BookMatch tolower("%1")
if matchre("%BookMatch", "%BooksShort") then
{
	var BookType %1
	shift
}
else
{
  echo USAGE .outfit <remed|poison|cook> <item crafted> <material> (number to make for workorder)
	exit
}

#MAGICS/MECHS
  var magic 1
  var origami 1
  if ("%1" = "quick") then
  {
    var magic 0
    var origami 0
    shift
  }
START_CYCLIC:
  if %magic = 0 then goto CYCLIC_DONE
  put #var cam_leeched 1
  put #var cam_slipped 1
  var trainspell $train_cyclic
  if (($spell_%trainspell_isactive = 0) &&  ($spell_ghs_isactive=0)) then
  {
    put .cast $train_cyclic $train_cyclic_mana engaged
    waitfor Spell Cast
  }
CYCLIC_DONE:

put #var alchemy_item %1
eval AlchemyNoun replacere("%1", "\S+\.", "")
put #var alchemy_noun %AlchemyNoun
shift

var Material %1
shift
#var Material2 %1
#shift

if ("%1" = "") then
{
	var MaxItems 1
	var Workorder 0
}	
else
{
	setvar MaxItems %1
	setvar Workorder 1
}
shift
if ("%1" = "dump") then var Dump 1
else var Dump 0

var ItemsCount 0

BEGIN:
#	gosub CAM_FILL
TOOL_FIX:
	pause .5
	put .fix mortar
	waitfor ITEM FIXED
  pause .5
	put .fix pestle
	waitfor ITEM FIXED
  pause .5
  put .fix scissors
  waitfor ITEM FIXED
START_ALCHEMY:
#	gosub CAM_FILL
ALCHEMY_BUFFS:
  if %magic = 1 then
  {
    pause 0.5
    put charge my belt 50
    pause
    put invoke my belt cyclic 
    pause
  }
  if %magic = 1 then
  {
    if $spell_wotm_isactive = 0 then
    {
      put .cast wotm 10 90
      waitfor Spell Cast
    }
  }
  if ((%magic = 1) && ($mana > 20) && (($cam_slipped = 1 || $cam_leeched = 1))) then gosub CAMB_CHARGE
	if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
	if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
	pause .5
BOOK_READ:
#	if "%Assmble" = "\%Assemble" then unvar Assemble

BOOK_STUDY:
#  action (yards) var yards $1 when material \((\d+) yards\)$
#  action (yards) var yards $1 when cloth \((\d+) yards\)$
#  action (yards) var yards 1 when \(1 yard\)$
#  action (yards) var have $1 when You count out (\d+) yards of material there\.$
#  action (yards) on
  if "$alchemy_item" = "hawkbill" then
  {
    gosub get my hawkbill instructions
    put read my instructions
  }
  else
  {
    put .craftbook %BookType $alchemy_item
		waitfor Book Turned
  }
#  action (yards) off
	pause .5
	}
	if %ItemsCount > 0 then
  {
    if "$alchemy_item" = "hawkbill" then gosub get my hawkbill instructions
    else gosub GET my %BookType book
  }
	matchre BOOK_STUDIED ^Roundtime
  if "$alchemy_item" = "hawkbill" then put study my hawkbill instructions
	else put study my %BookType book
	matchwait 2
	goto BOOK_STUDY

BOOK_STUDIED:
  var MatSize 0
  action (matcount) var MatSize $1 when You count out (\d+) pieces of material there
  action (matcount) on
	gosub PUT my $lefthandnoun in my $craftpack
	gosub PUT my $righthandnoun in my $craftpack
	pause .5
  gosub GET %Material
  put count my %Material
  waitforre pieces of material there|I could not find what you were referring to\.
  action (matcount) off
  if %MatSize == 0 then
  {
    echo error
    exit
  }
  if %MatSize <= 5 then goto PRE_CRUSH
  var ITEM_COMPLETE 0
  action var ITEM_COMPLETE 1 when ^Applying the final touches, you complete working
  goto MARK_MATERIAL

MARK_MATERIAL:
  match CUT_MATERIAL You measure out
  match NOT_ENOUGH There is not enough
  put mark my $righthandnoun at 5
  matchwait 2
  goto MARK_MATERIAL

CUT_MATERIAL:
  gosub get my scissors
CUT_MATERIAL_1:
  match CUT_MATERIAL_2 You carefully cut
  put cut my %Material with my scissors
  matchwait 2
  goto CUT_MATERIAL_1
CUT_MATERIAL_2:
  gosub put my scissors in my $craftpack
  gosub put my %Material in my $craftpack
  goto PRE_CRUSH

PRE_CRUSH:
  var AlchemyTool1 mortar
  var AlchemyTool2 pestle
  if "$alchemy_noun" = "potion" then
  {
    var AlchemyTool1 large.bowl
    var AlchmeyTool2 mixing.stick
  }
  gosub get %Material
  gosub get my %AlchemyTool1
  put dump %AlchemyTool1 into bucket
  pause 0.5
  put dump %AlchemyTool1 into bucket
  pause 0.5
  gosub put my %Material in my %AlchemyTool1
  gosub get my pestle
  var ITEM_COMPLETE 0
  action var ITEM_COMPLETE 1 when ^Applying the final touches, you complete working
  var NEED_WATER 0
  action var NEED_WATER 1 when ^You need another splash of water to continue crafting
  var NEED_ALCOHOL 0
  action var NEED_ALCOHOL 1 when ^You need another splash of alcohol to continue crafting
  var NEED_CATALYST 0
  action var NEED_CATALYST 1 when ^You need another catalyst material to continue crafting
  var NEED_HERB2 0
  action var NEED_HERB2 1 when ^You need another prepared herb to continue crafting
  goto FIRST_CRUSH

FIRST_CRUSH:
  match CRUSH_IT Roundtime
  put crush %Material in mortar with pestle
  matchwait 2
  goto FIRST_CRUSH

CRUSH_IT:
  if matchre ("$lefthandnoun", "water|nugget") then gosub put my $lefthandnoun in my $craftpack
  if matchre ("$righthandnoun", "water|nugget") then gosub put my $righthandnoun in my $craftpack
  if !matchre("$lefthandnoun", "mortar|pestle") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "mortar|pestle") then gosub PUT my $righthandnoun in my $craftpack
  if (("$righthandnoun" <> "pestle") && ("$lefthandnoun" <> "pestle")) then gosub get my pestle
  if %ITEM_COMPLETE = 1 then goto DONE_CRUSHING
  if %NEED_WATER = 1 then gosub NEED_WATER
  if %NEED_ALCOHOL = 1 then gosub NEED_ALCOHOL
  if %NEED_CATALYST = 1 then gosub NEED_CATALYST
  if %NEED_HERB2 = 1 then gosub NEED_HERB2
  match SIEVE_IT Upon completion you see some particulate clouding up the mixture
  match TURN_IT Once finished you notice clumps of material forming on the edge of the mortar.
  match SMELL_IT As you finish, the mixture begins to transition colors
  match NEED_HERB2 You need another prepared herb to continue crafting
  match CRUSH_IT Roundtime
  put crush $alchemy_noun in mortar with pestle
  matchwait 2
  goto CRUSH_IT

SIEVE_IT:
  if matchre ("$lefthandnoun", "water|nugget") then gosub put my $lefthandnoun in my $craftpack
  if matchre ("$righthandnoun", "water|nugget") then gosub put my $righthandnoun in my $craftpack
  if !matchre("$lefthandnoun", "mortar|sieve") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "mortar|sieve") then gosub PUT my $righthandnoun in my $craftpack
  if (("$righthandnoun" <> "pestle") && ("$lefthandnoun" <> "pestle")) then gosub get my sieve
  if %ITEM_COMPLETE = 1 then goto DONE_CRUSHING
  if %NEED_WATER = 1 then gosub NEED_WATER
  if %NEED_ALCOHOL = 1 then gosub NEED_ALCOHOL
  if %NEED_CATALYST = 1 then gosub NEED_CATALYST
  if %NEED_HERB2 = 1 then gosub NEED_HERB2
  match SIEVE_IT Upon completion you see some particulate clouding up the mixture
  match TURN_IT Once finished you notice clumps of material forming on the edge of the mortar.
  match SMELL_IT As you finish, the mixture begins to transition colors
  match NEED_HERB2 You need another prepared herb to continue crafting
  match CRUSH_IT Roundtime
  put push $alchemy_noun in mortar with sieve
  matchwait 2
  goto SIEVE_IT

SMELL_IT:
  if %ITEM_COMPLETE = 1 then goto DONE_CRUSHING
  if %NEED_WATER = 1 then gosub NEED_WATER
  if %NEED_ALCOHOL = 1 then gosub NEED_ALCOHOL
  if %NEED_CATALYST = 1 then gosub NEED_CATALYST
  if %NEED_HERB2 = 1 then gosub NEED_HERB2
  match SIEVE_IT Upon completion you see some particulate clouding up the mixture
  match TURN_IT You see things accumulate
  match SMELL_IT As you finish, the mixture begins to transition colors
  match CRUSH_IT That tool does not seem suitable
  match CRUSH_IT Roundtime
  put smell $alchemy_noun in mortar
  matchwait 2
  goto SMELL_IT
  
TURN_IT:
  if %ITEM_COMPLETE = 1 then goto DONE_CRUSHING
  if %NEED_WATER = 1 then gosub NEED_WATER
  if %NEED_ALCOHOL = 1 then gosub NEED_ALCOHOL
  if %NEED_CATALYST = 1 then gosub NEED_CATALYST
  if %NEED_HERB2 = 1 then gosub NEED_HERB2
  match SIEVE_IT Upon completion you see some particulate clouding up the mixture
  match TURN_IT You see things accumulate
  match SMELL_IT As you finish, the mixture begins to transition colors
  match CRUSH_IT That tool does not seem suitable
  match CRUSH_IT Roundtime
  put turn my mortar
  matchwait 2
  goto TURN_IT

NEED_HERB2:
  var assemble %Material2
  var NEED_HERB2 0
  goto ASSEMBLE
NEED_WATER:
  var assemble water
  var NEED_WATER 0
  goto ASSEMBLE
NEED_ALCOHOL:
  var assemble alcohol
  var NEED_ALCOHOL 0
  goto ASSEMBLE
NEED_CATALYST:
  var NEED_CATALYST 0
  var assemble coal.nugget
  goto ASSEMBLE

ASSEMBLE:
  if "$lefthandnoun" = "mortar" then gosub PUT my $righthandnoun in my $craftpack
	if "$righthandnoun" = "mortar" then gosub PUT my $lefthandnoun in my $craftpack
  gosub get %assemble from $craftpack
ASSEMBLE_1:
  matchre RETURN ^You toss \w+ \w+ into the mortar|^You realize the|^You vigorously rub
  put put my %assemble in my mortar
  matchwait 2
  goto ASSEMBLE_1

include includes.cmd

DONE_CRUSHING:

ITEM_FINISHED:

WORKORDER:	
  if %Dump = 1 then
  {
    put dump mortar into bucket
    pause 0.5
    put dump mortar into bucket
    pause 0.5
    goto MORE_CHECK
  }

MORE_CHECK:	
	math ItemsCount add 1
  if %Workorder = 0 then put #echo >Log Orange $alchemy_noun %ItemsCount completed.
  if %Dump = 1 then
  {
    if $Alchemy.LearningRate >= 32 then goto DONE_ALCHEMY
    else goto START_ALCHEMY
  }

NOT_ENOUGH:
    put dump mortar into bucket
    pause 0.5
    put dump mortar into bucket
    pause 0.5

DONE_ALCHEMY:
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
  put #parse Done Alchemy
  pause 0.5

exit

