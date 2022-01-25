# Cleanup and validate -- use includes

### USAGE .forge <weapon|black> <name.of.weapon> <metal for ingot> (tempered yes|no) (balance|hone) (number to make for workorder)
### Items in < > are required options, in ( ) are not.
### e.g.: .forge weapon dire.mace steel no hone 4

# variables this script needs to know to run: $craftpack, $hammer, $tongs

var BooksShort \b(bl|we|arm|car)(.+)?
var BooksLong	blacksmith|weapon|armor|carving
var MetalTypesShort bra|bro|cop|cov|iro|lea|nic|ora|pew|ste|tin|zin|ani|aur|dam|dar|ele|gla|gol|har|ker|lum|nin|ori|pla|tyr
var metalTypesLong brass|bronze|copper|covellite|iron|lead|nickel|oravir|pewter|steel|tin|zinc|animite|audrualm|damite|darkstone|electrum|glaes|gold|haralun|kertig|lumium|niniam|orichalcum|platinum|tyrium

#
#debug 5

if ("%1" = "") then
{
	echo USAGE .forge <weapon|blacksmith|armor> <item crafted> <metal for ingot> (tempered yes|no) (balance|hone) (number to make for workorder)
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
	echo USAGE .forge <weapon|blacksmith|armor> <item crafted> <metal for ingot> (tempered yes|no) (balance|hone) (number to make for workorder)
	exit
}
#MAGICS/MECHS
  var magic 1
  var cyclic 0
  var origami 0
  if ("%1" = "quick") then
  {
    var magic 0
    var cyclic 0
    var origami 0
    shift
  }
FORGE_CYCLIC:
  if %cyclic = 0 then goto CYCLIC_DONE
  put #var cam_leeched 1
  put #var cam_slipped 1
  var trainspell $train_cyclic
  if $spell_%trainspell_isactive = 0 then
  {
    put .cast $train_cyclic $train_cyclic_mana engaged
    waitfor Spell Cast
  }
CYCLIC_DONE:

put #var forgeitem %1
eval ForgeNoun replacere("%1", "\S+\.", "")
if contains("$forgeitem", "ball.and.chain") then put #var forgenoun ball
else put #var forgenoun %ForgeNoun
shift

var Material %1
shift

if matchre(tolower("%1"), "(y|no)") then
{
	if "$1" = "y" then var Temper 1
	else var Temper 0
}
else var Temper 0
shift

if matchre(tolower("%1"), "(bal|hon|rein|ligh)") then
{
	var Tech $1
	if "%Tech" = "bal" then var Tech 1
  if "%Tech" = "hon" then var Tech 2
  if "%Tech" = "rein" then var Tech 3
  if "%Tech" = "ligh" then var Tech 4
	}
else var Tech 0
shift

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
var Backpack 0
if ("%1" = "backpack") then
{
  var Backpack 1
  var Workorder 0
  shift
}
var Dump 0
if ("%1" = "dump") then
{
  var Dump 1
  var Workorder 0
}

var ItemsCount 0

BEGIN:
	gosub ALMANAC_CHECK
#	gosub CAM_FILL
TOOL_FIX:
#	pause .5
#	put .fix shovel
#	waitfor ITEM FIXED
	pause .5
	put .fix $tongs
	waitfor ITEM FIXED
	pause .5
	put .fix $hammer
	waitfor ITEM FIXED
	pause .5
	put .fix stamp
	waitfor ITEM FIXED
	pause .5
	put .fix bellows
	waitfor ITEM FIXED
	pause 1
  if "%BookType" = "armor" then
  {
 	put .fix pliers
	waitfor ITEM FIXED
	pause 1
  }
START_FORGE:
#	gosub CAM_FILL
FORGE_DOTS:
  if %cyclic = 1 then
  {
    pause 0.5
    put charge my $cambrinth_cyclic 48
    pause
    put invoke my $cambrinth_cyclic cyclic
    pause
  }
  if %magic = 1 then
  {
    #if %Backpack = 1 then
    #{
    #  put release wotm
    #  pause
    #}
    if $SpellTimer.WhispersoftheMuse.duration < 10 then
    {
      put .cast wotm 10 90
      waitfor Spell Cast
    }
#    put .cast compost $compost_mana
#    waitfor Spell Cast
  }
  if $bleeding = 1 then put healme
  if ((%cyclic = 1) && ($mana > 20) && (($cam_slipped = 1 || $cam_leeched = 1))) then gosub CAMB_CHARGE
	if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
	if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
	pause .5
