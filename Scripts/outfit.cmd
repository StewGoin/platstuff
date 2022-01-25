## Outfitting Script

### USAGE .outfit <name.of.item> <material> (number to make for workorder)
### Items in < > are required options, in ( ) are not.
### e.g.: .outfit tailor cloth.socks burlap.cloth 3

# variables this script needs to know to run: $craftpack, $needles, $slickstone, $yardstick, $scissors

var BooksShort \b(tai|art|jew)(.+)?
var BooksLong	tailoring|artistry|jewelry

#debug 10

if ("%1" = "") then
{
	echo USAGE .outfit <tailor|artist|jewel> <item crafted> <material> (number to make for workorder)
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
  echo USAGE .outfit <tailor|artist|jewel> <item crafted> <material> (number to make for workorder)
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

put #var fitting_item %1
eval OutfitNoun replacere("%1", "\S+\.", "")
put #var fitting_noun %OutfitNoun
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
	put .fix awl
	waitfor ITEM FIXED
  pause .5
	put .fix needles
	waitfor ITEM FIXED
  pause .5
	put .fix slickstone
	waitfor ITEM FIXED
	pause .5
	put .fix scissors
	waitfor ITEM FIXED
	pause .5
	put .fix yardstick
	waitfor ITEM FIXED
	pause .5
	put .fix stamp
	waitfor ITEM FIXED
START_OUTFITTING:
#	gosub CAM_FILL
OUTFITTING_BUFFS:
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
    #if $SpellTimer.PlatinumHandsofKertigen.active = 0 then
    #{
    #  put .cast phk 0
    #  waitfor Spell Cast
    #}
#    put .cast compost $compost_mana
#    waitfor Spell Cast
  #}
#  if $bleeding = 1 then put healme
  if ((%magic = 1) && ($mana > 20) && (($cam_slipped = 1 || $cam_leeched = 1))) then gosub CAMB_CHARGE
	if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
	if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
	pause .5
BOOK_READ:
#	if "%Assmble" = "\%Assemble" then unvar Assemble

BOOK_STUDY:
  action (yards) var yards $1 when material \((\d+) yards\)$
  action (yards) var yards $1 when cloth \((\d+) yards\)$
  action (yards) var yards 1 when \(1 yard\)$
  action (yards) var have $1 when You count out (\d+) yards of material there\.$
  action (yards) on
  if "$fitting_item" = "hawkbill" then
  {
    gosub get my hawkbill instructions
    put read my instructions
  }
  else
  {
    put .craftbook %BookType $fitting_item
		waitfor Book Turned
  }
	action (itemreqs) off
  action (yards) off
	pause .5
	}
	if %ItemsCount > 0 then
  {
    if "$fitting_item" = "hawkbill" then gosub get my hawkbill instructions
    else gosub GET my book
  }
	matchre BOOK_STUDIED ^Roundtime
  if "$fitting_item" = "hawkbill" then put study my hawkbill instructions
	else put study my book
	matchwait 2
	goto BOOK_STUDY

BOOK_STUDIED:
	gosub PUT my $lefthandnoun in my $craftpack
	gosub PUT my $righthandnoun in my $craftpack
	pause .5
  gosub GET %Material
  gosub GET yardstick
	pause .5
  var ITEM_COMPLETE 0
  action var ITEM_COMPLETE 1 when ^Applying the final touches, you complete working
  goto MARK_MATERIAL

MARK_MATERIAL:
  match CUT_MATERIAL You count out
  match NOT_ENOUGH There is not enough
  put mark my $righthandnoun at %yards yards
  matchwait 2
  goto MARK_MATERIAL

CUT_MATERIAL:
  gosub put my yardstick in my $craftpack
  gosub get my scissors
CUT_MATERIAL_1:
  match CUT_MATERIAL_2 You carefully cut
  put cut my %Material with my scissor
  matchwait 2
  goto CUT_MATERIAL_1
CUT_MATERIAL_2:
  #gosub put my scissors in my $craftpack
	gosub put my other %Material in my $craftpack
  gosub get %Material
  #gosub get my scissors
  goto FIRST_CUT

FIRST_CUT:
  match FIRST_CUT ...wait
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put cut my %Material with my scissors
  matchwait 5
  goto FIRST_CUT

SEW_IT:
  if !matchre("$lefthandnoun", "$fitting_noun|needles") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|needles") then gosub PUT my $righthandnoun in my $craftpack
  gosub GET my needles
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put push my $fitting_noun with my needles
  matchwait 5
  goto SEW_IT

GET_AWL:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  if !matchre("$lefthandnoun", "$fitting_noun|awl") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|awl") then gosub PUT my $righthandnoun in my $craftpack
	gosub GET my awl
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put poke my $fitting_noun with my awl
  matchwait 5
  goto GET_AWL

