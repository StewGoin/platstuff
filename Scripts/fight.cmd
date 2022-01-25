# Generic GH starting script for single combat stings or setting MULTI
#debug 5

var common_opts cam appr bob bundle exp lootgem lootcoin lootjunk train
put stance set 66 65 65
var ritual none
var lw 0
if matchre("%2", "will|soul|word|echo") then var ritual %2
if matchre("%3", "lw|lay|ward|layward") then var lw 1
var reprep 0
put store default backpack

IF_1 goto %1
else goto DONE

#pickup where we left off fighting!
START:
  put gm $GHMCURRNUM
  goto DONE

REPREP:
  var reprep 1

PREP:
  if "$righthand" != "Empty" then put stow right
  if "$lefthand" != "Empty" then put stow left
  shift
  put perc
  pause 2
  if $SpellTimer.BlessingoftheFae.active = 0 then
  {
    put rel cyclic
    pause
    put .cast botf 25
    waitfor Spell Cast
  }
  if %ritual = "none" then goto PREP_BUFFS
  shift
  if %ritual = "soul" then
    {
      if $SpellTimer.SoulAblaze.active = 0 || $SpellTimer.SoulAblaze.duration <= 30 || %reprep = 1 then
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
  if $SpellTimer.DrumsoftheSnake.active = 0 || %reprep = 1 then
  {
    put .cast drum 15 43 42
    waitfor Spell Cast
  }
  if $SpellTimer.Harmony.active = 0 || %reprep = 1 then
  {
    put .cast harmony 30 35 35
    waitfor Spell Cast
  }
  if $SpellTimer.RageoftheClans.active = 0 || %reprep = 1 then
  {
    put .cast rage 15 43 42
    waitfor Spell Cast
  }
  if $SpellTimer.RedeemersPride.active = 0 || %reprep = 1 then
  {
    put .cast repr 10 45 45
    waitfor Spell Cast
  }  
  if $SpellTimer.NamingofTears.active = 0 || %reprep = 1 then
  {
    put .cast name 30 35 35
    waitfor Spell Cast
  }
#  if $SpellTimer.Nexus.active = 0 || %reprep = 1 then
#  {
#    put .cast nexus 30 35 35
#    waitfor Spell Cast
#  }
  if $SpellTimer.ManifestForce.active = 0 || %reprep = 1 then
  {
    put .cast maf 10 45 45
    waitfor Spell Cast
  }
  if %lw = 1 then
  {
    if $SpellTimer.LayWard.active = 0 then || %reprep = 1 then
    {
      put .cast lw 10 45 45
      waitfor Spell Cast
      shift
    }
  }

  if "%1" = "noapp" then
  {
    shift
    goto CONC_WAIT
  }
  # skipping Appraisal Focus for now
  goto CONC_WAIT

  put app focus shark
  waitforre Breakthrough\!|You are already under the effects of an appraisal focus\.|You can't seem to focus on that\.

  CONC_WAIT:
  if $concentration < 90 then
  {
    gosub ALMANAC_CHECK
    pause 10
    goto CONC_WAIT
  }


IF_1 goto %1
goto DONE

BRAWL:
put .geniehunter buff aoe aban 10 tarantula bundle lootgem lootcoin lootjunk debil maf normal bob brawl $buckler
# add cam
goto DONE

KATANA:
put .geniehunter type LARGEEDGED buff aoe aban 20 bundle lootgem lootcoin lootjunk maf normal bob worn swap 1 katana $buckler
# add cam
goto DONE

AXE:
put .geniehunter type LARGEEDGED buff aoe aban 20 bundle lootgem lootcoin lootjunk maf normal bob worn mirror.axe $buckler
# add cam
goto DONE

OFFHAND:
put .hunt
put .geniehunter type HT %common_opts offhand throw nolodge throw.mallet
# add cam
goto DONE

SLING:
put .hunt
put .geniehunter type SLING %common_opts sling
# add cam
goto DONE

HT:
put .hunt
put .geniehunter type HT %common_opts throw nolodge throw.mallet
# add cam
goto DONE

LT:
#put .hunt
put .geniehunter type LT %common_opts throw nolodge cuska
# add cam
goto DONE

SM_E:
cutlass:
put .hunt
put .geniehunter type SMALLEDGED %common_opts cutlass
# add cam
goto DONE

LG_E:
put .hunt
put .geniehunter type LARGEEDGED %common_opts axe
# add cam
goto DONE

SM_B:
CUSKA:
put .hunt
put .geniehunter type SMALLBLUNT %common_opts cuska
# add cam
goto DONE

LG_B:
STAR:
put .hunt
put .geniehunter type LARGEBLUNT %common_opts star
# add cam
goto DONE

ALL:
### Setup default options for all weapons here
# Everything except godawful Bowz
# ignite 
put #var loottype TREASURE
put #var GHMDOPT buff aoe aban AbandonedHeart 5 bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil hunt maf worn

### Set the total number of weapon combos
put #var GH_MULTI_NUM 12
### Set the combos themselves
put #var GH_MULTI_01 type LARGEBLUNT normal camb mirror.flail $buckler
put #var GH_MULTI_02 type LT normal camb throw throw.axe $buckler
put #var GH_MULTI_03 type HT normal camb throw nolodge throw.mallet $buckler
#put #var GH_MULTI_03 type HT normal camb lob throw nolodge allarh $buckler
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
#put #var GH_MULTI_14 type 2HEDGED normal worn dagesse $buckler

put #parse FIGHT PREPPED
goto DONE

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
goto DONE

DRAKES:
### Setup default options for all weapons here

put #var loottype TREASURE
put #var GHMDOPT armorswap appr bob buff aban AbandonedHeart 5 tarantula bundle egg exp lootjunk train timer debil hunt maf worn
# resonance ignite
put #var GH_HUNT_ROAM 1

### Set the total number of weapon combos
put #var GH_MULTI_NUM 6
### Set the combos themselves
put #var GH_MULTI_01 normal brawl $buckler
#put #var GH_MULTI_02 type LARGEEDGED normal camb swap 1 katana $buckler
put #var GH_MULTI_02 type LARGEEDGED normal camb katana $buckler
put #var GH_MULTI_03 type HT normal camb throw nolodge svidaw.sis $buckler
#put #var GH_MULTI_03 type HT normal camb lob throw nolodge allarh $buckler
put #var GH_MULTI_04 type LARGEBLUNT normal camb mirror.flail $buckler
put #var GH_MULTI_05 type SLING block sling $buckler
put #var GH_MULTI_06 normal brawl $buckler
put #var GH_MULTI_07 type LT normal camb throw throw.axe $buckler
put #var GH_MULTI_08 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_09 type SMALLBLUNT normal mace $buckler
put #var GH_MULTI_10 type STAFF normal quarterstaff $buckler
put #var GH_MULTI_11 type POLEARM normal allarh $buckler
put #var GH_MULTI_12 type HT offhand normal throw nolodge throw.mallet $buckler
#put #var GH_MULTI_13 type XBOW block latchbow $buckler
put #var GH_MULTI_13 type XBOW block pelletbow $buckler
put #var GH_MULTI_14 type 2HBLUNT normal akabo $buckler
put #var GH_MULTI_15 type 2HEDGED normal dagesse $buckler

put #parse FIGHT PREPPED
goto DONE

MOTHS:
put #var loottype TREASURE
# pyre PhoenixsPyre 7
put #var GHMDOPT armorswap appr aoe aban AbandonedHeart 5 bob buff bundle debil hunt egg exp lootgem lootcoin lootjunk maf maneuver nexus resonance tarantula tattoo timer train worn
put #var GH_HUNT_ROAM 1

### Set the total number of weapon combos
put #var GH_MULTI_NUM 14
### Set the combos themselves
#put #var GH_MULTI_01 type LARGEEDGED normal tachi $buckler
put #var GH_MULTI_01 type LARGEEDGED normal swap 1 katana $buckler
put #var GH_MULTI_02 type HT block throw nolodge svidaw.sis $buckler
put #var GH_MULTI_03 type LARGEBLUNT normal mirror.flail $buckler
put #var GH_MULTI_04 type SLING block damaris sling $buckler
put #var GH_MULTI_05 type LT normal lob stack nolodge glaes.star $buckler
#put #var GH_MULTI_06 type POLEARM normal allarh $buckler
put #var GH_MULTI_06 type POLEARM normal damaris pike $buckler
put #var GH_MULTI_07 type XBOW block damaris stonebow $buckler
put #var GH_MULTI_08 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_09 type SMALLBLUNT normal mace $buckler
put #var GH_MULTI_10 type STAFF normal staff $buckler
put #var GH_MULTI_11 type HT block offhand throw nolodge svidaw.sis $buckler
put #var GH_MULTI_12 type 2HBLUNT normal riste $buckler
#put #var GH_MULTI_13 type 2HEDGED normal dagesse $buckler
put #var GH_MULTI_13 type 2HEDGED normal swap 2 katana $buckler
put #var GH_MULTI_14 normal brawl $buckler

put #parse FIGHT PREPPED
goto DONE

PRIMARY:
### Setup default options for all weapons here
# aban AbandonedHeart 5
put #var loottype TREASURE
put #var GHMDOPT armorswap debil resonance bob buff aoe pyre PhoenixsPyre 7 nexus maneuver tarantula tattoo bundle exp lootgem lootcoin lootjunk train timer emptyhunt maf worn
put #var GH_HUNT_ROAM 1

### Set the total number of weapon combos
put #var GH_MULTI_NUM 9
### Set the combos themselves
put #var GH_MULTI_01 normal brawl $buckler
put #var GH_MULTI_02 type LARGEEDGED normal tachi $buckler
put #var GH_MULTI_03 type HT block throw nolodge svidaw.sis $buckler
put #var GH_MULTI_04 type LARGEBLUNT normal mirror.flail $buckler
put #var GH_MULTI_05 type SLING block sling $buckler
put #var GH_MULTI_06 normal brawl $buckler
put #var GH_MULTI_07 type LT normal lob stack nolodge glaes.star $buckler
put #var GH_MULTI_08 type POLEARM normal allarh $buckler
put #var GH_MULTI_09 type XBOW block stonebow $buckler


#put #var GH_MULTI_02 type LARGEEDGED normal swap 1 katana $buckler
#put #var GH_MULTI_03 type HT normal lob throw nolodge allarh $buckler

put #parse FIGHT PREPPED
goto DONE

SECONDARY:
### Setup default options for all weapons here

put #var loottype TREASURE
put #var GHMDOPT armorswap debil resonance bob buff aoe pyre PhoenixsPyre 7 nexus maneuver tarantula tattoo bundle exp lootgem lootcoin lootjunk train timer emptyhunt maf worn
put #var GH_HUNT_ROAM 1

### Set the total number of weapon combos
put #var GH_MULTI_NUM 8
### Set the combos themselves
put #var GH_MULTI_01 type SMALLEDGED normal wakizashi $buckler
put #var GH_MULTI_02 type SMALLBLUNT normal mace $buckler
put #var GH_MULTI_03 normal brawl $buckler
put #var GH_MULTI_04 type STAFF normal quarterstaff $buckler
put #var GH_MULTI_05 type HT block offhand throw nolodge svidaw.sis $buckler
put #var GH_MULTI_06 type 2HBLUNT normal riste $buckler
put #var GH_MULTI_07 type 2HEDGED normal dagesse $buckler
put #var GH_MULTI_08 normal brawl $buckler

put #parse FIGHT PREPPED
goto DONE

ASS:
ASSASIN:
INTER:
INTERCESSOR:
INTERCESSORS:
CABAL:
CABALIST:
### Setup default options for all weapons here
put stance set $shieldstance
put #var loottype goods
# buff aban AbandonedHeart 30
put #var GHMDOPT money egg buff aoe pyre PhoenixsPyre 37 nexus ease resonance tattoo bundle lootall maf worn
put #var GH_HUNT_ROAM 0

### Set the total number of weapon combos
put #var GH_MULTI_NUM 1
### Set the combos themselves
put #var GH_MULTI_01 type HT block lob throw Imperial.spear $buckler
put #parse FIGHT PREPPED
goto DONE

DISSECT:
### Setup default options for all weapons here
put stance set $normalstance
put #var loottype treasure
put #var GHMDOPT aoe aban AbandonedHeart 20 nexus resonance egg exp lootgem lootcoin lootjunk tattoo train bundle lootgem lootcoin lootjunk maf worn
put #var GH_HUNT_ROAM 0

### Set the total number of weapon combos
put #var GH_MULTI_NUM 2
### Set the combos themselves
put #var GH_MULTI_01 type BOW dissect hirdu.bow $buckler
put #var GH_MULTI_02 type BOW hirdu.bow $buckler
put #parse FIGHT PREPPED
goto DONE

BACKTRAIN:
### Setup default options for all weapons here

put #var loottype TREASURE
put #var GHMDOPT buff aoe aban AbandonedHeart 5 tarantula bundle exp lootgem lootcoin lootjunk train timer resonance ignite debil maf hunt

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
goto DONE

QLT:
#put .hunt
put .geniehunter type LT lootgem lootcoin lootjunk resonance throw nolodge cuska
# add cam
goto DONE

QBRAWL:
#put .hunt
put .geniehunter parry bob camb bundle lootgem lootcoin lootjunk brawl $buckler
# add cam
goto DONE

DONE:
  pause 0.001
  if $gametime >= $tattootime then
  {
    pause 0.1
    if $gametime >= $tattootime then put invoke my tattoo
    pause 0.1
  }
  put #echo >Log Purple Ready to Fight!;#play chime
  put #parse Ready to Fight
  pause 0.001
  exit

include includes.cmd