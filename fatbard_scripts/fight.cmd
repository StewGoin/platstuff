# Generic GH starting script for single combat stings or setting MULTI
#debug 5

var common_opts cam appr bob bundle exp lootgem lootcoin lootjunk train
put stance set 64 64 64
var ritual none
if matchre("%2", "will|soul|word") then
{
  var ritual %2
}
var reprep 0
put store default backpack

IF_1 goto %1
else goto EXIT

#pickup where we left off fighting!
START:
  put gm $GHMCURRNUM
  exit

REPREP:
  var reprep 1

PREP:
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left
  shift
  put rel cyclic
  if %ritual = "none" then goto PREP_BUFFS
  shift
  if %ritual = "soul" then
    {
      if $SpellTimer.SoulAblaze.active = 0 || %reprep = 1 then
        {
        put .cast soul 800
        waitfor Spell Cast
        }
    }
  if %ritual = "will" then
    {
      if $SpellTimer.WillofWinter.active = 0 || %reprep = 1 then
        {
        put .cast will 700
        waitfor Spell Cast
        }
    }
  if %ritual = "word" then
    {
      if $SPellTimer.WordsoftheWind.active = 0 || %reprep = 1 then
        {
        put .cast word 600
        waitfor Spell Cast
        }
    }
  if %ritual = "echo" then
    {
      if $SpellTimer.EchoesofAether.active = 0 || %reprep = 1  then
        {
        put .cast echo 700
        waitfor Spell Cast
        }
    }
PREP_BUFFS:
  if $SpellTimer.Harmony.active = 0 || %reprep = 1 then
  {
    put .cast harmony 10 45 45
    waitfor Spell Cast
  }
  if $SpellTimer.RageoftheClans.active = 0 || %reprep = 1 then
  {
    put .cast rage 10 45 45
    waitfor Spell Cast
  }
  if $SpellTimer.DrumsoftheSnake.active = 0 || %reprep = 1 then
  {
    put .cast drum 10 45 45
    waitfor Spell Cast
  }
  if $SpellTimer.NamingofTears.active = 0 || %reprep = 1 then
  {
    put .cast name 10 45 45
    waitfor Spell Cast
  }
  if $SpellTimer.RedeemersPride.active = 0 || %reprep = 1 then
  {
    put .cast repr 10 45 45
    waitfor Spell Cast
  }
  {
    put .cast maf 10 45 45
    waitfor Spell Cast
  }
  #if $SpellTimer.LayWayd.active = 0 then
  #{
  #  put .cast lw 10 45 45
  #  waitfor Spell Cast
  #}
  if "%1" = "noapp" then
  {
    shift
    goto CONC_WAIT
  }
  put app focus shark
  waitforre Breakthrough\!|You are already under the effects of an appraisal focus\.|You can't seem to focus on that\.

  CONC_WAIT:
  if $concentration < 90 then
  {
    pause 10
    goto CONC_WAIT
  }

IF_1 goto %1
goto EXIT

BRAWL:
put .geniehunter buff aban 10 bundle lootgem lootcoin lootjunk debil maf normal bob brawl $buckler
# add cam
goto EXIT

KATANA:
put .geniehunter type LARGEEDGED buff aban 20 bundle lootgem lootcoin lootjunk maf normal bob worn swap 1 katana $buckler
# add cam
goto EXIT

AXE:
put .geniehunter type LARGEEDGED buff aban 20 bundle lootgem lootcoin lootjunk maf normal bob worn mirror.axe $buckler
# add cam
goto EXIT

OFFHAND:
put .hunt
put .geniehunter type HT %common_opts offhand throw nolodge throw.mallet
# add cam
goto EXIT

SLING:
put .hunt
put .geniehunter type SLING %common_opts sling
# add cam
goto EXIT

HT:
put .hunt
put .geniehunter type HT %common_opts throw nolodge throw.mallet
# add cam
goto EXIT

LT:
#put .hunt
put .geniehunter type LT %common_opts throw nolodge cuska
# add cam
goto EXIT

SM_E:
cutlass:
put .hunt
put .geniehunter type SMALLEDGED %common_opts cutlass
# add cam
goto EXIT

LG_E:
put .hunt
put .geniehunter type LARGEEDGED %common_opts axe
# add cam
goto EXIT

SM_B:
CUSKA:
put .hunt
put .geniehunter type SMALLBLUNT %common_opts cuska
# add cam
goto EXIT

LG_B:
STAR:
put .hunt
put .geniehunter type LARGEBLUNT %common_opts star
# add cam
goto EXIT

ALL:
### Setup default options for all weapons here
# Everything except godawful Bowz
# ignite 
put #var loottype TREASURE
put #var GHMDOPT buff aban 5 bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil hunt maf

### Set the total number of weapon combos
put #var GH_MULTI_NUM 12
### Set the combos themselves
put #var GH_MULTI_01 type LARGEBLUNT normal camb mirror.flail $buckler
put #var GH_MULTI_02 type LT normal camb throw nolodge chakram $buckler
#put #var GH_MULTI_03 type HT normal camb throw nolodge throw.mallet $buckler
put #var GH_MULTI_03 type HT normal camb lob throw nolodge allarh $buckler
#put #var GH_MULTI_04 type LARGEEDGED normal camb swap 1 katana $buckler
put #var GH_MULTI_04 type LARGEEDGED normal camb katana $buckler
put #var GH_MULTI_05 type SLING block worn sling $buckler
put #var GH_MULTI_06 type STAFF normal worn quarterstaff $buckler
put #var GH_MULTI_07 type HT offhand normal worn throw nolodge throw.mallet $buckler
put #var GH_MULTI_08 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_09 type SMALLBLUNT normal mace $buckler
#put #var GH_MULTI_12 type XBOW block worn latchbow $buckler
put #var GH_MULTI_10 type XBOW block worn pelletbow $buckler
put #var GH_MULTI_11 normal brawl $buckler
put #var GH_MULTI_12 type POLEARM normal worn allarh $buckler
#put #var GH_MULTI_13 type 2HBLUNT normal worn akabo $buckler
#put #var GH_MULTI_14 type 2HEDGED normal worn greatsword $buckler