GET_YARD:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  if !matchre("$lefthandnoun", "$fitting_noun|yardstick") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|yardstick") then gosub PUT my $righthandnoun in my $craftpack
	gosub GET my yardstick
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put measure my $fitting_noun with my yardstick
  matchwait 5
  goto GET_YARD

GET_PINS:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  if !matchre("$lefthandnoun", "$fitting_noun|pins") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|pins") then gosub PUT my $righthandnoun in my $craftpack
	gosub GET my pins
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put poke my $fitting_noun with my pins
  matchwait 5
  goto GET_PINS

GET_SCISSOR:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  if !matchre("$lefthandnoun", "$fitting_noun|scissors") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|scissors") then gosub PUT my $righthandnoun in my $craftpack
	gosub GET my scissors
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put cut my $fitting_noun with my scissors
  matchwait 5
  goto GET_SCISSOR

GET_SLICK:
  if %ITEM_COMPLETE = 1 then goto ASSEMBLE_IT
  if !matchre("$lefthandnoun", "$fitting_noun|slickstone") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun|slickstone") then gosub PUT my $righthandnoun in my $craftpack
	gosub GET my slickstone
  match GET_AWL needs holes punched
  match GET_YARD dimensions appear to have shifted and could benefit from some remeasuring.
  match GET_PINS could use some pins to
  match GET_SCISSOR With the measuring complete, now it is time to cut away more
  match SEW_IT Roundtime
  match GET_STAMP You cannot figure out how to do that
  match SEW_IT That tool does not seem suitable
  match LARGE_PAD You need another finished large cloth padding
  match SMALL_PAD You need another finished small cloth padding
  match HANDLE You need another finished leather shield handle
  match LONG_CORD You need another finished long leather cord
  match MORE_THREAD The needles need to have thread
  match GET_SLICK A deep crease develops
  match GET_SLICK wrinkles from all the handling and could use
  match SEW_IT Needle New seams must now be sewn
  put rub my $fitting_noun with my slickstone
  matchwait 5
  goto GET_SLICK

MORE_THREAD:
  if !matchre("$lefthandnoun", "$fitting_noun") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun") then gosub PUT my $righthandnoun in my $craftpack
  gosub GET my thread
  match SEW_IT You carefully thread
  put put my thread on needle in my $craftpack
  matchwait 2
  goto MORE_THREAD

Large_Pad:
var assemble Large Pad
goto Assemble
Small_Pad:
var assemble Small Pad
goto Assemble
Handle:
var assemble shield handle
goto Assemble
Long_Cord:
var assemble long cord
goto Assemble


Assemble:
var tool Assemble
gosub put $lefthand in my $craftpack
gosub get %assemble in $craftpack
put assemble my %assemble with my $fitting_noun
goto SEW_IT


goto DONE_ENGINEERING

include includes.cmd

ASSEMBLE_IT:

ITEM_FINISHED:

GET_STAMP:
  if !matchre("$lefthandnoun", "$fitting_noun") then gosub PUT my $lefthandnoun in my $craftpack
	if !matchre("$righthandnoun", "$fitting_noun") then gosub PUT my $righthandnoun in my $craftpack

GOTO WORKORDER

STAMP:
	gosub GET my stamp
STAMP_1:
	matchre STAMP_2 ^Roundtime|^You cannot figure out how to do that|^The stamp is too badly damaged to be used for that.
	put mark my $fitting_noun with my stamp
	matchwait 2
	goto STAMP_1
STAMP_2:
	gosub PUT my stamp in my $craftpack
	goto WORKORDER

WORKORDER:
  if %Dump = 1 then
  {
    put put my $fitting_noun in bucket
    put put my $righthand in bucket
    goto MORE_CHECK
  }
	if %Workorder = 1 then
	{
		gosub GET my outfitting logbook
		put bundle my $fitting_noun with my logbook
		action put #echo >Log Orange $1 when You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		pause 0.5
		put read my outfit logbook
		pause
		action remove You must bundle and deliver (\d+ more within the next \d+ roisaen\.)
		gosub PUT my outfit logbook in my $craftpack
	}

MORE_CHECK:
  gosub ALMANAC_CHECK
	math ItemsCount add 1
  if %Workorder = 0 then put #echo >Log Orange $fitting_noun %ItemsCount completed.
  if %Dump = 1 then
  {
    if $Outfitting.LearningRate >= 32 then goto DONE_OUTFITTING
    else goto START_OUTFITTING
  }

NOT_ENOUGH:
  gosub put cloth in bucket
  put stow;stow left

DONE_OUTFITTING:
  gosub ALMANAC_CHECK
  put #parse Done Outfitting
  pause 0.5
exit