BOOK_READ:
	if %ItemsCount = 0 then
	{
    if  matchre("$forgeitem" = "hawkbill|sterak.axe|triple-fluted.shovel|blunt.forging.hammer|wedge.tong|pointed.metal.pliers|forked.mixing.stick|diamond.wire.sieve|serrated.iltesh") then
    {
      gosub get $forgenoun instructions
      put read my instructions
    }
    else
    {
  		put .craftbook %BookType $forgeitem
	  	waitfor Book Turned
    }
		action (itemreqs) off
		pause .5
	}
#	if "%Assmble" = "\%Assemble" then unvar Assemble
  pause 0.5
	gosub GET %Material ingot from my $craftpack
	if "$righthandnoun" != "ingot" && "$lefthandnoun" != "ingot" then gosub GET %Material ingot from my $altcraftpack
	gosub PUT %Material ingot on anvil
	pause .5

BOOK_STUDY:
	if %ItemsCount > 0 then
  {
    if matchre("$forgeitem" = "hawkbill|sterak.axe|triple-fluted.shovel|blunt.forging.hammer|wedge.tong|pointed.metal.pliers|forked.mixing.stick|diamond.wire.sieve") then gosub get my $forgenoun instructions
    else gosub GET my book
    if %Backpack = 1 then
    {
      put .cast wotm 10 90
      waitfor Spell Cast
    }
  }
	matchre BOOK_STUDIED ^Roundtime
  if matchre("$forgeitem" = "hawkbill|sterak.axe|triple-fluted.shovel|blunt.forging.hammer|wedge.tong|pointed.metal.pliers|forked.mixing.stick|diamond.wire.sieve") then put study my $forgenoun instructions
	else put study my book
	matchwait 2
	goto BOOK_STUDY

BOOK_STUDIED:
	if !matchre("$lefthandnoun", "hammer|tongs") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "hammer|tongs") then gosub PUT my $righthandnoun in my $craftpack
	pause .5
	gosub GET $hammer
	gosub GET $tongs
  gosub ADJUST_TONGS
	pause .5

FIRST_STRIKE:
  action var Assemble $1 when ^You need another finished (.*) to continue crafting
	matchre TUB_TIME ^The .* now appears ready for cooling in the slack tub
	matchre TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
	matchre TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
	match TUB_TIME That tool does not seem suitable for that task
	matchre NEED_BELLOWS ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS ^As you finish working the fire dims and produces less heat from the stifled coals
	match NEED_FUEL The fire needs more fuel before you can do that.
	matchre NEED_FUEL ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL ^As you complete working the fire dies down and appears to need some more fuel
	matchre TURN_TONGS ^The .* could use some straightening along the horn of the anvil.
	matchre TURN_TONGS ^You notice the .* would benefit from some soft reworking
  matchre TURN_TONGS ^The metal must be drawn into wire on a mandrel and placed in mold sets using tongs
  matchre TURN_TONGS ^The metal now looks ready to be turned into wire using a mandrel or mold set
  matchre TURN_TONGS ^The metal must be transfered to plate molds and drawn into wire on a mandrel set using tongs
  match FIRST_TONGS You must be holding some metal tongs in your other hand to do that.  Otherwise who knows where that might bounce off to!
	match NO_PROBLEM Roundtime:
	put pound ingot on anvil with my $hammer
	matchwait 5
	goto FIRST_STRIKE

FIRST_TONGS:
  gosub ADJUST_TONGS
  goto FIRST_STRIKE

