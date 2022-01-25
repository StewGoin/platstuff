## Engineering Script

### USAGE .engineer <stone|bone> <name.of.item> <material> <material size> (number to make for workorder)
### Items in < > are required options, in ( ) are not.
### e.g.: .engineer forked.stone.stirring.rod alabaster 4

# variables this script needs to know to run: $craftpack, $chisel, $riffler, $rasp

var BooksShort \b(car|sha|tin)(.+)?
var BooksLong	carving|shaping|tinkering

#debug 5

if ("%1" = "") then
{
	echo USAGE .engineer <|blacksmith|armor> <item crafted> <metal for ingot> (tempered yes|no) (balance|hone) (number to make for workorder)
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
	echo USAGE .engineer <carving|shaping|tinkering> <item crafted> <material> (number to make for workorder)
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
  if $spell_%trainspell_isactive = 0 then
  {
    put .cast $train_cyclic $train_cyclic_mana engaged
    waitfor Spell Cast
  }
CYCLIC_DONE:

put #var engineer_item %1
eval EngineerNoun replacere("$engineer_item", "\S+\.", "")
#if contains("$engineer_item", "ball.and.chain") then put #var forgenoun ball
#else put #var forgenoun %ForgeNoun
put #var engineer_noun %EngineerNoun
shift

var Material %1
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
if ("%1" = "dump") then var Dump 1
else var Dump 0

var ItemsCount 0

BEGIN:
  gosub ALMANAC_CHECK
#	gosub CAM_FILL
TOOL_FIX:
	pause .5
	put .fix $saw
	waitfor ITEM FIXED
  pause .5
	put .fix $chisel
	waitfor ITEM FIXED
	pause .5
	put .fix $rasp
	waitfor ITEM FIXED
	pause .5
	put .fix $riffler
	waitfor ITEM FIXED
	pause .5
	put .fix stamp
	waitfor ITEM FIXED
START_ENGINEERING:
#	gosub CAM_FILL
ENGINEER_BUFFS:
  if %magic = 1 then
  {
    pause 0.5
    put charge my $cambrinth_cyclic 50
    pause
    put invoke my $cambrinth_cyclic cyclic
    pause
  }
  #if %magic = 1 then
  #{
  #  if $SpellTimer.PlatinumHandsofKertigen.active = 0 then
  #  {
  #    put .cast phk 0
  #    waitfor Spell Cast
  #  }
#    put .cast compost $compost_mana
#    waitfor Spell Cast
  }
#  if $bleeding = 1 then put healme
  if ((%magic = 1) && ($mana > 20) && (($cam_slipped = 1 || $cam_leeched = 1))) then gosub CAMB_CHARGE
	if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
	if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
	pause .5
BOOK_READ:
#	if "%Assmble" = "\%Assemble" then unvar Assemble
  if matchre("$roomobjs", "(boulder|rock|stone|pebble)") then
  {
    var MaterialSize $1
    if matchre("$engineer_item", "image") then
    {
      if "%MaterialSize" = "pebble" then
      {
        put #var engineer_noun bead
        put #var engineer_item $engineer_train_pebble
      }
      if "%MaterialSize" = "stone" then
      {
        put #var engineer_noun totem
        put #var engineer_item $engineer_train_stone
      }
      if (("%MaterialSize" = "rock") && matchre("$roomobjs", "small \w+ rock")) then
      {
        put #var engineer_noun figurine
        put #var engineer_item $engineer_train_smallrock
      }
      if (("%MaterialSize" = "rock") && matchre("$roomobjs", "large \w+ rock")) then
      {
        put #var engineer_noun statuette
        put #var engineer_item $engineer_train_largerock
      }
      if "%MaterialSize" = "boulder" then
      {
        put #var engineer_noun statue
        put #var engineer_item $engineer_train_boulder
      }
      if matchre("%MaterialSize", "rock") then var MaterialSize rock
    }
  }
  else
  {
    if "$engineer_noun" = "image" then
    {
      gosub get my boulder deed
      put tap my boulder deed
      var MaterialSize boulder
      put #var engineer_noun statue
      put #var engineer_item $engineer_train_boulder
      goto BOOK_STUDY
    }
#    else
#    {
#	    gosub GET %MaterialSize deed
#	    put tap my deed
#	    pause .5
#    }
#  else gosub GET stack
  }

BOOK_STUDY:
  if "$engineer_item" = "hawkbill" then
  {
    gosub get my hawkbill instructions
    put read my instructions
  }
  else
  {
    put .craftbook %BookType $engineer_item
		waitfor Book Turned
  }
	action (itemreqs) off
	pause .5
	}

	if %ItemsCount > 0 then
  {
    if "$engineer_item" = "hawkbill" then gosub get my hawkbill instructions
    else gosub GET my book
  }
	matchre BOOK_STUDIED ^Roundtime
  if "$engineer_item" = "hawkbill" then put study my hawkbill instructions
	else put study my book
	matchwait 2
	goto BOOK_STUDY

BOOK_STUDIED:
	if !matchre("$lefthandnoun", "chisels") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "chisels") then gosub PUT my $righthandnoun in my $craftpack
	pause .5
#	gosub GET $chisel
  gosub GET stack
  gosub GET $saw
	pause .5
  var ITEM_COMPLETE 0
  action var ITEM_COMPLETE 1 when ^Applying the final touches, you complete working
  goto FIRST_CHISEL