put #parse FIGHT PREPPED
goto EXIT

HIGH:
### Setup default options for all weapons here
# LE, LT, Brawl, LB
put #var loottype TREASURE
put #var GHMDOPT debil recall bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil hunt
### Set the total number of weapon combos
put #var GH_MULTI_NUM 6
### Set the combos themselves
put #var GH_MULTI_01 type LARGEBLUNT normal bob camb mirror.flail $buckler
put #var GH_MULTI_02 type LT normal bob camb lob throw nolodge throwing.axe $buckler
put #var GH_MULTI_03 type HT normal bob throw nolodge throw.mallet $buckler
#put #var GH_MULTI_04 type SLING block rcyclic abh 30 worn sling $buckler
put #var GH_MULTI_05 type LARGEEDGED normal bob camb swap 1 katana $buckler
put #var GH_MULTI_06 normal bob camb brawl $buckler
#staff
goto EXIT


PRIMARY:
### Setup default options for all weapons here

put #var loottype TREASURE
put #var GHMDOPT buff aban 5 bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil hunt

### Set the total number of weapon combos
put #var GH_MULTI_NUM 14
### Set the combos themselves
put #var GH_MULTI_01 type LARGEBLUNT normal camb mirror.flail $buckler
put #var GH_MULTI_02 type LT normal camb lob throw nolodge throwing.axe $buckler
put #var GH_MULTI_03 type HT normal camb throw nolodge throw.mallet $buckler
put #var GH_MULTI_04 type LARGEEDGED normal camb swap 1 katana $buckler
put #var GH_MULTI_05 type SLING block worn sling $buckler
put #var GH_MULTI_06 type STAFF normal worn quarterstaff $buckler
put #var GH_MULTI_07 type HT offhand normal worn throw nolodge throw.mallet $buckler
put #var GH_MULTI_08 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_09 type SMALLBLUNT normal mace $buckler
put #var GH_MULTI_10 type 2HEDGED normal worn greatsword $buckler
put #var GH_MULTI_11 type 2HBLUNT normal worn akabo $buckler
#put #var GH_MULTI_12 type XBOW block worn latchbow $buckler
put #var GH_MULTI_12 type XBOW block worn pelletbow $buckler
put #var GH_MULTI_13 normal brawl $buckler
put #var GH_MULTI_14 type POLEARM normal worn allarh $buckler

put #parse FIGHT PREPPED
goto EXIT

ASS:
ASSASIN:
### Setup default options for all weapons here
put stance set 94 0 95
put #var loottype TREASURE
put #var GHMDOPT buff aban 5 bundle exp lootgem lootcoin lootjunk train timer resonance
### Set the total number of weapon combos
put #var GH_MULTI_NUM 10
### Set the combos themselves
put #var GH_MULTI_01 type LARGEBLUNT bob camb mirror.flail $buckler
put #var GH_MULTI_02 type LT bob camb lob throw nolodge throwing.axe $buckler
put #var GH_MULTI_03 type HT bob camb throw nolodge throw.mallet $buckler
put #var GH_MULTI_04 type LARGEEDGED bob camb mirror.axe $buckler
put #var GH_MULTI_05 type SLING worn sling $buckler
put #var GH_MULTI_06 type STAFF bob quarterstaff $buckler
put #var GH_MULTI_07 type HT offhand bob worn throw nolodge throw.mallet $buckler
put #var GH_MULTI_08 bob brawl $buckler
put #var GH_MULTI_09 type SMALLEDGED bob wakizashi $buckler
put #var GH_MULTI_10 type SMALLBLUNT bob cuska $buckler
#staff
put #parse FIGHT PREPPED
goto EXIT

BACKTRAIN:
### Setup default options for all weapons here

put #var loottype TREASURE
put #var GHMDOPT buff aban 5 bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil maf hunt

### Set the total number of weapon combos
put #var GH_MULTI_NUM 10
### Set the combos themselves
put #var GH_MULTI_01 type HT normal camb throw nolodge throw.mallet $buckler
put #var GH_MULTI_02 type SLING block worn sling $buckler
put #var GH_MULTI_03 type STAFF normal worn quarterstaff $buckler
put #var GH_MULTI_04 type HT offhand normal worn throw nolodge throw.mallet $buckler
put #var GH_MULTI_05 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_06 type SMALLBLUNT normal mace $buckler
put #var GH_MULTI_07 type 2HEDGED normal worn greatsword $buckler
put #var GH_MULTI_08 type 2HBLUNT normal worn akabo $buckler
put #var GH_MULTI_09 type XBOW block worn pelletbow $buckler
put #var GH_MULTI_10 type POLEARM normal worn allarh $buckler

put #parse FIGHT PREPPED
goto EXIT

QLT:
#put .hunt
put .geniehunter type LT lootgem lootcoin lootjunk resonance throw nolodge cuska
# add cam
goto EXIT

QBRAWL:
#put .hunt
put .geniehunter parry bob camb bundle lootgem lootcoin lootjunk brawl $buckler
# add cam
goto EXIT

EXIT:
  put #echo >Log Purple Ready to Fight!;#play chime
  put #parse Ready to Fight
  exit