NEXT_STRIKE:
	matchre TUB_TIME ^The .* now appears ready for cooling in the slack tub
	matchre TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
	matchre TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
	match TUB_TIME That tool does not seem suitable for that task
	matchre NEED_BELLOWS ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS ^As you finish working the fire dims and produces less heat from the stifled coals
	match NEED_FUEL The fire needs more fuel before you can do that.
	matchre NEED_FUEL ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL ^As you complete working the fire dies down and appears to need some more fuel
	matchre TURN_TONGS ^The .* could use some straightening along the horn of the anvil.
	matchre TURN_TONGS ^You notice the .* would benefit from some soft reworking
  matchre TURN_TONGS ^The metal must be drawn into wire on a mandrel and placed in mold sets using tongs
  matchre TURN_TONGS ^The metal now looks ready to be turned into wire using a mandrel or mold set
  matchre TURN_TONGS ^The metal must be transfered to plate molds and drawn into wire on a mandrel set using tongs
  match NEXT_TONGS You must be holding some metal tongs in your other hand to do that.  Otherwise who knows where that might bounce off to!
	match NO_PROBLEM Roundtime:
	put pound $forgenoun on anvil with my $hammer
	matchwait 5
	goto NEXT_STRIKE

NEXT_TONGS:
  gosub ADJUST_TONGS
  goto NEXT_STRIKE

TURN_TONGS:
	pause 0.5
	matchre TUB_TIME ^The .* now appears ready for cooling in the slack tub
	matchre TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
	matchre TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
	matchre GOOD_POUND Roundtime|That tool does not seem suitable for that task
	put turn $forgenoun on anvil with my $tongs
	matchwait 2
	goto TURN_TONGS

NEED_BELLOWS:
	pause .5
	if (("$lefthandnoun" <> "bellows") && ("$lefthandnoun" <> "")) then gosub PUT my $lefthandnoun in my $craftpack
	pause .5
	gosub GET my bellows
NEED_BELLOWS_1:
	matchre TUB_TIME ^The .* now appears ready for cooling in the slack tub
	matchre TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
	matchre TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
	matchre GOOD_POUND Roundtime|That tool does not seem suitable for that task
	put push my bellows
	matchwait 2
	goto NEED_BELLOWS_1

NEED_FUEL:
	pause .5
	if (("$lefthandnoun" <> "tongs") && ("$lefthandnoun" <> "")) then gosub PUT my $lefthandnoun in my $craftpack
	pause .5
	gosub GET my tongs
  gosub ADJUST_SHOVEL

NEED_FUEL_1:
#	matchre TUB_TIME ^The .* now appears ready for cooling in the slack tub
#	matchre TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
#	matchre TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
#	matchre GOOD_POUND Roundtime|That tool does not seem suitable for that task
	matchre TONG_TUB_TIME ^The .* now appears ready for cooling in the slack tub
	matchre TONG_TUB_TIME ^The .* now appears ready for quench hardening in the slack tub
	matchre TONG_TUB_TIME ^The .* is complete and ready for a quench hardening in the slack tub
	matchre TONG_GOOD_POUND Roundtime|That tool does not seem suitable for that task
	put push fuel with my tongs
	matchwait 2
	goto NEED_FUEL_1

ADJUST_SHOVEL:
  match RETURN You lock the tongs into a fully extended position.  Then you reach alongside the tong's body, and pull free the head of a shovel.
  match ADJUST_SHOVEL With a yank you fold the shovel head back alongside the tong's body.  Then you unlock the arms, readying them for use as tongs once more.
  put adjust my tongs
  matchwait 1
  goto ADJUST_SHOVEL

ADJUST_TONGS:
  match RETURN With a yank you fold the shovel head back alongside the tong's body.  Then you unlock the arms, readying them for use as tongs once more.
  match ADJUST_TONGS You lock the tongs into a fully extended position.  Then you reach alongside the tong's body, and pull free the head of a shovel.
  put adjust my tongs
  matchwait 1
  goto ADJUST_TONGS

TONG_GOOD_POUND:
  gosub ADJUST_TONGS
  GOTO GOOD_POUND

TONG_TUB_TIM:
  gosub ADJUST_TONGS
  GOTO TUB_TIME

GOOD_POUND:
	pause .5
	if (("$lefthandnoun" <> "tongs") && ("$lefthandnoun" <> "")) then gosub PUT my $lefthandnoun in my $craftpack
	if (("$righthandnoun" <> "hammer") && ("$righthandnoun" <> "")) then gosub PUT my $righthandnoun in my $craftpack
	pause .5
	if ("$righthandnoun" <> "hammer") then gosub GET my $hammer
	if ("$lefthandnoun" <> "tongs") then gosub GET my $tongs