FIRST_CHISEL:
  match NEED_RIFFLERS Upon completion you notice several rough, jagged
  match NEED_RASP developed an uneven texture along its surface
  match NEED_RASP no longer level
  match NEED_RASP is uneven
  match NEED_POLISH Upon finishing you see some discolored areas on
	match NEED_MORE You need a larger amount of material to continue crafting
  match CARVE_IT Roundtime
#  put carve %MaterialSize with $saw
  put carve stack with $saw
  matchwait 5
  goto FIRST_CHISEL

CARVE_IT:
  if matchre("$roomobjs", "stack") then
  {
    gosub put my $saw in my $craftpack
    gosub get stack
    gosub put my stack in my $craftpack
    gosub get my $saw
  }
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  match ASSEMBLE_IT [Ingredients
  match ITEM_FINISHED Applying the final touches, you complete working
  match ITEM_FINISHED You cannot figure out how to do that.
  match NEED_RIFFLERS Upon completion you notice several rough, jagged
  match NEED_RASP developed an uneven texture along its surface
  match NEED_RASP no longer level
  match NEED_RASP is uneven
  match NEED_POLISH Upon finishing you see some discolored areas on
  match CARVE_IT Roundtime
  put carve my $engineer_noun with $saw
  matchwait 5
  goto CARVE_IT

GET_CHISEL:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
 	if !matchre("$lefthandnoun", "$engineer_noun") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$engineer_noun") then gosub PUT my $righthandnoun in my $craftpack
	pause .5
	gosub GET $saw
	pause .5
  goto CARVE_IT

NEED_RIFFLERS:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  gosub put my $saw in my $craftpack
  gosub get my $riffler
RIFFLE_IT:
  match ASSEMBLE_IT [Ingredients
  match ITEM_FINISHED Applying the final touches, you complete working
  match GET_CHISEL Roundtime
  put rub my $engineer_noun with $riffler
  matchwait 5
  goto RIFFLE_IT

NEED_RASP:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  gosub put my $saw in my $craftpack
  gosub get my $rasp
RASP_IT:
  match ASSEMBLE_IT [Ingredients
  match ITEM_FINISHED Applying the final touches, you complete working
  match GET_CHISEL Roundtime
  put scrape my $engineer_noun with $rasp
  matchwait 5
  goto RASP_IT

NEED_POLISH:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  gosub put my $saw in my $craftpack
  gosub get my surface.polish
POLiSH_IT:
  match ASSEMBLE_IT [Ingredients
  match ITEM_FINISHED Applying the final touches, you complete working
  match GET_CHISEL Roundtime
  put apply surface.polish to my $engineer_noun
  matchwait 5
  goto POLISH_IT

NEED_MORE:
	put #echo >Log Black,Red Not Enough Material!
	put #parse Done Engineering
	pause 0.5
	exit

goto DONE_ENGINEERING

include includes.cmd

ASSEMBLE_IT:

ITEM_FINISHED:
 	gosub PUT my $lefthandnoun in my $craftpack
  gosub PUT my $righthandnoun in my $craftpack
  gosub get my $engineer_noun

  goto WORKORDER

STAMP:
	gosub GET my stamp
STAMP_1:
	matchre STAMP_2 ^Roundtime|^You cannot figure out how to do that|^The stamp is too badly damaged to be used for that.
	put mark my $engineer_noun with my stamp
	matchwait 2
	goto STAMP_1
STAMP_2:
	gosub PUT my stamp in my $craftpack
	goto WORKORDER

WORKORDER:
  if %Dump = 1 then
  {
    put put my $engineer_noun in bucket
    goto MORE_CHECK
  }
#  goto MORE_CHECK
	if %Workorder = 1 then
	{
		gosub GET my engineer logbook
		put bundle my $engineer_noun with my logbook
		action put #echo >Log Orange $1 when You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		pause 0.5
		put read my engineer logbook
		pause
		action remove You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		gosub PUT my engineer logbook in my $craftpack
	}

MORE_CHECK:
  gosub ALMANAC_CHECK
	math ItemsCount add 1
  if %Workorder = 0 then put #echo >Log Orange $forgenoun %ItemsCount completed.
  if %Dump = 1 then
  {
    if $Engineering.LearningRate >= 32 then goto DONE_ENGINEERING
    else goto START_ENGINEERING
  }
	if (%MaxItems > %ItemsCount) then
  {
    if (($Forging.LearningRate > 32) && (%origami = 1) && ($Mechanical_Lore.LearningRate < 21)) then
    {
      put .origami
      waitfor Origami Complete
      goto START_FORGE
    }
    elseif (($Forging.LearningRate > 32) && (%magic = 1) && ($Sorcery.LearningRate < 33)) then
    {
      put .sorcery
      waitfor Sorcery Complete
      goto START_FORGE
    }
    elseif (($Forging.LearningRate > 32) && ($Scholarship.LearningRate < 33)) then
    {
      put .scholarbook
      waitfor Script Done
      goto START_FORGE
    }
    goto START_ENGINEERING
  }


DONE_ENGINEERING:
  gosub ALMANAC_CHECK
  put #parse Done Engineering
  pause 0.5
exit