NO_PROBLEM:
	if matchre("$roomobjs", "ingot") then goto STOW_INGOT
	pause
	goto NEXT_STRIKE

STOW_INGOT:
	pause .5
	gosub PUT my $tongs in my $craftpack
	gosub GET ingot
	gosub PUT my ingot in my $craftpack
	gosub GET my $tongs
	goto NO_PROBLEM

TUB_TIME:
	pause .5
	if ("$lefthandnoun" <> "") then gosub PUT my $lefthandnoun in my $craftpack
	if ("$righthandnoun" <> "") then gosub PUT my $righthandnoun in my $craftpack
	pause 0.5
TUB_TIME_1:
  match ASSEMBLE_%BookType some oil to preserve and protect it.
	match ASSEMBLE_%BookType Roundtime
	match ASSEMBLE_%BookType That tool does not seem suitable for that task
  match ASSEMBLE_%BookType appears ready for grinding and polishing on a grinding wheel.
	put push tub
	matchwait 2
	GOTO TUB_TIME_1

GRINDER:
	match GRINDER Roundtime
	match GRINDER It seems to be picking up speed now but is still rather slow.
	match GRINDER Ok, it seems to be picking up speed now, though still rather slow.
	match GRIND_IT Straining a bit less you add force to the grindstone, making it spin even faster.
	match GRIND_IT Straining a bit less you maintain force to the grindstone, keeping it spinning fast.
	put turn grind
	matchwait 2
	goto GRINDER

GRIND_IT:
	match GRINDER The grinding wheel is not spinning fast|The grinding wheel needs to be spinning before
	match GRIND_IT Roundtime
	matchre OIL With grinding complete|That tool does not seem suitable for that task
	put push grindstone with my $forgenoun
	matchwait 5
	goto GRIND_IT

ASSEMBLE_WEAPON:
ASSEMBLE_BLACK:
ASSEMBLE_BLACKSMITH:
  pause
 	eval Assemble replace("%Assemble", " ", ".")
	eval Assemble replacere("%Assemble", "metal\.|leather\.|wooden\.|cloth\.", "")
	gosub GET $forgenoun from anvil
	if (("%Assemble" <> "") && ("%Assemble" <> "\%Assemble")) then
  {
    gosub get my %Assemble
		put assemble my $forgenoun with my %Assemble
    pause
  }
 	if "%BookType" = "weapon" then goto GRINDER
  else goto PRE_OIL

ASSEMBLE_ARMOR:
  pause
	gosub GET $forgenoun from anvil
ASSEMBLE_ARMOR_2:
  if (("$lefthandnoun" = "pliers") || ("$righthandnoun" = "pliers")) then gosub put my $pliers in my $craftpack
	eval Assemble replace("%Assemble", " ", ".")
	eval Assemble replacere("%Assemble", "metal\.|leather\.|wooden\.|cloth\.", "")
	if (("%Assemble" <> "") && ("%Assemble" <> "\%Assemble")) then
  {
    gosub get my %Assemble
    put assemble my $forgenoun with my %Assemble
  }
  goto PLIERS

PLIERS:
  gosub get my $pliers
  goto PULL_IT

PULL_IT:
  match DONE_PULL oil to preserve and protect it
  match PULL_IT using pliers to pull them together
  match PULL_IT appear ready to be woven into and around the material
  match PULL_IT Roundtime
  match ASSEMBLE_ARMOR_2 ASSEMBLE
  match ASSEMBLE_ARMOR_2 That tool does not seem suitable for that task.
	put pull my $forgenoun with my $pliers
	matchwait 5
	goto PULL_IT

DONE_PULL:
  gosub put my $pliers in my $craftpack
  goto OIL

PRE_OIL:
OIL:
  if (("$lefthandnoun" <> "$forgenoun") && ("$righthandnoun" <> "$forgenoun")) then gosub get $forgenoun from anvil
	var Last OIL
	var Disposable oil
	gosub GET my of oil
OIL_1:
	match OILED Roundtime
	match FORGEBUY Pour what?
	put pour my oil on my $forgenoun
	matchwait 2
	goto OIL_1
OILED:
	gosub PUT my oil in my $craftpack

#  goto TEMPERING

STAMP:
	gosub GET my stamp
STAMP_1:
	matchre STAMP_2 ^Roundtime|^You cannot figure out how to do that|^The stamp is too badly damaged to be used for that.
	put mark my $forgenoun with my stamp
	matchwait 2
	goto STAMP_1
STAMP_2:
	gosub PUT my stamp in my $craftpack
	goto TEMPERING

TEMPERING:
	if %Temper = 1 then
	{
		put .temper $forgenoun
		waitfor Item Tempered
	}
GRINDING:
  if ((%Tech != 0) && ($forgeapp = 1)) then
  {
   	put .forgeapp
  	pause
  	put analyze my $forgenoun
  	pause 5
  	put app my $forgenoun careful
  	pause 5
  }
	if %Tech = 1 then
	{
		put .forge_grind $forgenoun balance
		waitfor Item Ground
		goto APP
	}
	if %Tech = 2 then
	{
		put .forge_grind $forgenoun hone
		waitfor Item Ground
		goto APP
	}
  if %Tech = 3 then
 	{
		put .forge_grind $forgenoun reinforce
		waitfor Item Ground
		goto APP
	}
  if %Tech = 4 then
 	{
		put .forge_grind $forgenoun lighten
		waitfor Item Ground
		goto APP
	}

APP:
if %Workorder = 1 then goto WORKORDER
if %Dump = 1 then goto WORKORDER
if %Backpack = 1 then goto WORKORDER
if $forgeapp = 1 then
{
 	put .forgeapp
	pause
 	put analyze my $forgenoun
 	pause 5
 	put app my $forgenoun careful
 	pause 5
}

WORKORDER:
  if %Dump = 1 then put put my $forgenoun in bucket
  if %Backpack = 1 then gosub put my $forgenoun in my backpack
#  goto MORE_CHECK
	if %Workorder = 1 then
	{
		gosub GET my forging logbook
		put bundle my $forgenoun with my logbook
		action put #echo >Log Orange $1 when You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		pause 0.5
		put read my forging logbook
		pause
		action remove You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		gosub PUT my forging logbook in my $craftpack
	}

MORE_CHECK:
	gosub ALMANAC_CHECK
	math ItemsCount add 1
  if %Workorder = 0 then put #echo >Log Orange $forgenoun %ItemsCount completed.
	if (%MaxItems > %ItemsCount) then
  {
    if %Backpack = 1 then goto START_FORGE
    goto START_FORGE
    if (($Forging.LearningRate > 32) && (%origami = 1) && ($Mechanical_Lore.LearningRate < 21)) then
    {
      put .origami
      waitfor Origami Complete
      goto START_FORGE
    }
    elseif (($Forging.LearningRate > 32) && ($Scholarship.LearningRate < 33)) then
    {
      put .schol
      waitfor Done Scholarship
  		put .craftbook %BookType $forgeitem
	  	waitfor Book Turned
      goto START_FORGE
    }
    goto START_FORGE
  }

echo ********************
echo * ALL DONE!  WHEE! *
echo ********************
#put #script abort enc;-stop sing;-release all
gosub ALMANAC_CHECK
put #echo >Log Black,Red Forging Done!
put #play info
put #parse Items Forged
exit

### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts
include includes.cmd

FORGEBUY:
  var curr_room $roomid
  gosub go_room 407
BRUSHBUY:
  match OILBUY You tap a
  match BRUSHBUY_1 I could not find what you were referring to.
  put tap my fourth wire brush in my $craftpack
  matchwait 2
  goto BRUSHBUY
BRUSHBUY_1:
  pause
  put order 10;order 10
  gosub put my wire brush in my $craftpack
  goto BRUSHBUY
OILBUY:
#  var curr_room $roomid
#  gosub go_room 407
OILBUY_1:
  match OILBUY_DONE You tap a
  match OILBUY_2 I could not find what you were referring to.
  put tap my fourth of oil in my $craftpack
  matchwait 2
  goto OILBUY_1
OILBUY_2:
  pause
  put order 6;order 6
  gosub put my of oil in my $craftpack
  goto OILBUY_1
OILBUY_DONE:
  gosub go_room %curr_room
  goto OIL
