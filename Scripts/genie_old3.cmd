# Remove unused options and deprecated functionality

########################################################################
##                                                                    ##
##                         General combat script                      ##
##                 By: Warneck (with help from SFHunter)              ##
##                                                                    ##
##                          General Options:                          ##
## APPR: appraises monsters, will not appraise if appraisal is locked ##
## ARRANGE: arranges skinnable creatures before skinning them. Will   ##
##          try to arrange the amount of times you specify after the  ##
##          command. i.e. "arrange 3"
## BLOCK: sets stance to shield stance                                ##
## BOB: will add a "bob" to learn brawling at spots in the cycle      ##
## BUNDLE: bundles skins if you have ropes                            ##
## DEFAULT: use the default setting, use DSET fist to set up defaults ##
##          can also use .geniehunter with no arguments to do this    ##
## DMSET: setup for multi-weapon with default settings                ##
##        use is .geniehunter dmset weapon1 weapon2 ...               ##
## DMULTI: Multi-weapon with default settings                         ##
## DODGE/EVADE: sets stance to evasion stance                         ##
## DSET: used to set up the default settings                          ##
##      run .geniehunter DSET <<all other options>> once to set the   ##
##      defaults, this will go through init like normal, and then     ##
##      save all the settings globally for use as default             ##
## EXP: checks weapon experience.  Will end script when skill is      ##
##      bewildered or above                                           ##
## FOLD: will do origami while waiting for critters. No roaming.      ##
## LOOT: loots every it can                                           ##
## LOOTBOXES: loots  boxes, redundant if used with LOOT               ##
## LOOTCOINS: loots coins, redundant if used with LOOT                ##
## LOOTGEMS: loots gems, redundant if used with LOOT                  ##
## LOOTJUNK: loots scrolls/runestones/cards                           ##
## LOOTLOCK: loots lockpicks, exclusive from ALL looting              ##
## MDOPTSET: sets default options to use with every combo in MSET     ##
##           allows you to make shorter "set" commands                ##
## MSET: setup for multi-weapon, break up multi setups with quotation ##
##     marks: .geniehunter "setup 1" "setup 2"..."setup 10"           ##
##     supports up to 10 setups currently                             ##
##     setups are saved as GH_MULTI_# for edittabillity               ##
## MULTI: multi-weapon training, will use a weapon until locked       ##
##       then switch to the next setup when locked                    ##
## PARRY: sets stance to parry stance                                 ##
## RETREAT: turns on retreating for ranged weapons / spells. This     ##
##            does not work with poaching yet. If you would like to   ##
##            delay retreating until a certain number of critters is  ##
##            in the room, put that number after the RETREAT keyword  ##
## SKIN: skins monsters                                               ##
## SKINRETREAT: will turn on retreating while skinning                ##
## SLOW: will use your weapons slower, for weaklings or noobs         ##
## SWAP/BASTARD: swappable weapon support, equips the weapon and      ##
##               swaps it to the desired weapon "mode"                ##
##       Available mode options: 1 - one handed                       ##
##                               2 - two handed                       ##
##                               b - blunt                            ##
##                               e - edged                            ##
##                               ha - halberd                         ##
##                               pi - pike                            ##
##                               qs - quarter staff                   ##
##                               ss - short staff                     ##
## TARGET: specifies a target to aim/target for attacks               ##
## TIMER: will set a timer to abort the script after x seconds        ##
## TRAIN: will check experience after every combat cycle, ranged      ##
##        weapon firing/throwing, or spell cast                       ##
## TYPE: can specify the weapon type on startup and avoid the RT from ##
##       appraising the weapon. Type should match the label name in   ##
##       in the weapon section below. i.e. "type LX"                  ##
##                                                                    ##
##                         Weapon Options:                            ##
## AMBUSH: hides/stalks and attacks from hiding, checks stalking exp  ##
##         by default. If you prefer it to check hiding experience,   ##
##         then add the word "hiding" right after AMBUSH              ##
## BACKSTAB: backstabs with weapon                                    ##
## BRAWL: brawls                                                      ##
## EMPATH: non-lethal brawling                                        ##
## MAGIC: uses magic in the same syntax as TM/PM, but will only cast  ##
##        once per critter, then use the primary weapon to kill.      ##
##        same syntax as TM/PM below, with the prepended MAGIC        ##
## MSNAP: snapcasts a spell. Adding a number after this will pause    ##
##        that many seconds before casting.                           ##
##        Usage: snap (#) <weapon> (shield)                           ##
## OFFHAND: uses weapon in offhand, works with melee or thrown        ##
## POACH: poaches with a ranged weapon, checks stalking exp           ##
## SNAP: snap-fires ranged weapon. Adding a number after this will    ##
##        pause that many seconds before firing.                      ##
##        Usage: snap (#) <weapon> (shield)                           ##
## STACK: throws stacks of weapons (throwing blades). If you use      ##
##        this, don't use THROW too                                   ##
## THROW: throws a thrown weapon                                      ##
## TM/PM: uses magic as the primary weapon, with brawling as the      ##
##        backup if no other weapon is specified (and you run out of  ##
##        mana). The extra harness is optional. TM for targeted exp   ##
##        check, PM for primary magic exp checks. SNAP will snapcast. ##
##        Use as follows:                                             ##
##(MAGIC) (MSNAP) (#) <TM|PM> <spell> <mana> (extra) <weapon> (shield)##
## WORN: treats any specified shield as arm worn.                     ##
##                                                                    ##
## Use:                                                               ##
## .geniehunter (General options) (Weapon Options) weapon shield      ##
##                                                                    ##
## Note: You must have the EXP Tracker Plugin for this script to work ##
########################################################################
put #var GH_SETUP 1
put #var GH_NOHUNT 1
#debuglevel 5
timer clear
timer start
put #script abort retreat
#if  ("$righthandnoun" = "zills") then goto ACTIONS_INIT
if ("$righthandnoun" = "katana") then put sheath my katana in my katana sheath
if ("$righthand" != "Empty") then put stow right

ACTIONS_INIT:
	##Initializing global 
	action goto STAND when eval $standing = 0
	action goto STAND when You should stand up first|You had better stand up first|You must stand first
	action goto DONE when reaches over and holds your hand|grabs your arm and drags you|clasps your hand tenderly
#	action goto WEBBED when eval $webbed = 1
#	action goto STUNNED when eval $stunned = 1
#	action goto BLEEDING when eval $bleeding = 1
#	action goto CHECKING_HEALTH when eval $health < 20
	action goto DEAD when eval $dead = 1
	action goto DROPPED_WEAPON when Your fingers go numb as you drop|You have nothing to swap|You don't have a weapon|With your bare hands\?
	action goto DROPPED_WEAPON when Your fingers go numb as you drop|You have nothing to swap|You don't have a weapon|With your bare hands\?
#	action var guild $1 when Guild: (\S+)
  var guild Bard
	action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
	action send 2 $lastcommand when You don't seem to be able to move to do that.

	##Stance actions
	action var PARRY_LEVEL $1 when You are currently using (\d+)% of your weapon parry skill
	action var EVAS_LEVEL $1 when You are currently using (\d+)% of your evasion skill
	action var SHIELD_LEVEL $1 when You are currently using (\d+)% of your shield block skill

TOP:
var LAST TOP
## Initializing script specific variables
## Uses are pretty self-explainatory

#	pause 0.5
#	put .armorswap handarmor
#	waitfor Armor Swapped
#	pause 0.5
#	put .armorswap headarmor
#	waitfor Armor Swapped


## Ammo types used for ranged combat
var BOW_AMMO $bow_ammo
var XB_AMMO bolt
var HXB_AMMO $hx_bolt
var SLING_AMMO $sling_ammo
var QUIVER $quiver
var LT_SHEATH $lt_sheath
var HT_SHEATH $ht_sheath
var GEM_CONTAINER gem.pouch
var TIED_CONTAINER $pack
var POUCH_CONTAINER leather.belt
var JUNK_CONTAINER $pack
var SHEATH $sheath
var WORN_CONTAINER $pack
var LOCKCASE case in my thigh bag
var cambrinth $cambrinth
put #var cam_mana 5
put #var GH_LOOT_TYPE $loottype
#put STORE AMMO %QUIVER
#put STORE GEMS %GEM_CONTAINER
pause 0.5
##put STORE BOXES %BOX_CONTAINER
put tie my %GEM_CONTAINER
pause 0.5

## Monster waiting related variables
var SKINNED NO

## Arm-worn shield during ranged attempts
var REM_SHIELD sturdy.shield
var ALT_STANCE Shield_Usage
	
## Variable for rest mode
var REST OFF

## Local variable for counting kills, loots, skins, etc
var LOCAL 0
var LOOTED NO

## Special request
var DYING OFF

## Variable for "kill" state
var DEAD NO

VARIABLES_INIT:
	##LOOT Variables
	var gems1 agate|alexandrite|amber|amethyst|andalusite|aquamarine|\bbar|\bbead|\bberyl|bloodgem|bloodstone|carnelian|chrysoberyl|carnelian|chalcedony
	var gems2 chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|emerald|egg\b|eggcase|garnet|\bgem|goldstone|glossy malachite
	var gems3 (chunk of|some|piece of).*granite|hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|nugget|onyx
	var gems4 opal|pearl|pebble|peridot|quartz|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth\b|topaz|tourmaline|tsavorite|turquoise|zircon
	var boxtype greenish|cracked|rusty|reinforced|worm-eaten|dull|dented|deeply gouged|copper-edged|plain|crooked|mud-stained|pitted|salt-stained|sturdy|rotting|moldy|misshaped|poorly made|crust-covered|mildewy|corroded|greenish brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
	var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox
	var junkloot ((orichalcum|animite|haralun|damite|kertig|glaes|audrualm|niello|tyrium|vardite|silversteel|icesteel) (nugget|shard|tear|fragment|lump))|silver nugget|platinum nugget|gold nugget|erythrite runestone|scroll|tablet|card|vellum|sheiska leaf|ostracon|hhr'lav'geluhh bark|papyrus roll|smudged parchment|diamond band|paper-wrapped package|naphtha|dira|map

	##Monster Variables
	var monsters1 gidii|goblin shaman|fendryad|nyad|madman|sprite|wood troll|lipopod|kelpie|vykathi builder|vykathi excavator|Dragon priestess|dragon priestess|Dragon priest|dragon priest
	var monsters2 fire maiden|creeper|\bvine|thug|ruffian|footpad|cutthroat|gypsy marauder|young ogre|swain|kra'hei hatchling
	var monsters3 nipoh oshu|dyrachis|shadoweaver|crag|frostweaver|atik'et|dryad|orc scout|eviscerator|guardian|pirate
	var monsters4 geni|orc bandit|umbramagii|screamer|scout ogre|swamp troll|mountain giant
	var monsters5 scavenger troll|sleazy lout|bucca|dragon fanatic|dusk ogre|tress|bloodvine
	var monsters6 armored warklin|velver|orc reiver|kra'hei|Dragon priestess|dragon priestess|Dragon priest|dragon priest|Lun'Shele hunter|Lun'Shele trekhalo|orc raider|folsi immola|purifier|pile of fine ash
	var monsters7 faenrae assasin|telga moradu|trekhalo|orc clan chief|shadow master|sky giant|imp|dummy|pile of rubble|Priest crone|sentinel|zealot|assassin|juggernaut|gam chaga|ashu hhinvi|small sand dune

	var undead1 zombie stomper|zombie mauler|skeleton|soul|boggle|zombie|wind hound|fiend|spirit|ur hhrki'izh|spectral pirate|spectral sailor|shylvic
	var undead2 skeleton kobold savage|skeleton kobold headhunter|skeletal sailor|olensari mihmanan
	var undead3 emaciated umbramagus|zombie nomad|sinister maelshyvean heirophant|gargantuan bone golem|plague wraith|snaer hafwa|wir dinego|ghast|resuscitant|delinquent|detainee|hoodlum|offender|culprit|captive|malefactor

	var skinnablemonsters1 frog|silverfish|musk hog|grub|crayfish|burrower|crab|boar|skunk|badger|pothanit|trollkin
	var skinnablemonsters2 kobold|s'lai scout|jackal|bobcat|cougar|grass eel|bear|ram|spider|wolf|boobrie|beisswurm|rock troll|sluagh|blue-green pivuh|malchata
	var skinnablemonsters3 serpent|firecat|vulture|arbelog|caiman|steed|larva|snowbeast|worm|unyn|gargoyle|crocodile
	var skinnablemonsters4 merrows|viper|peccary|la'tami|barghest|angiswaerd hatchling|vykathi harvester|pard|moth|kartais
	var skinnablemonsters5 la'heke|vykathi soldier|boa|warcat|moda|arzumo|carcal|blood warrior|goblin|storm bull
	var skinnablemonsters6 rat|antelope|giant blight bat|leucro|wasp|mottled westanuryn|blight ogre|gryphon|caracal|basilisk
	var skinnablemonsters7 dobek moruryn|sinuous elsralael|sleek hele'la|shadow mage|marbled angiswaerd|retan dolomar|faenrae stalker
	var skinnablemonsters8 shadow beast|cinder beast|asaren celpeze|spirit dancer|scaly seordmaor|poloh'izh|armadillo|shalswar|hierophant|black ape|Isundjen conjurer

	var skinnableundead1 ghoul|squirrel|grendel|reaver|mey|shadow hound|lach|mastiff|gremlin|enraged tusky
	var skinnableundead2 zombie kobold savage|zombie kobold headhunter|ghoul crow|misshapen germish'din|ice adder
	
	var invasioncritters transmogrified oaf|flea-ridden beast|(Rakash|Elven|Human|Prydean) ranger|bone warrior|shambling horror|skeletal (peon|hound|warrior|archer)|(revivified|zombie|peon) mutt|fleshreaper|(Rakash|Prydaen|goblin) zombie|snaer hafwa|black death spirit|patchwork abomination|necrotic warrior|ghoul seagull|putrefying shambler|ghoulish slayer|Prydaen|Rakash|cadaverous hulk|preserved zombified \w+|gestalt draugen|unctuous \w+ zombie|marksman|gladiator
	
	var skinnvasioncritters grey ghoul

	var skinnablecritters %skinnablemonsters1|%skinnablemonsters2|%skinnablemonsters3|%skinnablemonsters4|%skinnablemonsters5|%skinnablemonsters6|%skinnablemonsters7|%skinnablemonsters8|%skinnableundead1|%skinnableundead2|%skinnvasioncritters
	var nonskinnablecritters %monsters1|%monsters2|%monsters3|%monsters4|%monsters5|%monsters6|%monsters7|%undead1|%undead2|%undead3|%invasioncritters

	var critters %skinnablecritters|%nonskinnablecritters

	var OPTIONVARS \b(AMB|APPR|ARRA|BS|BACK|BLOC|BUN|BRA|COLL|CYC|EMP|DOD|EVA|EXP|LOOT|OFF|PAR|POA|SING|CHANT|NORET|SKI|SNA|STAC|THR|TI|MSNA|TM|PM|MAG|TR|TAR|TAC|DSET|DEF|MSET|MU|DMSET|DMU|SWAP|BAST|MECH|GROUP|MDOPTSET|WO|NOPOACH|ARRA|HELP|BOB|MDOPT|DYING|RET|FOLD|ORIG|TYPE|SLOW|RPA|HIDING|CAM|REC|BLA|SOR|RES|RCY|BUF|NORM)(.+)?

## Stance variables
	var PARRY_LEVEL 0
	var EVAS_LEVEL 0
	var SHIELD_LEVEL 0
	var SHORT_STANCE shield

	## Global variables for kills, loots, skins, etc
#	if matchre($GH_KILLS, \D+) then put #var GH_KILLS 0
#	if matchre($GH_LOOTS, \D+) then put #var GH_LOOTS 0
#	if matchre($GH_SKINS, \D+) then put #var GH_SKINS 0

#######################
## SCRIPT VARIALBLES ##
#######################

## variable LAST is used with the WEBBED and PAUSE subroutines
## LAST is set to the current subroutine you in within the script
if ("%1" != "MULTIWEAPON") then
{
	## MULTI can be OFF or ON
	## ON - Will switch weapons to the next multi setup when locked
	## OFF - Default, attacks with just this weapon
	put #var GH_MULTI OFF
} else
{
	shift
}

######################################################
##                 GLOBAL VARIABLES                 ##
## These variables can be changed while GenieHunter ##
## is running to modify how the script works.       ##
## eg If you get tired of skinning, but have GH set ##
## to skin, just change GH_SKIN to OFF              ##
## All global variables are GH_<<name>> so they are ##
## all in the same spot in the variables window     ##
######################################################

## AMBUSH can be OFF or ON
## ON - Using ambushing attacks, hides and stalks before every attack
## OFF - Default, attacks normally
put #var GH_AMBUSH OFF

## APPR can be NO or YES
## YES - Kills first creature, then appraises one creature once before entering the combat loop
##      Will appraise once after each kill, will not appraise once skill is dazed or mind locked
## NO - Default, no appraising of creatures
put #var GH_APPR NO

## ARRANGE can be OFF or ON
## ON - Will attempt to arrange a skinnable creature before skinning it.
## OFF - Default, will just skin creatures
put #var GH_ARRANGE OFF

## BOB can be OFF or ON
## ON - Will added brawling based "bob"s in certain spots to work brawling with other weapons
## OFF - Default, does nothing
put #var GH_BOB OFF
var BOBCOUNTER 1

## BUN can be OFF or ON
## Note: Skinning must be enabled for bundling to work
## ON - Will bundle skinnings with rope
##      If no more bundling ropes are available, will be set to OFF
## OFF - Default, will just drop skins
put #var GH_BUN OFF
put #var GH_BUN_WORN OFF

put #var GH_BUFF OFF

put #var GH_CAMB OFF

put #var GH_CYCLIC OFF

put #var GH_COLLECT OFF

## EXP can be ON or OFF
## ON - Checks weapons experience after every kill
##      Also checks mindstate and any alternate experience
## OFF - No experience checks
if ("$GH_MULTI" = "OFF") then put #var GH_EXP OFF

## LOOT can be OFF or ON
## ON - Loots everything: boxes, gems coins; stores loot in LOOT_CONTAINER
##      If LOOT_CONTAINER fills up, stops looting boxes and gems
## OFF - Default, leaves loot on the ground
## Note: Turning on LOOT turns on LOOT_BOX, LOOT_GEM, LOOT_COIN
put #var GH_LOOT OFF

## LOOT_BOX can be OFF or ON
## ON - Loots boxes until LOOT_CONTAINER is full
## OFF - Default, leaves boxes on the ground
put #var GH_LOOT_BOX OFF

## LOOT_COIN can be OFF or ON
## ON - Loots coins
## OFF - Default, leaves coins on the ground
put #var GH_LOOT_COIN OFF

## LOOT_GEM can be OFF or ON
## ON - Loots gems until LOOT_CONTAINER is full
## OFF - Default, leaves gems on the ground
put #var GH_LOOT_GEM OFF

## LOOT_JUNK can be OFF or ON
## ON - Loots junk items until LOOT_CONTAINER is full
## OFF - Default, leaves junk items on the ground
put #var GH_LOOT_JUNK OFF
put #var GH_LOOT_LOCK OFF

## SPELL can be the shortname of any castable spell. It's what will be prepped.
put #var GH_SPELL eb

## MANA is the amount of initial mana to prep the spell at.
put #var GH_MANA 0

## HARN is the amount of extra mana to harness before casting the spell.
put #var GH_HARN 0

## MSNAP (global) can be ON or OFF
## on - Will cause magic to be snapcast immediately following prep/target (+harness if applicable)
## off - Default, causes magic to be fully targetted before casting
put #var GH_MSNAP OFF

## MSNAP_PAUSE is the number of seconds to wait before a snapcast
put #var GH_MSNAP_PAUSE 0

## NOLODGE can be OFF or ON
## ON - Will treat thrown weapon as non-lodging
## OFF - Default, will try to avoid leaving behind lodged weapons
put #var GH_NOLODGE OFF

## RECALL can be OFF or ON
put #var GH_RECALL OFF

## RETREAT can be OFF or ON
## ON - Uses the retreats for ranged combat, melee!
## OFF - Default, bypasses retreats for ranged combat
put #var GH_RETREAT OFF

## RETREAT_COUNT is the number of critters in the room that will trigger retreating.
put #var GH_RETREAT_COUNT 0

put #var GH_RPA OFF

## SKIN can be OFF or ON
## ON - Skin creatures that can be skinned
##      Drops skins unless BUN is set to ON
## OFF - Default, just searches all creatures
put #var GH_SKIN OFF

## SLOW can be OFF or ON
## ON - Turns on pauses between weapon strikes
## OFF - Default, no pauses
put #var GH_SLOW OFF

## SNAP can be OFF or ON
## ON - Snap fires a ranged weapon
## OFF - Default, waits for a full aim to fire a ranged
put #var GH_SNAP OFF

## SNAP_PAUSE is the number of seconds to wait before snapfiring
put #var GH_SNAP_PAUSE 0

put #var GH_SORCERY OFF

## TARGET (global) can be ""(null) or any valid body part spells should target
put #var GH_TARGET ""

## TIMER can be OFF or ON
## ON - If the timer is greater than MAX_TRAIN_TIME, end the script
## OFF - Default, run script endlessly
put #var GH_TIMER OFF
put #var GH_TRAIN OFF

## TRAIN can be ON or OFF
## ON - Weapon or Alternate experience will be checked more often than just when critters die.
## OFF - Default, normal EXP check cycle.
if ("$GH_MULTI" = "OFF") then put #var GH_TRAIN OFF

put #var GH_BACKTRAIN OFF

############################
##  End GLOBAL Variables  ##
############################

############################
## Local Script Variables ##
############################
## ALTEXP can be OFF or ON
## ON - Will check an alternate skill as well as weapon skill
## OFF - Just check weapon experience
var ALTEXP OFF

## BRAWLING can be OFF or ON
## ON - Brawling mode, uses bare hands to kill creatures (or non-lethal for Empaths)
## OFF - Default
var BRAWLING OFF
var CURR_WEAPON ""

## CURR_STANCE can be Evasion, Parry_Ability or Shield_Usage
## Note: Used in stance switching
## Evasion - evasion stance is current one set
## Parry_Ability - parry stance is current one set
## Shield_Usage - shield stance is current one set
var CURR_STANCE Evasion

## EXP2 can be Hiding, NONE, Offhand_Weapon or Stalking
## Hiding - Used in sniping
## Offhand_Weapon - Used when offhand attacks are done
## Stalking - Used in ambushing and poaching
## NONE - Default
var EXP2 NONE

## FIRETYPE can be fire, poach or snipe
## fire - Default, generic firing of ranged weapon
## poach - Poaches creatures, hides and stalks before poaching
##         If creatures cannot be poached, fires normally
## snipe - Snipe creatures, hides and stalks before sniping
var FIRETYPE FIRE

## HAND can be <blank> or left
## <blank> - Default, attacks with the right hand
## left - Attacks with the left hand, used for one-handed weapons and throwing
var HAND

## HAND2 can be left or right
## Note: Used in stackables throwing to ensure you don't fill your hands
## left - Default
## right - Set when HAND = "left"
var HAND2 left

## MAGIC can be OFF or ON
## ON - Will cause a single cast of the specified spell before attacking with mundane weapons
## OFF - Default, won't trigger magic section
var MAGIC OFF
put #var GH_MAGIC OFF

## MAGIC_TYPE can be TM or PM or OFF
## TM - Will cause the appropriate TM usage, with targeting, and checks against TM skill
## PM - Avoid targeting, and uses the PM skill for checks
## OFF - Default
var MAGIC_TYPE OFF
put #var GH_MAGIC_TYPE OFF

## MAGIC_COUNT can be 0 or anything greater. It tracks the original numeric combo for resetting the counter.
var MAGIC_COUNT 0

## MAX_TRAIN_TIME is how long, in seconds, you want the script to run before stopping
## Note: MAX_TRAIN_TIME defaults to 10 minutes
var MAX_TRAIN_TIME 600

## RANGED can be OFF or ON
## ON - For use with ranged weapons; bows, xbows and thrown
## OFF - Default, used with melee weapons
var RANGED OFF
var REPEATING OFF

var RESONANCE 0
var casttype ""

## RETREATING can be OFF or ON. This variable is set internally.
## ON - Retreat triggers are ON
## OFF - Default, retreat triggers are OFF
var RETREATING OFF

## SHIELD can be NONE or <shield type>
## NONE - Default, no shield used
## <shield type> - This is set either during the weapon check or ranged combat
##                 If set during the weapon check for a melee weapon, the shield is used during combat
##                 If set during ranged, the shield is removed and stowed, and reworn upon leaving the script
var SHIELD NONE

## STACK can be OFF or ON
## ON - Throwing weapon is a stackable
## OFF - Default
var STACK OFF

## THROWN can be OFF or ON
## ON - Throw a weapon
## OFF - Default
var THROWN OFF

put #var GH_XPTYPE OFF

## WORN can be OFF or ON
## ON - A worn shield is used
## OFF - Default
var WORN OFF

################################
## End Local Script Variables ##
################################

## Counter is used to send you back to combat from searching
counter set 0
gosub RETREAT_UNTRIGGERS
#put info
put awaken

if ("$GH_MULTI" = "DMULTI") then goto LOAD_DEFAULT_SETTINGS
IF_1 goto VARIABLE_PRECHECK
if ("$GH_DEF_SET" = "YES") then goto LOAD_DEFAULT_SETTINGS

DEFAULT_NOT_SET:
	echo
	echo *** ERROR ***
	echo Your default setting are not set yet.
	echo Run .geniehunter DSET <<default settings>> to set them
	echo
	echo Now exiting script
	
	goto DONE
	
##############################
##                          ##
##  Start of actual script  ##
##                          ##
##############################
var GH_SAVED_LINE %0
action goto VARIABLE_PRECHECK when ^\.\.\.wait|^Sorry, you may only type
VARIABLE_PRECHECK:
	var 0 %GH_SAVED_LINE
	### In case $GHMDOPT is empty and we've been called from MULTI
	if "%1" = "\\$GHMDOPT" then shift
	
VARIABLE_CHECK:
	var LAST VARIABLE_CHECK
	gosub clear
	if matchre (toupper("%1"),"(%OPTIONVARS)") then
	{
		var LAST %1
		shift
		pause 0.1
		gosub %LAST
		goto VARIABLE_CHECK
	}

BEGIN:
	action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
	var LAST BEGIN
	echo
	echo *** BEGIN: ***
	echo
		match %LAST You can't do that while entangled in a web.
		matchre WEAPON_CHECK You get a|You draw|already holding|free to|With a quick flick of the wrist
		match BEGIN_HANDS free hand|need to have your right hand
		matchre BEGINA out of reach|remove|What were you|can't seem|Wield what\?
		match VARIABLE_CHECK You can only wield a weapon or a shield!
	if "%HAND" = "left" then put wield left my %1
  else put wield right my %1
	matchwait

BEGINA:		
	var LAST BEGINA
		match %LAST You can't do that while entangled in a web.
		matchre WEAPON_CHECK You sling|already holding|inventory|You remove|With a quick flick of the wrist
		matchre BEGIN_HANDS free hand|hands are full
		match BEGINB Remove what?
	put remove my %1
	matchwait

BEGINB:
	var LAST BEGINB
		match %LAST You can't do that while entangled in a web.
		match WEAPON_CHECK you get
		match NO_VALUE Please rephrase that command
		match VARIABLE_ERROR What were you
		match UNTIE it is untied.
	put get my %1
	matchwait
  
UNTIE:
	var RUCK ON
		match %LAST You can't do that while entangled in a web.
		match WEAPON_CHECK you get
		match NO_VALUE Please rephrase that command
		match VARIABLE_ERROR What were you
	put untie my %1
	matchwait
	
VARIABLE_ERROR:
	echo
	echo *** VARIABLE_ERROR: ***
	echo An error has occured with one of the variables
	echo
	goto DONE

####################################
##                                ##
##  First input was not a weapon  ##
##  Checking for variables now    ##
##                                ##
####################################

### Ambushing creatures, using the stalking skill for experience checks
AMB:
AMBU:
AMBUS:
AMBUSH:
	echo
	echo *** AMBUSHING: ***
	echo
	var curr_room $roomid
	action send unhide;send #goto %curr_room when ^You move along to follow your mark 
	put #var GH_AMBUSH ON
	var ALTEXP ON
	var EXP2 HIDING
	counter add 1
	if matchre(toupper("%1"), "STEALTH") then
	{
		var EXP2 Stealth
		ECHO *** Checking Hiding Experience ***
		shift
	}
	pause 0.5
	put remove my tooled mask;stow my tooled mask
	pause 0.5
	put remove gauntlets;stow my gauntlets
	pause 0.5
	put remove my armor;stow my armor
	pause 0.5
#	put remove my greaves;stow my greaves
#	pause 0.5
#	put stance set $parrystance
	pause 0.5
	put remove my $buckler;stow my $buckler
	pause 2
	return

## Appraising creatures until appraisal is locked
APPR:
APPRAISE:
APPRAISAL:
	echo
	echo *** APPRAISAL: ***
	echo
	put #var GH_APPR YES
	return
	
## Arranging skinnable creatures before skinning
## Turns skinning on if it is not already
ARRA:
ARRAN:
ARRANG:
ARRANGE:
	echo
	echo *** ARRANGE: ***
	echo
	put #var GH_ARRANGE ON
	put #var GH_SKIN ON
	if matchre("%1","^\d+$") then
	{
		put #var GH_ARR_NUM %1
		shift
	}
	else put #var GH_ARR_NUM 5
	return

BACKTRAIN:
	echo *** BACKTRAINING: ***
	put #var GH_BACKTRAIN ON
	put #var cam_mana 1
	pause 5
#	gosub CAM_INVOKE
#	pause
	return

## Setting the stance to shield/blocking
BLO:
BLOC:
BLOCK:
	echo
	echo *** BLOCK: ***
	echo
#	put #var GH_PARRYING 0
#	var CURR_STANCE Shield_Usage
#	var SHORT_STANCE shield
	SET_SHIELD_STANCE:
		var LAST SET_SHIELD_STANCE
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You are now set to|Setting your
		put stance set 90 9 90
		matchwait

BOB:
BOBB:
	echo *** BOB: ***
	put #var GH_BOB ON
	return
	
## Will bundle anything skinned.  If skinning not enabled this does nothing.
BUN:
BUND:
BUNDL:
BUNDLE:
	echo
	echo *** BUNDLE: ***
	echo
	put #var GH_BUN ON
	put #var GH_SKIN ON
	return

BUNDLEWORN:
	echo
	echo *** BUNDLEWORN: ***
	echo
	put #var GH_BUN ON
	put #var GH_BUN_WORN ON
	put #var GH_SKIN ON
	return

BUFF:
BARD:
  echo *** BARDBUFF ***
  put #var GH_BUFF ON
  put #var GH_BUFF_SPELL %1
  var BUFFSPELL %1
  shift
  put #var GH_BUFF_MANA %1
  shift
  if $spell_%BUFFSPELL_isactive = 0 then
  {
    action remove ^\.\.\.wait|^Sorry, you may only type
    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
    waitfor Spell Cast
    action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
  }
  return 
	
## Implements brawling attacks
BRA:
BRAW:
BRAWL:
BRAWLI:
BRAWLIN:
BRAWLING:
	echo
	echo *** BRAWLING: ***
	echo
	gosub clear
	var WEAPON_EXP Brawling
	var BRAWLING ON
	put #var GH_RANGED OFF
#	if (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
#	if ("$GH_BOB" = "ON") then var COMBO1 bob   
#	else var COMBO1 dodge
	var COMBO1 attack
	var COMBO2 attack
	var COMBO3 attack
	var COMBO4 attack
	var COMBO5 attack
	var COMBO6 unused
	var COMBO7 unused
	counter add 500
  var casttype ""
  gosub SPELLCHECKING
	if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
	if ("%DSET" = "ON") then goto SET_DEFAULT
	if_1 then gosub EQUIP_SHIELD %1
	goto %c

## Implements tactics training
TAC:
TACT:
TACTIC:
TACTICS:
	echo
	echo *** TACTICS: ***
	echo
	gosub clear
	var WEAPON_EXP Tactics
	var BRAWLING ON
	put #var GH_RANGED OFF
#	if (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
#	if ("$GH_BOB" = "ON") then var COMBO1 bob   
#	else var COMBO1 dodge
	var COMBO1 attack
	var COMBO2 circle
	var COMBO3 weave
	var COMBO4 bob
	var COMBO5 attack
	var COMBO6 unused
	var COMBO7 unused
	counter add 500
  gosub SPELLCHECKING
	if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
	if ("%DSET" = "ON") then goto SET_DEFAULT
	if_1 then gosub EQUIP_SHIELD %1
	goto %c

## Juggles when no monsters
CAM:
CAMB:
CAMBRINTH:
	echo *** CAMBRINTH: ***
	put #var GH_CAMB ON
	put #var cam_leeched 1
	put #var cam_slipped 1
	return

## Implements Cyclic TM
CYC:
CYCL:
CYCLIC:
CYCLICS:
	echo
	echo *** CYCLIC: ***
	echo
	gosub clear
  put #var GH_SORCERY OFF
	var WEAPON_EXP Targeted_Magic
	var BRAWLING ON
	put #var GH_BOB OFF
	var CYCLIC ON
	put #var GH_RANGED OFF
	var COMBO1 circle
	var COMBO2 attack
	var COMBO3 bob
	var COMBO4 attack
	var COMBO5 unused
	var COMBO6 unused
	var COMBO7 unused
	counter add 400
	put #var GH_CYCLIC %1
	shift
	put #var GH_MANA %1
	shift
	if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
	if ("%DSET" = "ON") then goto SET_DEFAULT
	if_1 then gosub EQUIP_SHIELD %1
  put .cast $GH_CYCLIC $GH_MANA
  waitfor Spell Cast
	goto %c

## Implements Cyclic TM
RCYC:
RCYCL:
RCYCLIC:
RCYCLICS:
	echo
	echo *** RCYCLIC: ***
	echo
  put #var GH_SORCERY OFF
	var WEAPON_EXP Targeted_Magic
	var CYCLIC ON
	put #var GH_CYCLIC %1
	shift
	put #var GH_MANA %1
	shift
	if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
	if ("%DSET" = "ON") then goto SET_DEFAULT
	put .cast $GH_CYCLIC $GH_MANA
  waitfor Spell Cast
	return


DEF:
DEFA:
DEFAU:
DEFAUL:
DEFAULT:
	echo
	echo *** DEFAULT: ***
	echo Using Default Settings
	echo
	gosub clear
	if ("$GH_MULTI" != "OFF") then goto DEFAULT_ERROR
	goto LOAD_DEFAULT_SETTINGS
DEFAULT_ERROR:
	echo
	echo *** DEFAULT_ERROR: ***
	echo Cannot use keyword DEFAULT with keyword multi
	echo To use Default settings with multi-weapons, use keyword dmulti
	echo
	goto DONE
	
DSET:
	echo
	echo *** DEFAULT-SET: ***
	echo Preparing to set Default settings
	echo
	var DSET ON
	return
	
DMSET:
	echo
	echo *** DEFAULT-MULTI-SET: ***
	echo Preparing to setup up weapons to use in multi.
	echo Using other default settings
	echo
	var SET_NUM 1
	SET_DM_STRING:
		if (SET_NUM > 10) then goto DONE_SET_DM
		put #var GH_MULTI_WEAPON_%SET_NUM %1
		math SET_NUM add 1
		shift
		if_1 goto SET_DM_STRING
	DONE_SET_DM:
	math SET_NUM subtract 1
	put #var GH_MULTI_NUM %SET_NUM
	goto DONE
	
DMU:
DMUL:
DMULT:
DMULTI:
	echo
	echo *** DMULTI: ***
	echo
	gosub clear
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	put #var GH_MULTI DMULTI
	if matchre("%1","^\d+$") then
		{
			put #var GH_MULTI_CURR_NUM %1
			put #var GHMCURRNUM $GH_MULTI_CURR_NUM
			if ($GH_MULTI_CURR_NUM > $GH_MULTI_NUM) then goto MULTI_ERROR
			goto DMULTI_$GH_MULTI_CURR_NUM
		}
	put #var GH_MULTI_CURR_NUM 1
	put #var GHMCURRNUM $GH_MULTI_CURR_NUM
	DMULTI_1:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_1
	DMULTI_2:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_2
	DMULTI_3:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_3
	DMULTI_4:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_4
	DMULTI_5:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_5
	DMULTI_6:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_6
	DMULTI_7:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_7
	DMULTI_8:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_8
	DMULTI_9:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_9
	DMULTI_10:
		put .geniehunter MULTIWEAPON $GH_MULTI_WEAPON_10
	DMULTI_ERROR:
		echo
		echo *** DMULTI_ERROR: ***
		echo Something bad happened trying to multi-weapon with defaults
	goto DONE

DYING:
	var DYING ON
	return

## Sets the stance to evasion
EVA:
EVAS:
EVAD:
EVASI:
EVADE:
EVASIO:
EVASION:
DOD:
DODG:
DODGE:
	echo
	echo *** EVASION: ***
	echo
	var CURR_STANCE Evasion
	var SHORT_STANCE evasion
	SET_EVAS_STANCE:
		var LAST SET_EVAS_STANCE
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You are now set to|Setting your
		put stance set $evastance
		matchwait

## Will check exp, ends scripts when checked skill is locked
EXP:
	echo
	echo *** EXP: ***
	echo 
	put #var GH_EXP ON
	return

## Will hide before using the HUNT verb when roaming
HIDING:
	echo *** HIDING: ***
	put #var GH_HIDING ON
	return


## Loots everything
LOOT:
LOOTA:
LOOTAL:
LOOTALL:
	echo
	echo *** LOOT_ALL: ***
	echo
	put #var GH_LOOT ON
	put #var GH_LOOT_GEM ON
	put #var GH_LOOT_BOX ON
	put #var GH_LOOT_COIN ON  
	put #var GH_LOOT_JUNK ON
	return

## Loots boxes
LOOTB:
LOOTBO:
LOOTBOX:
LOOTBOXE:
LOOTBOXES:
	echo
	echo *** LOOT_BOXES: ***
	echo
	if $box_cont_num > $box_cont_num_max then
	{
		put #var GH_LOOT_BOX OFF
		put #var loottype TREASURE
		return
	}
	put #var GH_LOOT ON
	put #var GH_LOOT_BOX ON
	return

## Loots coins
LOOTC:
LOOTCO:
LOOTCOI:
LOOTCOIN:
LOOTCOINS:
	echo
	echo *** LOOT_COINS: ***
	echo
	put #var GH_LOOT ON
	put #var GH_LOOT_COIN ON	
	return

## Loots gems
LOOTG:
LOOTGE:
LOOTGEM:
LOOTGEMS:
	echo
	echo *** LOOT_GEMS: ***
	echo
	put #var GH_LOOT ON
	put #var GH_LOOT_GEM ON
	return

## Loots Junk
LOOTJUNK:
	echo
	echo *** LOOT_JUNK: ***
	echo
	put #var GH_LOOT ON
	put #var GH_LOOT_JUNK ON
	return

## Loots lockpicks
LOOTLOCK:
	echo
	echo *** LOOT_LOCK: ***
	echo
	put #var GH_LOOT ON
	put #var GH_LOOT_LOCK ON
	return

## Single cast of spell before non-magical combat
MAG:
MAGIC:
	echo
	echo *** MAGIC: ***
	echo
	var MAGIC ON
	return

	HARNESS_CHECK:
		if matchre("%1","^\d+$") then
		{
			if ($GH_HARN1 = 0) then put #var GH_HARN1 %1
			elseif ($GH_HARN2 = 0) then put #var GH_HARN2 %1
			else put #var GH_HARN3 %1
			ECHO *** Harnessing an extra %1 ***
			shift
		}
	return

## Setup common multi weapon settings
MDOPTSET:
	echo *** MDOPTSET: ***
	echo Setting default options for MULTIWEAPON to %0
	put #var GHMDOPT %0
	exit

## Snapfires a ranged weapon
MSNA:
MSNAP:
MSNAPCAST:
	echo
	echo *** MSNAP: ***
	echo
	put #var GH_MSNAP ON
	if matchre("%1","^\d+$") then
	{
		put #var GH_MSNAP_PAUSE %1
		ECHO *** Pausing %1 seconds after aim before firing. ***
		shift
	}
	return

## Starts training Multiple weapons
MU:
MUL:
MULT:
MULTI:
	echo
	echo *** MULTI: ***
	echo
	gosub clear
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	put #var GH_MULTI MULTI
	if matchre("%1","^\d+$") then
		{
			put #var GH_MULTI_CURR_NUM %1
			if ($GH_MULTI_CURR_NUM > $GH_MULTI_NUM) then goto MULTI_ERROR
			else goto MULTI_%1
		}
	if ("%1" = "current") then
	{
		if ($GH_MULTI_CURR_NUM > $GH_MULTI_NUM) then goto MULTI_ERROR
		else goto MULTI_$GH_MULTI_CURR_NUM
	}
	put #var GH_MULTI_CURR_NUM 1
	MULTI_1:
	MULTI_01:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_01
	MULTI_2:
	MULTI_02:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_02
	MULTI_3:
	MULTI_03:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_03
	MULTI_4:
	MULTI_04:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_04
	MULTI_5:
	MULTI_05:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_05
	MULTI_6:
	MULTI_06:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_06
	MULTI_7:
	MULTI_07:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_07
	MULTI_8:
	MULTI_08:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_08
	MULTI_9:
	MULTI_09:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_09
	MULTI_10:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_10
	MULTI_11:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_11
	MULTI_12:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_12
	MULTI_13:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_13
	MULTI_14:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_14
	MULTI_15:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_15
	MULTI_16:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_16
	MULTI_17:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_17
	MULTI_18:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_18
	MULTI_19:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_19
	MULTI_20:
		put .geniehunter MULTIWEAPON $GHMDOPT $GH_MULTI_20
	MULTI_ERROR:
		echo
		echo *** MULTI_ERROR: ***
		echo Something bad happened trying to multi-weapon
	goto DONE

SET:
MSET:
	echo
	echo *** MULTI-SET: ***
	echo Preparing to setup up multi-weapon training
	echo
	gosub clear
	var SET_NUM 1
	SET_M_STRING:
		if (%SET_NUM > 20) then goto DONE_M_SET
		if (%SET_NUM < 10) then put #var GH_MULTI_0%SET_NUM %1
		else put #var GH_MULTI_%SET_NUM %1
		math SET_NUM add 1
		shift
		if_1 goto SET_M_STRING
	DONE_M_SET:
	math SET_NUM subtract 1
	put #var GH_MULTI_NUM %SET_NUM
	goto DONE

## Setting the stance to shield/blocking
NORM:
NORMA:
NORMAL:
	echo
	echo *** NORMAL STANCE: ***
	echo
	SET_NORMAL_STANCE:
		var LAST SET_NORMAL_STANCE
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You are now set to|Setting your
		put stance set 63 63 63
		matchwait


## Uses the weapon in the offhand
## Currently just for throwing weapons from the left hand
OFF:
OFFH:
OFFHA:
OFFHAN:
OFFHAND:
	echo
	echo *** OFFHAND: ***
	echo
	var HAND left
	var HAND2 right
	var ALTEXP ON
	var EXP2 Offhand_Weapon
	return	
  
## Sets the stance to parry
PAR:
PARR:
PARRY:
	echo
	echo *** PARRY: ***
	echo
#	if ((toupper("$GH_PARRYONE") = "ON") && ($Parry_Ability.LearningRate > 32)) then
#	{
#		echo *** PARRY LOCKED - Setting Shield ***
#		gosub BLOCK
#		pause
#		return
#	}
#	var CURR_STANCE Parry_Ability
#	var SHORT_STANCE parry
#	put #var GH_PARRYING 1
	SET_PARRY_STANCE:
		var LAST SET_PARRY_STANCE
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You are now set to|Setting your
		put stance set 90 90 9
		matchwait

## Casts a spell using non-targeted magic
PM:
TM:
	echo
	if (toupper("%LAST") = "TM") then 
	{
		var MAGIC_TYPE TM
		echo ***  TM:  ***
	} else 
	{
		var MAGIC_TYPE PM
		echo ***  PM:  ***
	}
	echo
	counter add 2000	
	var ALTEXP ON
	put #var GH_MAGIC ON
	put #var GH_MAGIC_TYPE TM
#	pause 5
	if (toupper("%MAGIC_TYPE") = "TM") then var EXP2 Targeted_Magic
	else var EXP2 Primary_Magic
	if (toupper("%1")) = "FULL" then
	{
		var FULLTARGET YES
		ECHO *** Targetting Fully ***
		shift
	}
	else var FULLTARGET NO
	put #var GH_SPELL %1
	shift
	put #var GH_MANA %1
	shift
	put #var GH_HARN1 0
	IF_1 gosub HARNESS_CHECK
	put #var GH_HARN2 0
	IF_1 gosub HARNESS_CHECK
	put #var GH_HARN3 0
	IF_1 gosub HARNESS_CHECK
	IF_1 return
	else goto BRAWL

## Poaching a target, if target is unpoachable, just fires 
PO:
POA:
POAC:
POACH:
	echo
	echo *** POACH: ***
	echo
	var FIRETYPE POACH
	var ALTEXP ON
	var EXP2 Stalking
	return

REC:
RECAL:
RECALL:
	echo *** RECALLING: ***
	put #var GH_RECALL ON
	var recall_type 0
	var recalls immortal|herb|holiday
	return

### Turns off Retreating
RET:
RETREAT:
	echo
	echo *** RETREAT: ***
	echo
	put #var GH_RETREAT ON
	if matchre("%1","^\d+$") then
	{
		put #var GH_RETREAT_COUNT %1
		ECHO *** Retreating when %1 or more critters are around. ***
		shift
	}
	return

RES:
RESO:
RESON:
RESONAN:
RESONANCE:
  echo *** Resonance: ***
  var RESONANCE 1
  return
	
RPA:
	echo *** RPA: ***
	put #var GH_RPA ON
	return

## Skins creatures that can be skinned
SKIN:
	echo
	echo *** SKIN: ***
	echo
	put #var GH_SKIN ON
	return
	
## Retreats while skinning
SKINR:
SKINRE:
SKINRET:
	echo
	echo *** SKINRET: ***
	echo
	put #var GH_SKIN ON
	put #var GH_SKIN_RET ON
	return
	
SLOW:
	echo
	echo ***  SLOW:  ***
	echo
	put #var GH_SLOW ON
	return

## Snapfires a ranged weapon
SNA:
SNAP:
SNAPFIRE:
	echo
	echo *** SNAP: ***
	echo
	put #var GH_SNAP ON
	if matchre("%1","^\d+$") then
	{
		put #var GH_SNAP_PAUSE %1
		ECHO *** Pausing %1 seconds after aim before firing. ***
		shift
	}
	return

## Sorcery
SOR:
SORC:
SORCER:
SORCERY:
  echo
  echo *** SORCERY: ***
  echo
  put #var GH_SORCERY ON
  var SORC_PREPPED 0
  var SORC_READY 0
  action (sorc) var SORC_READY 1 when ^You feel fully prepared to cast your spell
  action (sorc) off
  return

## Throws a stacked weapon (e.g. throwing blades)
STACK:
STACKS:
	echo
	echo *** STACK: ***
	echo
	var STACK ON
	goto THROW

SWAP:
BAST:
BASTA:
BASTAR:
BASTARD:
	echo
	echo *** SWAP: ***
	echo
	gosub clear
	var SWAP_TYPE %1
	shift
	SWAP_WIELD:
		var LAST SWAP_WIELD
			match %LAST You can't do that while entangled in a web.
			matchre SWAP_%SWAP_TYPE You draw|re already|free ot
			match BEGIN_HANDS free hand|need to have your right hand
			matchre SWAP_REMOVE out of reach|remove|What were you|can't seem|Wield what\?
			match LABELERROR You can only wield a weapon or a shield!
		put wield right my %1
		matchwait	
	SWAP_REMOVE:
		var LAST SWAP_REMOVE
			match %LAST You can't do that while entangled in a web.
			matchre SWAP_%SWAP_TYPE you sling|re already|inventory|you remove
			match SWAP_GET remove what?
			match BEGIN_HANDS hands are full
		put remove my %1
		matchwait
	SWAP_GET:
		var LAST SWAP_GET
			match %LAST You can't do that while entangled in a web.
			match SWAP_%SWAP_TYPE you get
			match LABELERROR What were you
		put get my %1
		matchwait		
	SWAP_1:
		var LAST SWAP_1
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE two-handed
			match WEAPON_CHECK heavy
		put swap my %1
		matchwait		
	SWAP_2:
		var LAST SWAP_2
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE heavy
			match WEAPON_CHECK two-handed
		put swap my %1
		matchwait
	SWAP_B:
		var LAST SWAP_B
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE edged
			match WEAPON_CHECK blunt
		put swap my %1
		matchwait
	SWAP_E:	
		var LAST SWAP_E
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE blunt
			match WEAPON_CHECK edged
		put swap my %1
		matchwait
	SWAP_PI:
		var LAST SWAP_PI
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE halberd|short staff|quarter staff
			match WEAPON_CHECK pike
		put swap my %1
		matchwait
	SWAP_SS:
		var LAST SWAP_SS
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE halberd|pike|quarter staff
			match WEAPON_CHECK short staff
		put swap my %1
		matchwait	
	SWAP_HA:
		var LAST SWAP_HA
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE short staff|pike|quarter staff
			match WEAPON_CHECK halberd
		put swap my %1
		matchwait
	SWAP_QS:
		var LAST SWAP_QS
			match %LAST You can't do that while entangled in a web.
			matchre PAUSE short staff|pike|halberd
			match WEAPON_CHECK quarter staff
		put swap my %1
		matchwait
	
## Sets a bodypart to target for ranged & spells
TARG:
TARGET:
	echo
	echo *** TARGET: ***
	echo
	if matchre("%1","^\D+$") then
	{
		put #VAR GH_TARGET %1
		echo Targetting the %1 with attacks.
		shift
	}
	return
	
## Throws a weapon
THR:
THRO:
THROW:
THROWN:
	echo
	echo *** THROWN: ***
	echo
	gosub clear
	var THROWN ON
	counter add 1200
	if (toupper("%1") = "NOLODGE") then
	{
		put #var GH_NOLODGE ON
		shift
	}
	WIELD_THROWN:
		var LAST WIELD_THROWN
			match %LAST You can't do that while entangled in a web.
			matchre THROW_VARI You get|You draw|free to|re already
			match BEGIN_HANDS free hand|need to have your right hand
			matchre THROW_EQUIP out of reach|remove|What were you|can't seem|Wield what\?
		if ("%1" = "rock") then put get my %1
		elseif ("%HAND" = "left") then put wield left my %1
		else put wield right my %1
		matchwait

	THROW_EQUIP:
		var LAST THROW_EQUIP
			match %LAST You can't do that while entangled in a web.
			matchre THROW_VARI You sling|re already|inventory|You remove|right hand
			match THROW_EQUIP_2 Remove what?
			match BEGIN_HANDS hands are full
		put remove my %1
		matchwait

	THROW_EQUIP_2:
		var LAST THROW_EQUIP_2
			match %LAST You can't do that while entangled in a web.
			match THROW_VARI You get
			match VARIABLE_CHECK What were you
		put get my %1
		matchwait

	THROW_VARI:  
		var LAST THROW_VARI
#		if (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
		var RANGED ON
		put #var GH_RANGED ON
		var CURR_WEAPON %1
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%HAND" = "left") then
		{
			if ("$lefthand" = "Empty") then gosub SWAP_LEFT $righthandnoun
			var THROWHAND lefthand
			var SECHAND righthand
		}
		else
		{
			if_2 then gosub EQUIP_SHIELD %2
			var THROWHAND righthand
			var SECHAND lefthand
		}
	APPRAISE_THROWN:
		var LAST APPRAISE_THROWN
		if ("$GH_XPTYPE" != "OFF") then goto $GH_XPTYPE
			match %LAST You can't do that while entangled in a web.
			match LT light thrown
			match HT heavy thrown
			matchre WEAPON_APP_ERROR Roundtime|It's hard to appraise
		put appr my %1 quick
		matchwait
	LT:
		var T_SHEATH %LT_SHEATH
		pause
#		put STORE THROWN %LT_SHEATH
		var WEAPON_EXP Light_Thrown
#		if ((toupper("$GH_TRAIN") = "ON") && ($%WEAPON_EXP.LearningRate > $exp)) then goto SWITCH_WEAPON
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c
	HT:
		var T_SHEATH %HT_SHEATH
		pause
#		put STORE THROWN %HT_SHEATH
		var WEAPON_EXP Heavy_Thrown
#		if ((toupper("$GH_TRAIN") = "ON") && ($%WEAPON_EXP.LearningRate > $exp)) then goto SWITCH_WEAPON
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c
	
TIM:
TIME:
TIMER:
	echo
	echo *** TIMER: ***
	echo
	put #var GH_TIMER ON
	var START_TIME %t
	if matchre("%1", "(\d+)") then 
	{
		var MAX_TRAIN_TIME $1
		shift
	}
	math MAX_TRAIN_TIME add %START_TIME
	return
	
TRAIN:
	echo
	echo *** TRAIN: ***
	echo
	put #var GH_EXP ON
	put #var GH_TRAIN ON
	return
	
TYPE:
	echo *** TYPE: %1 ***
	put #var GH_XPTYPE %1
	shift
	return

WO:
WORN:
	echo *** WORN: ***
	var WORN ON
	return
	
####################################
##                                ##
##    End variables & options     ##
##                                ##
####################################

BEGIN_HANDS:
	echo
	echo *** BEGIN_HANDS: ***
	echo
	echo ***************************
	echo **  Empty your hands and try again
	echo **       Ending script_    
	echo ***************************
	echo	
	exit

###############################
##                           ##
##  Weapon checking section  ##
##                           ##
###############################
  
WEAPON_CHECK:
	echo
	echo *** WEAPON_CHECK: ***
	echo
	var LAST WEAPON_CHECK
  var CURR_WEAPON %1
	if matchre(toupper("%2"), "BRAWL") then
	{
		shift
		shift
		goto BRAWLING
	}
	if matchre(toupper("%2"), "TACTICS") then
	{
  	shift
		shift
		goto TACTICS
	}
	if matchre(toupper("%2"), "CYCLIC") then
	{
		shift
		shift
		goto CYCLIC
	}
WEAPON_CHECK_2:
	var LAST WEAPON_CHECK_2
	if ("$GH_XPTYPE" != "OFF") then goto $GH_XPTYPE
		match %LAST You can't do that while entangled in a web.
		matchre LE (a|and) light edged 
		matchre ME (a|and) medium edged
		matchre HVE (a|and) heavy edged
		matchre 2HE (a|and) two-handed edged
		matchre LBLUNT (a|and) light blunt
		matchre MB (a|and) medium blunt
		matchre HB (a|and) heavy blunt
		matchre 2HB (a|and) two-handed blunt
		matchre STAFFSLING (a|and) staff sling
		matchre SHORTBOW (a|and) short bow
		matchre LONGBOW (a|and) long bow
		matchre COMPBOW (a|and) composite bow
		matchre LX  (a|and) light crossbow
		matchre HX (a|and) heavy crossbow
		matchre SHORTSTAFF (a|and) short staff
		matchre QSTAFF (a|and) quarter staff
		matchre PIKE (a|and) pike 
		matchre HALBERD (a|and) halberd
		matchre SLING (a|and) sling
		matchre WEAPON_APP_ERROR Roundtime|It's hard to appraise
	put appraise my %CURR_WEAPON quick
	matchwait

	SMALLEDGED:
		echo
		echo *** SMALLEDGED: ***
		echo
		var WEAPON_EXP Small_Edged
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	LARGEEDGED:
		echo
		echo *** LARGEEDGED: ***
		echo
		var WEAPON_EXP Large_Edged
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c
		
	SMALLBLUNT:
		echo
		echo *** SMALLBLUNT: ***
		echo
		var WEAPON_EXP Small_Blunt
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	LARGEBLUNT:
		echo
		echo *** LARGEBLUNT: ***
		echo
		var WEAPON_EXP Large_Blunt
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
 		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	STAFF:
		echo
		echo *** STAFF: ***
		echo
		var WEAPON_EXP Staves
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	POLEARM:
		echo
		echo *** POLEARM: ***
		echo
		var WEAPON_EXP Polearms
		var RANGED OFF
		put #var GH_RANGED OFF
		var COMBO1 attack
		var COMBO2 attack
		var COMBO3 attack
		var COMBO4 attack
		var COMBO5 attack
		counter add 500
		if_2 then gosub EQUIP_SHIELD %2
    if %RESONANCE = 1 then
    {
      action remove ^\.\.\.wait|^Sorry, you may only type
      put .cast resonance 10 40 %CURR_WEAPON
      waitfor Spell Cast
      action goto PAUSE when ^\.\.\.wait|^Sorry, you may only type
    }
    var casttype ""
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	BOW:
		echo
		echo *** SHORT_BOW: ***
		echo  
		var WEAPON_EXP Bow
		var RANGED ON
		put #var GH_RANGED ON
		var AMMO %BOW_AMMO
		pause 1
		put ret
		counter add 1000
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if_2 then gosub EQUIP_SHIELD %2
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c

	CROSSBOW:
  XBOW:
		echo
		echo *** XBOW: ***
		echo  
		var WEAPON_EXP Crossbow
		var RANGED ON
		put #var GH_RANGED ON
		var AMMO %XB_AMMO
		pause 1
		put ret
		counter add 1000
		if_2 then gosub EQUIP_SHIELD %2
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		goto %c
  
	SLING:
		echo
		echo *** SLING: ***
		echo  
		var WEAPON_EXP Slings
		var RANGED ON
		put #var GH_RANGED ON
		var AMMO %SLING_AMMO
		put #var GH_NOLODGE ON
		pause 1
		put ret
		counter add 1000
    put #var GH_SORCERY OFF
    var casttype ""
		if_2 then gosub EQUIP_SHIELD %2
    gosub SPELLCHECKING
		if ("%MAGIC_TYPE" != "OFF") then var MAGIC_COUNT %c
		if ("%DSET" = "ON") then goto SET_DEFAULT
		else goto %c


#######################
##                   ##
##   Useful gosubs   ##
##                   ##
#######################
SWAP_LEFT:
	var ITEM $1
SWAPPING_LEFT:
	pause 0.5
	var LAST SWAPPING_LEFT
		match %LAST You can't do that while entangled in a web.
		matchre RETURN to your left hand
		matchre SWAPPING_LEFT to your right hand
	put swap
	matchwait

SWAP_RIGHT:
	var ITEM $1
SWAPPING_RIGHT:
	pause 0.5
	var LAST SWAPPING_RIGHT
		match %LAST You can't do that while entangled in a web.
		matchre RETURN to your right hand
		matchre SWAPPING_RIGHT to your left hand
	put swap
	matchwait

REMOVE_SHIELD:
	var LAST REMOVE_SHIELD
	if ("%SHIELD" = "NONE") then var SHIELD $1
	pause 0.5
	# echo *** REMOVE_SHIELD: ***
		match %LAST You can't do that while entangled in a web.
		matchre SHIELD_ERROR any more room in|You just can't get
		matchre RETURN You put your|Stow what
	put remove my %SHIELD
	put stow my %SHIELD in my %WORN_CONTAINER
	matchwait 2
	goto REMOVE_SHIELD

EQUIP_SHIELD:
	var LAST EQUIP_SHIELD
	if ("%SHIELD" = "NONE") then var SHIELD $1
	pause 0.5
	# echo
	# echo *** EQUIP_SHIELD: ***
	# echo
	GETTING_SHIELD:
			match %LAST You can't do that while entangled in a web.
			match WEAPON_APP_ERROR What were you
				if "%WORN" = "ON" then matchre SHIELD_ERROR You can't wear any more|You sling
				if "%WORN" = "ON" then matchre RETURN You slide your|You are already wearing that
				else matchre RETURN already|You get|You sling|You remove|You draw out
		if "%WORN" = "ON" then
		{
			put get my %SHIELD
			put wear my %SHIELD	
		} 
		else 
		{
			put remove my %SHIELD
			put wield left my %SHIELD
		}
		matchwait

UNEQUIP_SHIELD:
	var LAST STOWING_SHIELD
	pause 0.5
	# echo
	# echo *** UNEQUIP_SHIELD ***
	# echo
	STOWING_SHIELD:
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You put your|You sling|You are already wearing that|But that is already in your inventory
		put wear my %SHIELD
		put stow my %SHIELD
		matchwait

WIELD_WEAPON:
	#var LAST WIELDING_WEAPON
	var STRING $1
	pause 0.5
	# echo
	# echo *** WIELD_WEAPON: ***
	# echo
	WIELDING_WEAPON:
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You get|You draw|already holding|You deftly remove|With a flick of your wrist
			matchre REMOVING_WEAPON out of reach|remove|What were you|can't seem|Wield what
		if ("%STRING" = "rock") then put get my %STRING
		else put wield %STRING
		matchwait
	REMOVING_WEAPON:
		var LAST REMOVING_WEAPON
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You sling|already holding|inventory|You remove|You deftly remove|With a quick flick of the
			matchre PICKUP_WEAPON free hand|hands are full|Remove what|You aren't wearing that
		put remove %STRING
		matchwait
	PICKUP_WEAPON:
		var LAST PICKUP_WEAPON
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You pick up|You are already holding that|You pull
			matchre ERROR You can't seem to find|What were your referring
		put get %STRING
		matchwait

WIELD_LEFT:
	var LAST WIELD_LEFT
	var STRING $1
	pause 0.5
	# echo
	# echo *** WIELD_LEFT: ***
	# echo
	WIELDING_LEFT:
			match %LAST You can't do that while entangled in a web.
			matchre RETURN You get|You draw|already holding|You deftly remove|With a flick of your wrist
			matchre REMOVING_LEFT out of reach|remove|What were you|can't seem|Wield what
		if ("%STRING" = "rock") then put get my %STRING
		else put wield left %STRING
		matchwait
	REMOVING_LEFT:
			matchre RETURN You sling|already holding|inventory|You remove|You deftly remove|With a quick flick of the
			matchre PICKUP_LEFT free hand|hands are full|Remove what|You aren't wearing that
		put remove %STRING
		matchwait
	PICKUP_LEFT:
			matchre RETURN You pick up|You are already holding that|You pull
			matchre ERROR You can't seem to find|What were your referring
		put get %STRING
		matchwait
	
SHEATHE:
	var LAST SHEATHING
	# echo
	# echo *** SHEATHE ***
	# echo
	var COMM_STRING $0
	SHEATH_1:
	pause 0.5
  if "COMM_STRING" = "sling" then goto WEAR_WEAPON
  if "COMM_STRING" = "halberd" then goto WEAR_WEAPON
	SHEATHING:
			match %LAST You can't do that while entangled in a web.
			matchre SHEATH_1 Roundtime|\.\.\.wait|^Sorry, you may only type
			matchre WEAR_WEAPON where\?
			matchre RETURN You sheath|You strap|With a flick of your wrist|You hang|you sheath|Sheathe what?|You need to be holding the
		put shea %COMM_STRING
		matchwait 2
		goto SHEATH_1
	WEAR_WEAPON_1:
	pause 0.5
	WEAR_WEAPON:
		var LAST WEAR_WEAPON
			match %LAST You can't do that while entangled in a web.
			matchre WEAR_WEAPON_1 Roundtime|\.\.\.wait|^Sorry, you may only type
			matchre RETURN You sling|You spin your|Perhaps you should be holding that first|You are already wearing|You attach
			match STOW_WEAPON You can't wear that!
		put wear %COMM_STRING
		matchwait 2
		goto WEAR_WEAPON_1
	STOW_WEAPON_1:
	pause 0.5
	STOW_WEAPON:
		var LAST STOW_WEAPON
			match %LAST You can't do that while entangled in a web.
			matchre STOW_WEAPON_1 Roundtime|\.\.\.wait|^Sorry, you may only type
			matchre RETURN You put your|With a quick flick of the|With a flick of|You sheath the
			matchre ERROR free hand|hands are full|Remove what?|Stow what?
		if ("righthandnoun" = "katana") then put sheath my katana in my katana sheath
		else put stow %COMM_STRING
		matchwait 2
		goto STOW_WEAPON_1

RANGE_SHEATHE:
	if (("%THROWN" = "ON") || ("%STACK" = "ON") || ("%REPEATING" = "ON")) then goto GO_ON
	# echo
	# echo *** RANGE_SHEATHE: ***
	# echo   
	#var LAST RANGE_SHEATHE
#	pause 1
#	put ret
#	waitfor You
	pause 1
	put unload %CURR_WEAPON
	pause 1
	STOW_AMMO:
		var LAST STOW_AMMO
			match %LAST You can't do that while entangled in a web.
			matchre STOW_AMMO You pick up|You put|\.\.\.wait
			match GO_ON Stow what?
		put stow %AMMO
		matchwait 2
		goto STOW_AMMO
	GO_ON:
		pause 1
		if ("%STACK" = "ON") then put stow %CURR_WEAPON
		else gosub SHEATHE %CURR_WEAPON
	return

############################################
##                                        ##
##  Default section, setting and loading  ##
##                                        ##
############################################
SET_DEFAULT:
	echo
	echo *** SET_DEFAULT ***
	echo Setting default values
	echo
	put #var GH_DEF_SET YES
	put #var GH_DEF_COUNTER %c
	put #var GH_DEF_ALTEXP %ALTEXP
	put #var GH_DEF_AMMO %AMMO
	put #var GH_DEF_BACKSTAB %BACKSTAB
	put #var GH_DEF_BRAWLING %BRAWLING
	put #var GH_DEF_COMBO1 %COMBO1
	put #var GH_DEF_COMBO2 %COMBO2
	put #var GH_DEF_COMBO3 %COMBO3
	put #var GH_DEF_COMBO4 %COMBO4
	put #var GH_DEF_COMBO5 %COMBO5
	put #var GH_DEF_COMBO6 %COMBO6
	put #var GH_DEF_COMBO7 %COMBO7
	put #var GH_DEF_COMBO8 %COMBO8
	put #var GH_DEF_CURR_STANCE %CURR_STANCE
	put #var GH_DEF_WEAPON %CURR_WEAPON
	put #var GH_DEF_EVAS_LVL %EVAS_LEVEL
	put #var GH_DEF_EXP2 %EXP2
	put #var GH_DEF_FIRETYPE %FIRETYPE
	if ("%HAND" = "") then put #var GH_DEF_HAND none
	else put #var GH_DEF_HAND %HAND
	put #var GH_DEF_HAND2 %HAND2
	put #var GH_DEF_MAGIC %MAGIC
	put #var GH_DEF_MAGIC_TYPE %MAGIC_TYPE
	put #var GH_DEF_MAGIC_COUNT %MAGIC_COUNT
	put #var GH_DEF_MAX_TRAIN_TIME %MAX_TRAIN_TIME
	put #var GH_DEF_PARRY_LVL %PARRY_LEVEL
	put #var GH_DEF_RANGED %RANGED
	put #var GH_DEF_SHIELD %SHIELD
	put #var GH_DEF_SHIELD_LVL %SHIELD_LEVEL
	put #var GH_DEF_STACK %STACK
	put #var GH_DEF_THROWN %THROWN
	put #var GH_DEF_WEAPON_EXP %WEAPON_EXP
	put #var GH_DEF_XCOUNT %xCOUNT
	put #var GH_DEF_AMBUSH $GH_AMBUSH
	put #var GH_DEF_APPR $GH_APPR
	put #var GH_DEF_ARRANGE $GH_ARRANGE
	put #var GH_DEF_BUN $GH_BUN 
	put #var GH_DEF_EXP $GH_EXP
	put #var GH_DEF_LOOT $GH_LOOT
	put #var GH_DEF_LOOT_BOX $GH_LOOT_BOX
	put #var GH_DEF_LOOT_COIN $GH_LOOT_COIN
	put #var GH_DEF_LOOT_GEM $GH_LOOT_GEM
	put #var GH_DEF_MANA $GH_MANA
	put #var GH_DEF_HARN $GH_HARN
	put #var GH_DEF_RETREAT $GH_RETREAT
	put #var GH_DEF_SKIN $GH_SKIN
	put #var GH_DEF_SKIN_RET $GH_SKIN_RET
	put #var GH_DEF_SLOW GH_SLOW
	put #var GH_DEF_SNAP $GH_SNAP
	put #var GH_DEF_SPELL $GH_SPELL
	if ("$GH_TARGET" = "") then put #var GH_DEF_TARGET none
	else put #var GH_DEF_TARGET $GH_TARGET
	put #var GH_DEF_TIMER $GH_TIMER 
	put #var GH_DEF_TRAIN $GH_TRAIN
	### BETA variables
	put #var GH_DEF_BOB $GH_BOB
	put #var GH_DEF_SNAP_PAUSE $GH_SNAP_PAUSE
	put #var GH_DEF_MSNAP $GH_MSNAP
	put #var GH_DEF_MSNAP_PAUSE $GH_MSNAP_PAUSE
	put #var GH_DEF_LOOT_LOCK $GH_LOOT_LOCK
	put #var GH_DEF_LOOT_TYPE $GH_LOOT_TYPE
	put #var GH_DEF_WORN %WORN
		
	echo 
	echo Default setting are now ready
	echo
	exit
	
LOAD_DEFAULT_SETTINGS:
	echo
	echo *** LOAD_DEFAULT_SETTINGS ***
	echo
	## Loading default nonweapon settings
	var ALTEXP $GH_DEF_ALTEXP
	var BACKSTAB $GH_DEF_BACKSTAB
	var BRAWLING $GH_DEF_BRAWLING
	var CURR_STANCE $GH_DEF_CURR_STANCE
	var EVAS_LEVEL $GH_DEF_EVAS_LVL
	var EXP2 $GH_DEF_EXP2
	var FIRETYPE $GH_DEF_FIRETYPE
	if ("$GH_DEF_HAND" = "none") then var HAND
	else var HAND $GH_DEF_HAND
	var HAND2 $GH_DEF_HAND2
	var MAGIC $GH_DEF_MAGIC
	var MAGIC_TYPE $GH_DEF_MAGIC_TYPE
	var MAGIC_COUNT $GH_DEF_MAGIC_COUNT
	var PARRY_LEVEL $GH_DEF_PARRY_LVL
	var RANGED $GH_DEF_RANGED
	var SHIELD_LEVEL $GH_DEF_SHIELD_LVL
	var STACK $GH_DEF_STACK
	var xCOUNT $GH_DEF_XCOUNT
	put #var GH_AMBUSH $GH_DEF_AMBUSH
	put #var GH_APPR $GH_DEF_APPR
	put #var GH_BUN $GH_DEF_BUN
	if ("$GH_MULTI" = "OFF") then put #var GH_EXP $GH_DEF_EXP
	put #var GH_HARN $GH_DEF_HARN
	put #var GH_LOOT $GH_DEF_LOOT
	put #var GH_LOOT_BOX $GH_DEF_LOOT_BOX
	put #var GH_LOOT_COIN $GH_DEF_LOOT_COIN
	put #var GH_LOOT_GEM $GH_DEF_LOOT_GEM
	put #var GH_MANA $GH_DEF_MANA
	put #var GH_RETREAT $GH_DEF_RETREAT	
	put #var GH_SKIN $GH_DEF_SKIN
	put #var GH_SKIN_RET $GH_DEF_SKIN_RET
	put #var GH_SLOW $GH_DEF_SLOW
	put #var GH_SNAP $GH_DEF_SNAP
	put #var GH_SPELL $GH_DEF_SPELL
	if ("$GH_DEF_TARGET" = "none") then put #var GH_TARGET 
	else put #var GH_TARGET  $GH_DEF_TARGET
	var THROWN $GH_DEF_THROWN
	put #var GH_TIMER $GH_DEF_TIMER
	var MAX_TRAIN_TIME $GH_DEF_MAX_TRAIN_TIME
	DEF_STANCE_SETUP:
		if ("%CURR_STANCE" = "Evasion") then put stance evasion
		elseif ("%CURR_STANCE" = "Parry_Ability") then put stance parry
		elseif ("%CURR_STANCE" = "Shield_Usage") then put stance shield
		elseif ("%CURR_STANCE" = "Custom") then put stance custom
	
	### BETA Variables
	put #var GH_BOB $GH_DEF_BOB
	put #var GH_SNAP_PAUSE $GH_DEF_SNAP_PAUSE
	put #var GH_MSNAP $GH_DEF_MSNAP
	put #var GH_MSNAP_PAUSE $GH_DEF_MSNAP_PAUSE
	put #var GH_LOOT_LOCK $GH_DEF_LOOT_LOCK
	put #var GH_LOOT_TYPE $GH_DEF_LOOT_TYPE
	var WORN $GH_DEF_WORN
	
	if ("$GH_MULTI" != "OFF") then goto BEGIN
	
	## Loading default weapon settings
	var AMMO $GH_DEF_AMMO
	var COMBO1 $GH_DEF_COMBO1
	var COMBO2 $GH_DEF_COMBO2
	var COMBO3 $GH_DEF_COMBO3
	var COMBO4 $GH_DEF_COMBO4
	var COMBO5 $GH_DEF_COMBO5
	var COMBO6 $GH_DEF_COMBO6
	var COMBO7 $GH_DEF_COMBO7
	var COMBO8 $GH_DEF_COMBO8
	counter set $GH_DEF_COUNTER
	var RANGED $GH_DEF_RANGED
	var SHIELD $GH_DEF_SHIELD
	var CURR_WEAPON $GH_DEF_WEAPON
	var WEAPON_EXP $GH_DEF_WEAPON_EXP
	echo
	echo Ready to go!
	echo
	var LAST DEF_WIELD_WEAPON
	DEF_WIELD_WEAPON:
			matchre SWAP_CHECK You draw|already holding|free to
			match BEGIN_HANDS free hand
			matchre DEF_REMOVE_WEAPON out of reach|remove|What were you|can't seem|Wield what\?
		put wield %CURR_WEAPON
		matchwait
	DEF_REMOVE_WEAPON:		
			matchre SWAP_CHECK You sling|already holding|inventory|You remove
			matchre BEGIN_HANDS free hand|hands are full
			match DEF_GET_WEAPON Remove what?
		put remove my %CURR_WEAPON
		matchwait
	DEF_GET_WEAPON:
			match SWAP_CHECK you get
			match NO_VALUE Please rephrase that command
		put get my %CURR_WEAPON
		matchwait
	SWAP_CHECK:
		if (("%HAND" = "left") && ("$lefthand" = "Empty")) then gosub SWAP_LEFT $righthandnound
		elseif ("%SHIELD" != "NONE") then gosub EQUIP_SHIELD %SHIELD
	goto %c
	
#####################################
##                                 ##
##  End of Initialization section  ##
##                                 ##
#####################################

ADVANCE:
	# echo
	# echo *** ADVANCE: ***
	# echo
	counter set %s
	ADV_NOW:
	var SKINNED NO
#		if (($hidden = 1) && ("%guild" = "Paladin")) then put unhid
		var LAST ADV_NOW
			match %LAST You can't do that while entangled in a web.
			matchre FACE You stop advancing|You have lost sight
			match NO_MONSTERS advance towards?
			matchre %c to melee range|\[You're|already at melee
		put advance
		matchwait

APPR_YES:
	var LAST APPR_NO
	if (("%DEAD" = "NO") && (("%ATTACK_APPR" != "YES") && ("%THROW_APPR" != "YES"))) then goto APPR_NO
	if ($Appraisal.LearningRate > 30) then goto APPR_NO
	# echo *** APPR_YES: ***
	if matchre("$monsterlist", "(%critters)") then goto APPR_CREEP
	goto NO_MONSTERS
	APPR_CREEP:
		var Monster $1
	APPRAISING:
		var LAST APPR_NO
			match %LAST You can't do that while entangled in a web.
			match DEAD_MONSTER It's dead!
			matchre APPR_NO Roundtime|Appraise|You can't determine|appraise|You don't see
		put appr %Monster quick
		matchwait
  
APPR_NO: 
	var GO_APP NO
	var HUNTING OFF
	if ("%DEAD" = "YES") then
	{
		var DEAD NO
		if (("%RANGED" = "OFF") && ("%BRAWLING" = "OFF")) then 
		{
			if (%c = 430) then counter subtract 30
			if (%c = 540) then counter subtract 40
			if (%c = 650) then counter subtract 50
			if (%c = 760) then counter subtract 60
			if (%c = 870) then counter subtract 70
			if ("$GH_GROUP_HUNT" = "ON") then
			{
				echo ***
				echo *** GROUP HUNTING ***
				echo ***
				waitfor ATTACK CRITTER NOW
			}
		}
	}
	var lastdirection none
	if ("%ATTACK_APPR" = "YES") then
	{
		var ATTACK_APPR NO
		goto ATTACK
	}
	if ("%THROW_APPR" = "YES") then
	{
		var THROW_APPR NO
		goto %c
	}
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
  if (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
  if (("%RANGED" = "ON") && ("%STACK" = "OFF") && ("%THROWN" = "OFF")) then goto RANGE_LOAD
	goto %c

FACE_1:
	var REMAINDER 0
	evalmath REMAINDER %c % 100
	if (%REMAINDER != 0) then counter subtract 10
	goto FACE
FACE_2:
	counter add 20
	goto FACE
FACE_3:
	counter add 30
	goto FACE
FACE_4:
	counter add 40
	goto FACE
FACE_5:
	counter add 50
	goto FACE
FACE_6:
	counter add 60
	goto FACE
FACE_7:
	counter add 70
	goto FACE
FACE_8:
	counter add 70
	goto FACE
FACE:
	# echo
	# echo *** FACE: ***
	# echo             
	gosub clear
	var ATTACK_APPR NO
	var THROW_APPR NO
	action remove eval $monstercount > 0
	if (("$righthandnoun" = "bundle") || ("$lefthandnoun" = "bundle")) then
	{
		gosub BUND_DROP
		gosub WIELD_WEAPON %CURR_WEAPON
		if (("%SHIELD" != "NONE") && ("%WORN" = "OFF")) then gosub EQUIP_SHIELD
	}
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
	var LAST FACE
		match %LAST You can't do that while entangled in a web.
		match FACE_RET You are too closely engaged
		matchre APPR_$GH_APPR You turn to face|You are already facing
		matchre CHECK_FOR_MONSTER nothing else to|Face what
	if ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "shalswar")) then put face shalswar
	elseif ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "sentinel")) then put face sentinel
	else put face next
	matchwait
	
FACE_RET:
	VAR LAST FACE_RET
		match %LAST You can't do that while entangled in a web.
		matchre FACE You retreat from combat|re already|You think|You sneak back
		matchre APPR_$GH_APPR You cannot back away from a chance to continue your slaughter|Roundtime
	put ret
	put ret
		matchwait
  
CHECK_FOR_MONSTER:
	# echo
	# echo *** CHECK_FOR_MONSTER ***
	# echo
	counter set %s
		match %LAST You can't do that while entangled in a web.
		match NO_MONSTERS advance towards?
		matchre FACE You stop advancing|You have lost sight
		matchre APPR_$GH_APPR begin|to melee range|You're|already at melee
	put advance
	matchwait

NO_MONSTERS:
	var LAST NO_MONSTERS
	gosub clear
	# echo
	# echo *** NO_MONSTERS: ***
	# echo
  gosub SPELLCHECKING
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
	if ((toupper("$GH_RECALL") = "ON") && ($Scholarship.LearningRate < 32)) then goto RECALL_STUFF
	if ((toupper("$GH_COLLECT") = "ON") && ($Perception.LearningRate < 32)) then goto collect.start
	if ("%RANGED" = "ON") then 
#  if "$GH_SORCERY" = "ON" then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
	{
		if (contains("$roomobjs", %AMMO)) then gosub RANGED_CLEAN			
		pause 3
		waitforre \.|\?|!|pole|melee|advance
		goto FACE 		
	} else
	{
		pause 3
		waitforre \.|\?|!|pole|melee|advance
		goto FACE 
	}

CAM_COMBAT:
if $mana < 10 then return
CAM_COMBAT_1:
if $Arcana.LearningRate > 32 then return
	var LAST CAM_COMBAT_1
	VAR CAMTYPE COMBAT_1
	match %LAST You can't do that while entangled in a web.
	matchre CAM_COMBAT_1 \.\.\.wait|absorbs
	matchre CAM_INVOKE dissipates|cannot harness
	matchre CAMB_COMBAT_OFF Something in the area|Something is damping
	put charge my %cambrinth 26
	matchwait 2
	goto CAM_COMBAT_1

CAM_INVOKE:
	var LAST CAM_INVOKE
	match %LAST You can't do that while entangled in a web.
	match CAM_INVOKE ...wait
	matchre return You reach for its center and forge a magical link to it|Your link.*is intact
	matchre return Something in the area|Something is damping
	put invoke my $cambrinth cyclic
	matchwait 2
	goto CAM_INVOKE

CAM_COMBAT_OFF:
	put #var GH_CAMB OFF
	return

SPELLCHECKING:
  put #var GH_NOHUNT 1
  if (("$GH_BUFF" = "ON") && ("$GH_CYCLIC" = "OFF") && ($spell_$GH_BUFF_SPELL_isactive = 0)) then
  {
    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
    waitfor Spell Cast
  }
  if $spell_drum_isactive = 0 then
  {
    put .cast drum 10 48
    waitfor Spell Cast
  }
  if $spell_harmony_isactive = 0 then
  {
    put .cast harmony 10 48
    waitfor Spell Cast
  }
  if $spell_name_isactive = 0 then
  {
    put .cast name 10 48
    waitfor Spell Cast
  }
  if $spell_rage_isactive = 0 then
  {
    put .cast rage 10 48
    waitfor Spell Cast
  }
#  if $spell_lw_isactive = 0 then
#  {
#    if (%SORC_PREPPED = 1) && (%SORC_READY = 0)) then
#    {
#      pause 0.5
#      action (sorc) off 
#      var SORC_READY 0
#      var SORC_PREPPED 0
#      put release spell
#    }
#    put .cast lw 10 48
#    waitfor Spell Cast
#  }
#  if $GH_SORCERY = "ON" then 
#  {
#    if ((%SORC_PREPPED = 0) && ($Sorcery.LearningRate < 34)) then gosub SORC_PREP
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
  put #var GH_NOHUNT 0
  return

PREP_CYCLIC_WAIT:
pause 10
PREP_CYCLIC:
  put #var GH_NOHUNT 1
  if (%SORC_PREPPED = 1) then
  {
    if %SORC_READY = 1 then gosub SORC_CAST
    else
    {
      pause 0.5
      action (sorc) off 
      var SORC_READY 0
      var SORC_PREPPED 0
      put release spell
    }
  }
  put rel cyclic
  var SPELLTYPE CYCLIC
	matchre PREP_WAIT You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
	match PREP_CYCLIC_WAIT have to strain
	put prep $1 $2 $3
	matchwait 5
	goto PREP_CYCLIC
	
PREP_SPELL:
  if (%SORC_PREPPED = 1) then
  {
    if %SORC_READY = 1 then gosub SORC_CAST
    else
    {
      pause 0.5
      action (sorc) off 
      var SORC_READY 0
      var SORC_PREPPED 0
      put release spell
    }
  }
  var SPELLTYPE SPELL
  var LAST PREP_SPELL
  	match %LAST You can't do that while entangled in a web.
  	matchre PREP_CAMB You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
	match PREP_RETURN have to strain
	put prep $1 $2 $3
	matchwait 5
	goto PREP_SPELL

PREP_CAMB:
if $mana < 20 then
  {
    pause 5
    goto PREP_CAMB
  }
PREP_CAMB_1:
	var LAST PREP_CAMB_1
	match %LAST You can't do that while entangled in a web.
	matchre PREP_CAMB_1 \.\.\.wait
	matchre PREP_CAM_INVOKE absorbs|dissipates|cannot harness
	matchre PREP_WAIT Something in the area|Something is damping
	put charge my $cambrinth_spell 48
	matchwait 2
	goto CAM_COMBAT_1

PREP_CAM_INVOKE:
	var LAST PREP_CAM_INVOKE
	match %LAST You can't do that while entangled in a web.
	match CAM_INVOKE ...wait
	matchre PREP_WAIT You reach for its center and forge a magical link to it|Your link.*is intact
	matchre PREP_WAIT Something in the area|Something is damping
	put invoke my $cambrinth_spell spell
	matchwait 2
	goto CAM_INVOKE

PREP_WAIT:
	var LAST PREP_WAIT
		match %LAST You can't do that while entangled in a web.
		matchre PREP_CAST You feel fully prepared to cast your spell|The formation of the target pattern around
		matchre PREP_RELEASE patterns dissipate|pattern dissipates 
	matchwait 35
	goto PREP_CAST	

PREP_CAST:
	var LAST PREP_CAST
		match %LAST You can't do that while entangled in a web.
		matchre PREP_RETURN You gesture|Your voice settles into slow, rich tones|The gentle notes of Blessing of the Fae waft from you with delicate ease, riddled with low tones that gradually give way to a higher-pitched theme|Low, hummed tones form a soft backdrop for the Eye of Kertigen|With a resounding \"POP\" like the cork from a bottle of effervescent bubbly, a spirited melody suddenly fills the area around you with palpable bands of audible color|A gently glittering series of colored lights appear in the air, winking in and out of existence with your performance of \"Nexus\"|You weave a soft melody, the notes so light and airy they can barely be heard|You softly voice your spell, gradually growing louder as the intricate pattern for Albreda's Balm forms more solidly in your mind|Though softly humming at first, you soon allow your voice to dance along the darkly melodic introduction to Abandoned Heart|Imagination blooms within you as you feel a sudden yearning to create|You chant a mesmerizing cadence designed to improve the study skills of those around you|A soft, rapid melody builds inside your mind as you create a call and response form around it|Your blood rises as images of ferocious battles play across your mind|Energy explodes from you, forming concentric rings of tangible sound of that sweep through the area like the fading ripples in a pond|You feel yourself swaying to an internal beat that hums with the natural rhythm of nature itself as the magic of \"Drums of the Snake\" begins to flow through you|The spell leaves you oddly moved, as though a sublime utterance is within your grasp, yet not easily expressed|With a power that seems to come from deep within yourself, staccato notes rip fiercely through the air|A gentle arpeggio of the enchante's opening notes segues into a softly melodic introduction of Hodierna's Lilt|As the pattern grips you, you are filled with resolve to stand fast and strong against all that assails you|You close your eyes briefly, focusing on the dull thumping of your own heart|With a sharp cut to your voice, you chant the rhythm that heralds the introduction to Caress of the Sun|With a harsh rasp to your voice, you sing the opening passages to the \"Desert's Maelstrom\"|In a low tone you begin your chant, as your voice grows you begin to thread it with traces of Fire which quickly agitate the air about you, causing it to warm almost painfully|As the pattern grips you, you are filled with resolve to stand fast and strong against all that assails you|You relax your eyes in order to focus on the trace amounts of Fire that warm you and the world around you\.
		matchre PREP_RELEASE because your target is dead|patterns dissipate|pattern dissipates because
		match PREP_FACE on yourself!
		matchre PREP_%SPELLTYPE You don't have a spell prepared|backfire
	put cast %casttype
	matchwait 5
	goto PREP_CAST

PREP_RELEASE:
	var PREP_RELEASE
		match %LAST You can't do that while entangled in a web.
  		matchre PREP_RETURN RELEASE HELP|energies dissipate|preparing a spell|You release
  	if matchre("%SPELLTYPE" , "CYCLIC|SPELL|MANA") then put release SPELL
	else put release all
	matchwait 5
  	goto PREP_RELEASE
  
PREP_RETURN:
  return


SORC_PREP:
  if $mana < 40 then return
  	matchre SORC_RETURN You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
	match RETURN have to strain
  match SORC_CAST You have already fully prepared
	put prep $GH_SORC_SPELL $GH_SORC_MANA
	matchwait 5
	goto SORC_PREP  

SORC_RETURN:
  var SORC_PREPPED 1
  action (sorc) on
  return

SORC_WAIT:
		matchre SORC_CAST You feel fully prepared to cast your spell|The formation of the target pattern around
		matchre SORC_RELEASE patterns dissipate|pattern dissipates 
	matchwait 20
	goto SORC_CAST	

SORC_CAST:
    action (sorc) off 
		matchre SORC_CAST_RETURN You gesture|You lift your right hand, forming your fingers into the shape of a vulture's talons.|You don't have a spell prepared
		matchre SORC_RELEASE because your target is dead|patterns dissipate|pattern dissipates because
	put cast $GH_SORC_CASTING
	matchwait 5
	goto SORC_CAST

SORC_RELEASE:
  pause 0.5
  action (sorc) off 
  put release spell
  goto SORC_CAST_RETURN

SORC_CAST_RETURN:
  var SORC_PREPPED 0
  var SORC_READY 0
  return

		RECALL_STUFF:
		if %recall_type > 2 then var recall_type 0
		var recall_current %recalls(%recall_type)
		gosub recall_%recall_current
		evalmath recall_type (%recall_type + 1)
		pause
		goto FACE

		recall_immortal:
			pause 0.5
			random 1 39
			gosub immortal-%r
			return

#		recall_famous:
#			pause 0.5
#			random 1 42
#			gosub famous-%r
#			return

		recall_holiday:
			pause 0.5
			random 1 21
			gosub holiday-%r
			return

		recall_herb:
			pause 0.5
			random 1 19
			gosub herb-%r
			return

	goto origami.fold

collect.start:
	var LAST collect.start
	action goto collect.done when ^\*.*at you\..*You|begins to advance on you|to melee range|to polee range|You're|already at melee|begins to focus on you
	put .collect
	waitfor Script Done	

collect.done:
	var LAST collect.done
	put #script abort collect
	action remove ^\*.*at you\..*You|begins to advance on you|to melee range|to polee range|You're|already at melee|begins to focus on you
	put kick rock;kick dust bunnies
	goto FACE

BOB_CHECK:
	if (%BOBCOUNTER >= 4) then gosub BOBBING
	else evalmath BOBCOUNTER (%BOBCOUNTER + 1)
	return

BOBBING:
    var BOBCOUNTER 0
		matchre BOBBING ^\.\.\.wait|^Sorry, you may only type|I could not find what you were referring to
		matchre RETURN Roundtime|At what are you trying to|You aren't close enough to attack|^There is nothing else to face\!|^What are you trying to attack\?|You must be closer to use tactical abilities on your opponent.
	put weave
		matchwait 5
		goto BOBBING

PARRYING:
		matchre PARRYING ^\.\.\.wait|^Sorry, you may only type|I could not find what you were referring to
		matchre RETURN Roundtime|You are already
	put bob
		matchwait

BUND_GET:
	if (contains("$roomobjs", "lumpy bundle")) then
	{
			match BUND_GET You pick up
		put get bun
		matchwait
	}
	else return

BUND_DROP:
	if (("$righthandnoun" = "bundle") || ("$lefthandnoun" = "bundle")) then
	{
			match BUND_DROP You drop
		put drop bun
		matchwait
	}
	else return
	

RETREAT_TRIGGERS:
	var RETREATING ON
	action send 1 ret;send 1 ret when (^\*.*at you\..*You)|(closes to melee range on you)
	action send 1 ret when closes to pole weapon range
	action put #queue clear when You retreat from combat
	action put #queue clear when You try to back away
	return

RETREAT_UNTRIGGERS:
	var RETREATING OFF
	action remove (^\*.*at you\..*You)|(closes to melee range on you)
	action remove closes to pole weapon range
	action remove You retreat from combat
	action remove You try to back away
	return
  
######################################
###                                ###
### This section is for the 5 move ###
### weapon attack COMBO            ###
###                                ###
######################################
COMBO5_1:
500:
  put #var GH_NOHUNT 0
  if (("$GH_BUFF" = "ON") && ("$GH_CYCLIC" = "OFF") && ($spell_$GH_BUFF_SPELL_isactive = 0)) then
  {
    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
    waitfor Spell Cast
  }
	if $GH_SETUP = 1 then put #var GH_SETUP 0
	var LAST COMBO5_1
	counter add 10
	save 500
	if (("$GH_BOB" = "ON") && ("$GH_AMBUSH" = "OFF") && ($Tactics.LearningRate < 34)) then var COMMAND weave
	else var COMMAND %COMBO1 %HAND
	goto COMBAT_COMMAND
COMBO5_2:
510:
	var LAST COMBO5_2
	counter add 10
	save 510
	var COMMAND %COMBO2 %HAND
	goto COMBAT_COMMAND
COMBO5_3:
520:
	var LAST COMBO5_3
	counter add 10
	save 520
	var COMMAND %COMBO3 %HAND
	goto COMBAT_COMMAND
COMBO5_4:
530:
	var LAST COMBO5_4
	counter add 10
	save 530
	var COMMAND %COMBO4 %HAND
	goto COMBAT_COMMAND
COMBO5_5:
540:
	var LAST COMBO5_5
	counter subtract 40
	save 540
	var COMMAND %COMBO5 %HAND
	goto COMBAT_COMMAND
550:
	counter set 500
	goto 500
  
##############################
COMBAT_COMMAND:
	if (toupper("$GH_TRAIN") = "ON") then gosub EXPCHECKING
	CAM_COMMAND:
	gosub clear
	var LAST CAM_COMMAND
	if (((%s = 400) || (%s = 500) || (%s = 600) || (%s = 700) || (%s = 800)) && (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
	if (((%s = 400) || (%s = 500) || (%s = 600) || (%s = 700) || (%s = 800)) && ($GH_AMBUSH = "ON")) then goto %c
	else
	{
		if ($GH_AMBUSH = "ON") then counter add 1
		var NEXT %c
	}
	if (%c = 540) then var FACE_NUM 4
	elseif (%c = 650) then var FACE_NUM 5
	elseif (%c = 760) then var FACE_NUM 6
	elseif (%c = 870) then var FACE_NUM 7
	elseif (%c = 440) then var FACE_NUM_2
	elseif (%c = 980) then var FACE_NUM_8
	else var FACE_NUM 1
	if ("$GH_SLOW" = "ON") then pause 2
#	if (((%c = 430) || (%c = 530) || (%c = 630) || (%c = 730) || (%c = 830)) && ("$GH_APPR" = "YES") && ($Appraisal.LearningRate <= 30)) then
#	{
#		var ATTACK_APPR YES
#		goto APPR_YES
#	}
#	if (((%c = 430) || (%c = 530) || (%c = 630) || (%c = 730) || (%c = 830)) && ("$GH_BOB" = "ON")) then gosub BOB_CHECK
#  if "$GH_SORCERY" = "ON" then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
ATTACK:
  if $stamina < 85 then pause 2
	var LAST ATTACK
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then 
	{
		if ("%SKINNED" = "NO") && ("$GH_GROUP_HUNT" = "OFF") then goto DEAD_MONSTER
    else var SKINNED NO
	}
	if ("%COMMAND" = "weave") then var LAST %NEXT
		matchre %LAST I could not find what you were referring to|You can\'t do that while entangled in a web\.
		matchre FLYING_MONSTER flying far too high to|flying too high for you
		matchre %NEXT You are already in a position|But you are already dodging|You move into a position to|Roundtime|You must be closer to use tactical abilities on your opponent.
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		match ADVANCE aren't close enough
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead|pointlessly hack
		match FACE_%FACE_NUM nothing else
	if ("$GH_AMBUSH" = "ON") then
	{
		put %COMMAND
		matchwait 10
		goto ATTACK
	}
	else
	{
		if (("%COMMAND" = "weave") || ("%COMMAND" = "circle") || ("%COMMAND" = "bob")) then 
		{
			var SKINNED NO
			put %COMMAND
			matchwait 10
			goto ATTACK
		}
		else
		{
#      if ("%HAND" = "left") then put %COMMAND left
			put %COMMAND $GH_TARGET
			matchwait 10
			goto ATTACK
		}
	}

FLYING_MONSTER:
	echo
	echo ***  Monster is flying, trying attack again ***
	echo
	put #play abort
	pause 0.5
	put swap
	pause 0.5
	put wield right my mallet;throw
	pause
	put swap;stow mallet
	pause 0.5
	goto ATTACK
	
  
#########################################
###                                   ###
### This section is for ranged combat ###
###                                   ###
#########################################
1000:
  if (("$GH_BUFF" = "ON") && ("$GH_CYCLIC" = "OFF") && ($spell_$GH_BUFF_SPELL_isactive = 0))  then
  {
    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
    waitfor Spell Cast
  }
	if $GH_SETUP = 1 then put #var GH_SETUP 0
#put #var GH_NOHUNT 1
put open my %QUIVER
if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT <= $monstercount) && ("%RETREATING" = "OFF") && ("%FIRE_TYPE" != "POACH")) then gosub RETREAT_TRIGGERS
if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT > $monstercount) && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
RANGE_DODGE:
	var LAST RANGE_DODGE
		match %LAST You can't do that while entangled in a web.
		if ("%REPEATING" = "ON") then matchre RANGE_REPEAT_CHECK already dodging|You move into a position to dodge
		else matchre RANGE_LOAD already dodging|You move into a position to dodge
	put dodge
	matchwait 5
	goto RANGE_DODGE

RANGE_REPEAT_CHECK:
		match RANGE_LOAD no more bolts
		match RANGE_REPEAT_LOAD Designed to hold multiple bolts ready for firing
	put look my cross
	matchwait 3
	goto RANGE_REPEAT_CHECK

RANGE_REPEAT_LOAD:
#	put #var GH_NOHUNT 1
	var LAST RANGE_REPEAT_LOAD
	if matchre("$lefthand", "%AMMO|basilisk head arrow") then put stow my %AMMO
	if matchre("$roomobjs", "\b%AMMO\b|basilisk head arrow") then
	{
		pause 0.5
		put stow %AMMO
		goto RANGE_REPEAT_LOAD
	}
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
			matchre RANGE_REPEAT_LOAD Roundtime|You carefully load|must be in your inventory to be loaded
			matchre R_GET You must|your hand jams|readily available|You can not load
			matchre RANGE_LOAD already loaded with as much ammunition as it can hold|What weapon are you trying to load
		put load %AMMO
		matchwait 15
		goto RANGE_REPEAT_LOAD
	
1010:
RANGEEXP_OFF:
RANGE_LOAD:
	put #var GH_NOHUNT 0
	var LAST RANGE_LOAD
	if matchre("$roomobjs", "\b%AMMO\b|basilisk head arrow|thin steel-tip bolt") then
	{
		pause 0.5
		put stow %AMMO
		goto RANGE_LOAD
	}
#  if "$GH_SORCERY" = "ON" then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
	if ("%REPEATING" != "ON") then put get %AMMO
	if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT <= $monstercount) && ("%RETREATING" = "OFF") && ("%FIRE_TYPE" != "POACH")) then gosub RETREAT_TRIGGERS
	if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT > $monstercount) && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
	counter set 1010
	save 1010
	if (toupper("$GH_TRAIN") = "ON") then gosub EXPCHECKING
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then 
#	if "%FIRETYPE" = "FIRE" && ("%SHIELD" = "NONE" || ("%SHIELD" != "NONE" && "%WORN" = "ON")) then put get %AMMO
	if ("%REPEATING" = "ON") then
	{
			match %LAST You can't do that while entangled in a web.
			match RANGE_LOAD must be in your inventory to be loaded 
			matchre RANGE_AIM A rapid series of clicks emanate|readying more than one bolt|Roundtime
			match RANGE_REPEAT_LOAD a sharp click signals that you've exhausted
		put push my cross
		matchwait 8
		goto RANGE_LOAD
	}
	else
	{
			match %LAST You can't do that while entangled in a web.
			matchre RANGE_AIM Roundtime|is already|You must unload
			matchre RANGE_GET You must|your hand jams|readily available|You can not load|What weapon are you trying to load
			matchre RANGE_REMOVE_CHECK (\w+) makes the task more difficult|while wearing a (.+)|while wearing an (.+)
		put load my %AMMO
		matchwait 15
		goto RANGE_LOAD
	}
	
RANGE_RETREAT:
	var LAST RANGE_RETREAT
	if matchre("$lefthand", "%AMMO|basilisk head arrow") then put stow my %AMMO
	if (toupper("$GH_RETREAT") = "OFF") then goto RANGE_AIM	
		match %LAST You can't do that while entangled in a web.
		matchre PAUSE stop advancing|\[You're
		match RANGE_FIRE best shot possible now
		matchre RANGE_AIM You cannot back away from a chance to continue your slaughter|You retreat from combat|re already|You think|Roundtime|You sneak back
	put ret
	put ret
	matchwait
	
RANGE_AIM:
#	put #var GH_NOHUNT 1
	var LAST RANGE_AIM
	if matchre("$roomobjs", "\b%AMMO\b|basilisk head arrow|thin steel-tip bolt") then
	{
		pause 0.5
		put stow %AMMO
		goto RANGE_AIM
	}
	gosub clear
	if matchre("$lefthand", "%AMMO|basilisk head arrow|thin steel-tip bolt") then put stow my %AMMO
	action goto RANGE_TRIGGER_FIRE when you have your best shot
		matchre %LAST I could not find what you were referring to
		match %LAST You can't do that while entangled in a web.
		match RANGE_LOAD isn't loaded
		match RANGE_FIRE best shot possible now
		match FACE There is nothing
		if ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "damaska boar")) then matchre SLING_FACE ^You begin to target a black goblin\.
		elseif ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "sentinel")) then matchre SLING_FACE ^You begin to target a Dragon Priest zealot\.
		matchre POACH_CHECK already targetting|begin to target
	put aim
	matchwait 15
	goto RANGE_TRIGGER_FIRE

SLING_FACE:
	put ret;ret
	matchre POACH_CHECK already targetting|begin to target|You shift your target to
	match POACH_CHECK You can't do that while entangled in a web.
	if ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "damaska boar")) then put face boar;aim boar
	elseif ("%WEAPON_EXP" = "Slings" && matchre("$monsterlist", "sentinel")) then put face sentinel;aim sentinel
	else put aim
	matchwait 5
	goto SLING_FACE

POACH_CHECK:
	if ("%FIRETYPE" = "POACH") then goto RANGE_HIDE
RANGE_AIM_FIRE:
	if (toupper("$GH_SNAP") = "ON") then
	{
		if ($GH_SNAP_PAUSE = 0) then goto RANGE_FIRE
		if ($GH_SNAP_PAUSE = 1) then goto RANGE_SNAP_1
		else
		{
				match RANGE_SNAP_1 You can't do that while entangled in a web.
				match RANGE_FIRE best shot possible now
				match RANGE_SNAP_1 Roundtime
				match RANGE_AIM stop concentrating on aiming
			put weave
			matchwait
		}
	}
		match RANGE_FIRE best shot possible now
#		match RANGE_RETREAT melee range on you  
		matchre RANGE_AIM stop concentrating on aiming|referring
		if ($Tactics.LearningRate < 34) then put weave;-1.5 circle
	matchwait	
1040:
RANGE_FIRE:
	var LAST RANGE_FIRE
	counter set 1040
	save 1040
		match %LAST You can't do that while entangled in a web.
		match RANGE_HIDE if you are not hidden?
		match RANGE_FIRE2 You can not poach
		matchre DEAD_MONSTER balance\]|balanced\]|isn't what you|already quite dead
		matchre RANGE_AIM what are you trying|referring
		matchre RANGEEXP_$GH_TRAIN isn't loaded|Roundtime
	put %FIRETYPE $GH_TARGET
	matchwait 5
	goto RANGE_FIRE

RANGE_FIRE2:
	var LAST RANGE_FIRE2
		match %LAST You can't do that while entangled in a web.
		match RANGE_HIDE if you are not hidden?	
		matchre DEAD_MONSTER balance\]|balanced\]|isn't what you|already quite dead
		matchre RANGE_AIM what are you trying|referring
		matchre RANGEEXP_$GH_TRAIN isn't loaded|Roundtime
	put fire $GH_TARGET
	matchwait 5
	goto RANGE_FIRE2

RANGE_TRIGGER_FIRE:
	action remove you have your best shot
	pause 0.1
	goto RANGE_FIRE

RANGE_SNAP_1:
	match RANGE_TRIGGER_FIRE You can't do that while entangled in a web.
	match RANGE_FIRE best shot possible now
	match RANGE_TRIGGER_FIRE Roundtime
	matchre RANGE_AIM stop concentrating on aiming|referring
	put bob
matchwait 5
goto RANGE_TRIGGER_FIRE



1140:
RANGE_HIDE:
	action goto RANGE_TRIGGER_FIRE when you have your best shot
	if ("%guild" = "Thief") then goto RANGE_STALK
	var LAST RANGE_HIDE
	counter set 1140
	save 1140
		match RANGE_HIDE fail
		matchre RANGE_RETREAT You are too close|notices|reveals
		matchre RANGE_STALK You melt|You blend|Eh\?
	put hide
	matchwait

1150:
RANGE_STALK:
	var LAST RANGE_STALK
	counter set 1150
	save 1150
		matchre RANGE_FIRE reveals|try being out of sight
		matchre RANGE_AIM_FIRE You move into position|You are already stalking
		match RANGE_HIDE trying to stalk
		match RANGE_STALK You think
		match DEAD_MONSTER nothing else
		match RANGE_AIM stop concentrating on aiming
		match FACE Stalk what?
	put stalk
	matchwait

RANGE_GET:
	var LAST RANGE_GET
		match %LAST You can't do that while entangled in a web.
		match NO_AMMO What were you
		match DEAD_MONSTER You pull
		matchre RANGE_GET You pick up|You put
		if ("%REPEATING" = "ON") then matchre RANGE_REPEAT_LOAD Stow what|You must unload|You get some
		else matchre RANGE_LOAD Stow what|You must unload|You get some
	put get %AMMO
	put stow %AMMO in my %QUIVER
	matchwait

RANGE_REMOVE_CHECK:
	put stow %AMMO
	pause 0.5
	action remove you have your best shot
	if matchre("$0", "shield|buckler|pavise|heater|kwarf|sipar|lid") then goto RANGE_REMOVE
	if matchre("$0", "targe") then goto RANGE_REMOVE
	goto ERROR
RANGE_REMOVE:
	var LAST RANGE_REMOVE
	put stow %AMMO
	pause 0.5
	var REM_SHIELD $0
	counter set %s
		match %LAST You can't do that while entangled in a web.
		matchre RANGE_STOW You loosen the straps securing|You aren't wearing that\.
		match ERROR Remove what?
	put remove my %REM_SHIELD
	matchwait

RANGE_STOW:
	var LAST RANGE_STOW
		match %LAST You can't do that while entangled in a web.
		match ERROR Stow What?
		match RANGE_ADJUST too 
		match %c You put
	put stow my %REM_SHIELD
	matchwait
RANGE_ADJUST:
		match %LAST You can't do that while entangled in a web.
		match %c you sling
		matchre ERROR through the straps|You can't wear any more items like that
	put adj my %REM_SHIELD
	put wear my %REM_SHIELD
	matchwait
  
RANGE_DEAD:
	action remove you have your best shot
	var LAST RANGE_DEAD
	save 1010
	counter set 1010
		match %LAST You can't do that while entangled in a web.
		matchre PAUSE Roundtime|\[You're
		matchre DEAD_MONSTER You cannot back away from a chance to continue your slaughter|You retreat from combat|already as far|You sneak back
	put ret
	put ret
	matchwait
	
R_BRAWL_1:
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	var LAST R_BRAWL_1
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		match R_BRAWL_2 re Roundtime
		match R_GET_WEAPON comes free and falls to the ground.
	put bob
	matchwait

R_BRAWL_2:
	var LAST R_BRAWL_2
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre R_ADVANCE aren't close enough to attack\.|aren't close enough to do that\!
		matchre DEAD_MONSTER balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		match R_BRAWL_3 Roundtime
		match R_GET_WEAPON comes free and falls to the ground.
	put gouge
	matchwait

R_BRAWL_3:
	var LAST R_BRAWL_3
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre R_ADVANCE aren't close enough to attack\.|aren't close enough to do that\!
		matchre DEAD_MONSTER balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		match R_BRAWL_4 Roundtime
		match R_GET_WEAPON comes free and falls to the ground.
	put claw
	matchwait

R_BRAWL_4:
	var LAST R_BRAWL_4
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre R_ADVANCE aren't close enough to attack\.|aren't close enough to do that!
		matchre DEAD_MONSTER balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		match R_BRAWL_5 Roundtime
		match R_GET_WEAPON comes free and falls to the ground.
	put elbow
	matchwait

R_BRAWL_5:
	var LAST R_BRAWL_5
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre R_ADVANCE aren't close enough to attack\.|aren't close enough to do that!
		matchre DEAD_MONSTER balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		match R_BRAWL_1 Roundtime
		match R_GET_WEAPON comes free and falls to the ground.
	put jab
	matchwait

R_GET_WEAPON:
	var LAST R_GET_WEAPON
		match %LAST You can't do that while entangled in a web.
		matchre R_GET_WEAPON comes free and falls to the ground
		matchre 1000 already|You get|You pull|You pick|You need a free hand to
		match R_BRAWL_1 What were you
	put get %AMMO
	matchwait

R_ADVANCE:
	if (($hidden = 1) && ("%guild" = "Paladin")) then put unhid
		matchre R_ADVANCE You stop advancing|You have lost sight
		match R_GET_WEAPON advance towards?
		matchre %LAST to melee range|\[You're|already at melee
		match %LAST You can't do that while entangled in a web.
	put advance
	matchwait

R_FACE:
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
		match R_ADVANCE You turn to face
		matchre R_GET_WEAPON nothing else to|Face what
	put face next
	matchwait
	
RANGEEXP_ON:
	counter set 1010
	goto EXPCHECK_ON
  
NO_AMMO:
	action remove you have your best shot
	echo
	echo *** No more ammo, stopping script ***
	echo
	if (("%SHIELD" != "NONE") && ("%WORN" = "OFF")) then
	{
		gosub UNEQUIP_SHIELD
	}
	gosub RANGE_SHEATHE
	goto DONE
  
######################################
###                                ###
### This section is for throwing   ###
###                                ###
######################################
1200:
  if (("$GH_BUFF" = "ON") && ("$GH_CYCLIC" = "OFF") && ($spell_$GH_BUFF_SPELL_isactive = 0))  then
  {
    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
    waitfor Spell Cast
  }
	if $GH_SETUP = 1 then put #var GH_SETUP 0
if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
if (toupper("$GH_RETREAT") = "OFF") then put advance
THROWN_DODGE:
	var LAST THROWN_DODGE
	counter set 1210
	save 1200
		match %LAST You can't do that while entangled in a web.
		matchre PAUSE Roundtime|\[You're
		matchre %c already dodging|You move into a position to dodge
	put dodge
	matchwait
1210:
  put #var GH_NOHUNT 0
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
THROWN_THROW:
	THROWNEXP_OFF:
	var LAST THROWN_THROW
#  if "$GH_SORCERY" = "ON" then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
	if (("$GH_CAMB" = "ON") && (($cam_slipped = 1) || ($cam_leeched = 1)) then gosub CAM_COMBAT
	counter set 1220
	save 1210
	if (toupper("$GH_TRAIN") = "ON") then gosub EXPCHECKING
	gosub clear
	if ("%HAND" = "left") && ("$lefthand" = "Empty") then goto %c
	elseif ("%HAND" = "") && ("$righthand" = "Empty") then goto %c
	if ("$GH_BOB" = "ON") then gosub BOB_CHECK
	if ("$GH_SLOW" = "ON") then pause 2
		match %LAST You can't do that while entangled in a web.
		matchre %c You are already in a position|But you are already dodging|You move into a position to|Roundtime|pointlessly hack|What are you trying to throw|I could not find what you were referring to
		matchre THROWN_FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		matchre ADVANCE aren't close enough
		matchre THROW_DEAD balanced\]|balance\]|already dead|very dead
		matchre FACE_1 nothing else
	put throw %HAND $GH_TARGET
	matchwait 4
	goto THROWN_THROW

1220:
	counter subtract 10
THROW_GET:
	var SKINNED NO
	var LAST THROW_GET
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then 
	{
		if ("%SKINNED" = "NO") && ("$GH_GROUP_HUNT" = "OFF") then goto DEAD_MONSTER
    else var SKINNED NO
	}
	if ("%HAND" = "left") && ("$lefthand" != "Empty") then goto %c
	elseif ("%HAND" = "") && ("$righthand" != "Empty") then goto %c
	if (toupper("$GH_TRAIN") = "ON") then
	{
		var NEXT TIMER_$GH_TIMER
	} else
	{
		var NEXT %c
	}
	if ("%STACK" = "ON") then goto THROW_GET_STACK
	save 1220
		if ("%HAND" = "left") then matchre THROW_SWAP You get|You pick up|you stealthily unsheathe|You pull|You are already holding that
		else matchre %NEXT already|You need a free hand to pick that up|You get|You pick up|you stealthily unsheathe|You pull
		matchre THROWN_GET_WEAPON What were you|it's still alive
		match %LAST You can't do that while entangled in a web.
	put get %CURR_WEAPON
	matchwait 2
	goto THROW_GET

THROW_GET_STACK:
	var LAST THROW_GET_STACK
	# stacks of blades can fill hands, so empty the non-throwing hand here
	gosub clear
	if (toupper("$GH_TRAIN") = "ON") then
	{
		var NEXT TIMER_$GH_TIMER
	} else
	{
		var NEXT %c
	}
#	if (("$GH_APPR" = "YES") && ($Appraisal.LearningRate <= 30)) then
#	{
#		var THROW_APPR YES
#		var NEXT APPR_YES
#	}
		match %LAST You can't do that while entangled in a web.
		match THROW_GET_STACK_2 You pick up
		matchre THROW_SWAP You are already holding that|You need a free hand to pick that up|You get|you stealthily unsheathe
		match THROW_DEAD You pull
		matchre THROW_GET_STACK_2 What were you|it's still alive
	put get my %CURR_WEAPON
	matchwait 2
	goto THROW_GET_STACK

THROW_GET_STACK_2:
	var LAST THROW_GET_STACK_2
	if (("%HAND" = "left") && ("$lefthand" != "Empty")) then gosub swap_right %CURR_WEAPON
	put stow %CURR_WEAPON;stow %CURR_WEAPON
	pause 0.1
	match %LAST You can't do that while entangled in a web.
	match THROW_GET_STACK_2 You pick up
	if ("%HAND" = "left") then matchre THROW_SWAP You get|you stealthily unsheathe|You are already holding that
	else matchre %NEXT already|You need a free hand to pick that up|You get|you stealthily unsheathe
	match THROW_DEAD You pull
	matchre THROWN_GET_WEAPON What were you|it's still alive
put get %CURR_WEAPON
matchwait 2
goto THROW_GET_STACK_2
	

THROW_SWAP:
	if ("%HAND" = "left") then
	{
		if ("$lefthand" = "Empty") && ("$righthand" != "Empty") then gosub SWAP_LEFT %CURR_WEAPON
	}
	else
	{
		if ("$righthand" = "Empty") && ("$lefthand" != "Empty") then gosub SWAP_RIGHT %CURR_WEAPON
	}
	goto %NEXT
	
THROWN_GET_WEAPON:
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	echo
	echo *** Getting weapon back ***
	echo
	var LAST THROWN_GET_WEAPON
	counter set 1205
	put advance
1205:
T_BRAWL_1:
	var LAST T_BRAWL_1
	counter set 1215
	save 1205
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		match %c re already dodging
		matchre GET_WEAPON You move into a position to dodge|comes free and falls to the ground
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
	put dodge
	matchwait
1215:
T_BRAWL_2:
	var LAST T_BRAWL_2
	counter set 1225
	save 1215
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre ADVANCE aren't close enough to attack\.|aren't close enough to do that\!
		matchre THROW_DEAD balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		match %c Roundtime
		match GET_WEAPON comes free and falls to the ground.
	put gouge
	matchwait
1225:
T_BRAWL_3:
	var LAST T_BRAWL_3
	counter set 1235
	save 1225
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre ADVANCE aren't close enough to attack\.|aren't close enough to do that\!
		matchre THROW_DEAD balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		match %c Roundtime
		match GET_WEAPON comes free and falls to the ground.
	put claw
	matchwait
1235:
T_BRAWL_4:
	var LAST T_BRAWL_4
	counter set 1245
	save 1235
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre ADVANCE aren't close enough to attack\.|aren't close enough to do that!
		matchre THROW_DEAD balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		match %c Roundtime
		match GET_WEAPON comes free and falls to the ground.
	put elbow
	matchwait
1245:
T_BRAWL_5:
	var LAST T_BRAWL_5
	counter set 1205
	save 1245
		match %LAST You can't do that while entangled in a web.
		matchre %LAST I could not find what you were referring to
		matchre ADVANCE aren't close enough to attack\.|aren't close enough to do that!
		matchre THROW_DEAD balanced\]|balance\]|nothing else|you turn to face|already dead|very dead
		matchre FATIGUE You're beat,|You're exhausted|You're bone-tired|worn-out
		match %c Roundtime
		match GET_WEAPON comes free and falls to the ground.
	put jab
	matchwait
  
GET_WEAPON:
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	var LAST GET_WEAPON
		match %LAST You can't do that while entangled in a web.
		matchre GET_WEAPON comes free and falls to the ground
		matchre THROWN_THROW already|You get|You pull|You pick|You need a free hand to
		match %c What were you
	put get %CURR_WEAPON
	matchwait  
  
THROW_DEAD:
	var LAST THROW_DEAD
	save 1210
	counter set 1210
	if ("%STACK" = "ON" && "$lefthand" != "Empty" && ("%SHIELD" = "NONE" || "%WORN" = "ON")) then
	{
		put stow my %CURR_WEAPON
		put stow my %CURR_WEAPON
		pause 0.5
	}
	if ("%STACK" = "ON" && "$lefthand" != "Empty" && ("%SHIELD" != "NONE" || "%WORN" = "ON")) then 
	{
		put stow my %CURR_WEAPON
		pause 0.5
	}
		match %LAST You can't do that while entangled in a web.
		matchre THROW_DEAD ^That's your .* that was lodged in
		matchre DEAD_MONSTER already|You get|You pull|You pick|You need a free hand to|you stealthily unsheathe
		match THROWN_GET_WEAPON What were you
	put get %CURR_WEAPON
    matchwait 2
	goto THROW_DEAD

THROWNEXP_ON:
	counter set 1210
	goto EXPCHECK_ON

THROW_DEAD_SHEATH:
	var LAST THROW_DEAD_SHEATH
	gosub SHEATHE %CURR_WEAPON in %T_SHEATH
	goto THROW_DEAD

THROWN_RETREAT:
	var LAST THROWN_RETREAT
	counter set 1210
		match %LAST You can't do that while entangled in a web.
		matchre THROWN_RETREAT Roundtime|\[You're
		matchre %c You cannot back away from a chance to continue your slaughter|You retreat from combat|already as far|You sneak back
	put ret
	put ret
	matchwait

######################################
###                                ###
### This section is for sneaky     ###
### attacks: 					   ###
### ambushing and backstabbing     ###
###                                ###
######################################
401:
411:
421:
431:
441:
501:
511:
521:
531:
541:
601:
611:
621:
631:
641:
651:
701:
711:
721:
731:
741:
751:
761:
801:
811:
821:
831:
841:
851:
861:
871:
if $GH_SETUP = 1 then put #var GH_SETUP 0
AMBUSHING:
put #var GH_NOHUNT 1
	counter subtract 1
	goto HIDE

1300:
if $GH_SETUP = 1 then put #var GH_SETUP 0
BACKSTABBING:
put #var GH_NOHUNT 1
	var LAST BACKSTABBING
	counter set 1300
	save 1300
		matchre HIDE already in a position to parry|You move into a position to parry
	put parry
	matchwait
	
1310:
STABBITY:
	var LAST STABBITY
		matchre BS_ATTACK You can't backstab that\.|political
		matchre ADV_NOW help if you were closer|aren't close enough to attack|aren't close enough to do that
		matchre DEAD_MONSTER balanced\]|balance\]|already dead|very dead
		matchre FATIGUE \[You're beat,|\[You're exhausted|\[You're bone-tired
		match WEAPON_APP_ERROR Backstabbing is much more effective when you use a melee weapon
		match FACE nothing else
		if (toupper("$GH_TRAIN") = "ON") then match EXPCHECK_$GH_EXP Roundtime
		else match BACKSTABBING Roundtime
		match HIDE You must be hidden
		match BAD_WEAPON entirely unsuitable
	put backstab %HAND
	matchwait
	
BS_ATTACK:
	var LAST BS_ATTACK
		matchre ADV_NOW help if you were closer|aren't close enough to attack|aren't close enough to do that
		matchre SNEAKY_DEAD balanced\]|balance\]|already dead|very dead
		matchre FATIGUE \[You're beat,|\[You're exhausted|\[You're bone-tired
		match FACE nothing else
		if (toupper("$GH_TRAIN") = "ON") then match EXPCHECK_$GH_EXP Roundtime
		else match BACKSTABBING Roundtime
	put attack
	matchwait
	
HIDE:
	if ("%guild" = "Thief") then goto STALK
	HIDE_HIDE:
	if ($Stealth.LearningRate >= $stealthexp) then goto SWITCH_WEAPON
	if (%t > (%MAX_TRAIN_TIME)) then goto SWITCH_WEAPON
	var LAST HIDE
		match HIDE_HIDE fail
		matchre SNEAKY_RETREAT You are too close|notices|reveals
		matchre STALK You melt|You blend|Eh\?
	put hide
	matchwait

STALK:
	if ("%BACKSTAB" = "ON") then counter set 1310
	var LAST STALK
		matchre HIDE_HIDE reveals|discovers you|until they reveal your presence
		matchre STALK_ADV You move into position|already stalking
		matchre HIDE_HIDE trying to stalk|try being out of sight
		matchre STALK You think|You fail
		match FACE Stalk what?
	put stalk
	matchwait 5
	goto STALK

STALK_ADV:
	if $hidden = 1 then goto ADV_NOW
	else goto HIDE_HIDE

SNEAKY_RETREAT:
	var LAST SNEAKY_RETREAT
		matchre HIDE You cannot back away from a chance to continue your slaughter|You retreat|re already|You think|Roundtime|You sneak back|until they reveal your presence
		matchre SNEAKY_RETREAT stop advancing|\[You're
	put ret
	matchwait

SNEAKY_DEAD:
	if ("%BACKSTAB" = "ON") then
	{
		counter set 1300
		save 1300
	}
	goto DEAD_MONSTER

BAD_WEAPON:
	echo
	echo *** BAD_WEAPON: ***
	echo This weapon is not suitable for this type of attack, switching to regular combat
	echo
	counter set 0
	goto WEAPON_CHECK
	
######################################
###                                ###
### This section is for Magic      ###
###                                ###
######################################
2000:
2400:
2500:
2600:
2700:
2800:
3000:
3010:
3200:
	if $GH_SETUP = 1 then put #var GH_SETUP 0
save %c

MAGIC_PREP:
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
	if (toupper("$GH_RETREAT") = "OFF") then put advance
	if $mana < 15 then goto MAGIC_REGEN
	var LAST MAGIC_PREP
	var MAGIC_REL_NEXT MAGIC_PREP
	gosub EXPCHECKING
	gosub clear
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
#	{
#		if ("$GH_GROUP_HUNT" = "OFF") then goto DEAD_MONSTER
#	}
	var TARGETTED 0
	put #var GH_HARN_FLAG NO
	if ("%MAGIC_TYPE" = "TM") then matchre MAGIC_TARGET You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth
	else matchre MAGIC_WAIT You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth
		match MAGIC_COMBAT have to strain
	put prep $GH_SPELL $GH_MANA
	matchwait

MAGIC_REGEN:
  if ("$GH_BOB" = "ON") then gosub BOB_CHECK
	pause 2
	if $mana > 30 then goto MAGIC_PREP
	else goto MAGIC_REGEN

MAGIC_HARNESS1:
#	if ("$GH_CAMB" = "ON") then goto MAGIC_CAMB_HARNESS1
	var LAST MAGIC_HARNESS_DONE
	put #var GH_HARN_FLAG YES
		if ($GH_HARN2 != 0) then matchre MAGIC_HARNESS2 You tap into the mana from
		else matchre MAGIC_HARNESS_DONE You tap into the mana from
		matchre MAGIC_HARNESS_DONE You strain, but cannot harness
	put harness $GH_HARN1
	matchwait

MAGIC_HARNESS2:
	var LAST MAGIC_HARNESS_DONE
	put #var GH_HARN_FLAG YES
		if ($GH_HARN3 != 0) then matchre MAGIC_HARNESS3 You tap into the mana from
		else matchre MAGIC_HARNESS_DONE You tap into the mana from
		matchre MAGIC_HARNESS_DONE You strain, but cannot harness
	put harness $GH_HARN2
	matchwait

MAGIC_HARNESS3:
	var LAST MAGIC_HARNESS_DONE
	put #var GH_HARN_FLAG YES
		matchre MAGIC_HARNESS_DONE You tap into the mana from
		matchre MAGIC_HARNESS_DONE You strain, but cannot harness
	put harness $GH_HARN3
	matchwait

MAGIC_HARNESS_DONE:
	pause 0.1
	goto MAGIC_WAIT_CAST

MAGIC_CAMB_HARNESS1:
	var LAST MAGIC_CAMB_INVOKE
	put #var GH_HARN_FLAG YES
		if ($GH_HARN2 != 0) then matchre MAGIC_CAMB_HARNESS2 dissipates|absorbs|cannot harness
		else matchre MAGIC_CAMB_INVOKE dissipates|absorbs|cannot harness
		matchre MAGIC_CAMB_OFF Something in the area|Something is damping
	put charge my %cambrinth $GH_HARN1
	matchwait

MAGIC_CAMB_HARNESS2:
	var LAST MAGIC_CAMB_INVOKE
	put #var GH_HARN_FLAG YES
		if ($GH_HARN3 != 0) then matchre MAGIC_CAMB_HARNESS3 dissipates|absorbs|cannot harness
		matchre MAGIC_CAMB_INVOKE dissipates|absorbs|cannot harness
		matchre MAGIC_CAMB_OFF Something in the area|Something is damping
	put charge my %cambrinth $GH_HARN2
	matchwait

MAGIC_CAMB_HARNESS3:
	var LAST MAGIC_CAMB_INVOKE
	put #var GH_HARN_FLAG YES
		matchre MAGIC_CAMB_INVOKE dissipates|absorbs|cannot harness
		matchre MAGIC_CAMB_OFF Something in the area|Something is damping
	put charge my %cambrinth $GH_HARN3
	matchwait

MAGIC_CAMB_INVOKE:
	var LAST MAGIC_CAMB_INVOKE
	pause 0.1
	matchre MAGIC_HARNESS_DONE Roundtime|Your link.*is intact
	matchre MAGIC_CAMB_OFF Something in the area|Something is damping
	put invoke my %cambrinth
	matchwait 10
	goto MAGIC_WAIT_CAST

MAGIC_CAMB_OFF:
	put #var GH_CAMB OFF
	goto MAGIC_HARNESS_DONE

MAGIC_TARGET:
	var LAST MAGIC_TARGET
		matchre MAGIC_PREP You don't have a spell prepared|You must be preparing a spell in order to target it
		matchre MAGIC_FACE not engaged|I could not find what you were referring to
		matchre MAGIC_WAIT don't need to target|Your target pattern is already formed|You begin to weave mana lines into|Tiny tendrils of lightning jolt between your hands|You rock back and forth
		matchre MAGIC_REL patterns dissipate|pattern dissipates 
	put target
	matchwait

MAGIC_WAIT:
	action var TARGETTED 1 when You feel fully prepared to cast your spell|The formation of the target pattern around
	TM_BOB:
	var LAST TM_BOB_DONE
#	if (("$GH_APPR" = "YES") && ($Appraisal.LearningRate < 33)) then
#	{
#		if matchre("$monsterlist", "(%critters)") then var Monster $1
#		else goto TM_BOB_DONE
#		var Monster $1
#		var LAST TM_BOB_DONE
#			match DEAD_MONSTER It's dead!
#			matchre TM_BOB_APP_DONE Roundtime|Appraise|You can't determine|appraise|You don't see
#		put appr %Monster quick
#			matchwait 5
#	}
	TM_BOB_APP_DONE:
	if (("$GH_BOB" = "ON") && ($Brawling.LearningRate < 33)) then
	{
		matchre TM_BOB_DONE Roundtime|At what are you trying to
		put weave
		matchwait 2
	}
	if ((("$GH_APPR" = "OFF") || (("$GH_APPR" = "YES") && ($Appraisal.LearningRate > 32))) && (("$GH_BOB" = "OFF") || (("$GH_BOB" = "ON") && ($Tactics.LearningRate > 32))) then
	{
		var cambrinth $cambrinth
		put #var GH_HARN1 9
		goto MAGIC_CAMB_HARNESS1
	}
	TM_BOB_DONE:
	if (($GH_HARN1 != 0) && (toupper("$GH_HARN_FLAG") = "NO")) then goto MAGIC_HARNESS1
	goto MAGIC_WAIT_CAST

MAGIC_WAIT_CAST:
		if (%TARGETTED = 1) && ("%FULLTARGET" = "NO") then goto MAGIC_CAST
		if ("$GH_MSNAP" = "ON") then goto MAGIC_CAST
		matchre MAGIC_CAST You feel fully prepared to cast your spell|The formation of the target pattern around
		matchre MAGIC_REL patterns dissipate|pattern dissipates 
		matchre MAGIC_DEATH You gesture|You reach
	matchwait 15
	goto MAGIC_CAST

MAGIC_FACE:
	var LAST MAGIC_FACE
	var MAGIC_REL_NEXT NO_MONSTERS
	match MAGIC_TARGET You turn
	match MAGIC_REL There is nothing
put face next
	matchwait

MAGIC_CAST:
	var LAST MAGIC_CAST
	var MAGIC_REL_NEXT DEAD_MONSTER
	if ($GH_MSNAP_PAUSE > 0) then delay $GH_MSNAP_PAUSE
		matchre MAGIC_DEATH You gesture|You reach|Roundtime
		matchre MAGIC_REL because your target is dead|patterns dissipate|pattern dissipates because
		match MAGIC_COMBAT You are unable to harness
		match MAGIC_FACE on yourself!
		match MAGIC_PREP You don't
	put cast
	matchwait

MAGIC_REL:
	var LAST MAGIC_REL
	if ("%MAGIC" = "ON") then goto MAGIC_COMBAT
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then 
	{
		if ("$GH_GROUP_HUNT" = "OFF") then goto DEAD_MONSTER
	}
	put release all
	waitforre RELEASE HELP|energies dissipate|preparing a spell|You release
  goto %MAGIC_REL_NEXT

MAGIC_DEATH:
	var LAST MAGIC_DEATH
	if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then 
	{
		if ("$GH_GROUP_HUNT" = "OFF") then goto DEAD_MONSTER
	}
	if ("%MAGIC" = "ON") then goto MAGIC_COMBAT
	else goto EXPCHECK_$GH_TRAIN

MAGIC_COMBAT:
	# echo
	# echo *** MAGIC_COMBAT: ***
	# echo
	pause 0.5
	counter subtract 2000
	if ("%RETREATING" = "ON") then gosub RETREAT_UNTRIGGERS
	MAGIC_COMBAT_REL:
		var LAST MAGIC_COMBAT_REL
		put release all
		waitforre RELEASE HELP|energies dissipate|preparing a spell|You release
		goto %c

######################################
###                                ###
### End of Magics                  ###
###                                ###
######################################
  
RANGED_CLEAN:
	# echo
	# echo *** RANGED_CLEAN ***
	# echo
	if ((("%SHIELD" != "NONE") && ("%WORN" = "OFF")) && ("$lefthandnoun" = "%SHIELD")) then	
	{
		gosub RANGE_SHEATHE
	}
	var LAST RANGED_CLEAN
#	put retreat
	pause 0.5
		match %LAST You can't do that while entangled in a web.
		matchre RETURN You get some|You get a|You are already holding|You must unload|Stow what?|You stop as you realize the
		matchre RANGED_CLEAN You pick up|You pull|You put
	put stow %AMMO
	matchwait 2
	goto RANGED_CLEAN

THROWN_CLEAN:
	# echo
	# echo *** THROWN_CLEAN ***
	# echo
	var LAST THROWN_CLEAN
	var thrown_weapon $1
	if ("$GH_NOLODGE" = "OFF") then put stow my %thrown_weapon
#	put retreat
THROWN_CLEAN_2:
	pause 0.1
		match %LAST You can't do that while entangled in a web.
		match THROWN_CLEAN_SWAP You need to be holding
		match THROWN_CLEAN_3 That's too heavy to go in there!
		matchre THROWN_CLEAN_2 You pick up|You pull|You put|you stealthily sheathe|Sheathe what
		matchre RETURN You get some|You get a|You are already holding|Stow what|you stealthily unsheathe|You stop as you realize the|too long to fit|You can only|to fit in the
#	if ("$GH_NOLODGE" = "OFF") then put stow %thrown_weapon
#	else put stow %thrown_weapon
  put stow %thrown_weapon
 	matchwait 2
	goto THROWN_CLEAN_2
	
THROWN_CLEAN_3:
			match %LAST You can't do that while entangled in a web.
			matchre THROWN_CLEAN_3 Roundtime|\.\.\.wait|^Sorry, you may only type
			matchre RETURN You sheath|You strap|With a flick of your wrist|You hang|you sheath|Sheathe what?|You need to be holding the
		put shea %thrown_weapon
		matchwait 2
		goto THROWN_CLEAN_3

THROWN_CLEAN_SWAP:
	gosub SWAP_RIGHT %thrown_weapon
	goto THROWN_CLEAN_2

WEBBED:
	echo
	echo *** You have been webbed ***
	echo
	put #play abort
	waitforre move freely again|you break free|You escape from
	goto %LAST
	
STAND:
	pause 1;#play abort;#echo >Events Red KNOCKED DOWN
	echo
	echo *** Knocked down, standing back up ***
	echo
	var GO_BACK %LAST
STANDING:
		matchre STANDING cannot manage to stand|The weight of all your possessions|You can't do that while you are asleep.
		matchre %GO_BACK You stand|You are already standing
	put wake;stand
	matchwait
  
THROWN_FATIGUE:
	pause
	put get %CURR_WEAPON  
	waitforre You pick up|You get|You pull
FATIGUE:
	echo
	echo *** FATIGUE: ***
	echo
	var LAST FATIGUE
		match %LAST You can't do that while entangled in a web.
		matchre FATIGUE \[You're|You stop advancing
		match FATIGUE_CHECK You cannot back away from a chance to continue your slaughter!
		matchre FATIGUE_CHECK You retreat from combat|You sneak back|already as far
	put ret
	put ret
	matchwait

FATIGUE_CHECK:
	echo
	echo *** FATIGUE_CHECK: ***
	echo
	if ($stamina < 90) then
	{
		goto FATIGUE_WAIT
	} else
	{
		goto %c
	}

FATIGUE_WAIT:
	echo
	echo *** FATIGUE_WAIT: ***
	echo
		matchre FATIGUE You feel fully rested|melee|pole|\[You're
	matchwait

DEAD_MONSTER:
  if "%DEAD" = "YES" then
  {
    var DEAD NO
    pause 2
    goto EXPCHECK_OFF
  }
	put #var GH_NOHUNT 1
#  if "$GH_SORCERY" = "ON" then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#  }
	pause 0.5
	if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT > $monstercount) && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
	# echo
	echo *** DEAD_MONSTER: ***
	# echo
#	var LOCAL $GH_KILLS
	var DEAD YES
	math LOCAL add 1
#	put #var GH_KILLS %LOCAL
	if matchre("$roomobjs", "(%skinnablecritters|%skinnvasioncritters) ((which|that) appears dead|\(dead\))") then goto SKIN_MONSTER_$GH_SKIN
	if matchre("$roomobjs", "(%critters) ((which|that) appears dead|\(dead\))") then goto SEAR_MONSTER
	goto NO_MONSTER
 
SKIN_MONSTER_ON:
	var Monster $1
	if ("%RETREATING" = "ON") then
	{
		var SKINPOSTRET ON
		gosub RETREAT_UNTRIGGERS
	}
	#if ((toupper("$GH_RETREAT") = "ON") && ($GH_RETREAT_COUNT <= $monstercount) && ("%RETREATING" = "OFF")) then gosub RETREAT_TRIGGERS
SKIN_MONSTER:
	var LAST SKIN_MONSTER
	pause 1
	ARRANGE_CHECK:	
		var LAST PRE_SKIN
		if (toupper("$GH_ARRANGE") = "ON")) then goto ARRANGE_KILL
	PRE_SKIN:
	var LAST PRE_SKIN:
	if (("%STACK" = "ON") || ("%THROWN" = "ON")) then
	{
		pause
		gosub THROWN_CLEAN %CURR_WEAPON
		pause
	}
	if (("%SHIELD" != "NONE") && ("%WORN" = "OFF") && ("%CURR_WEAPON" != "")) then gosub SHEATHE %CURR_WEAPON
SKINNING:
	var LAST SKINNING
	match %LAST You can't do that while entangled in a web.
	match SKINNING You approach
	matchre SKIN_FAIL Some days it just doesn't pay to wake up|A heartbreaking slip at the last moment renders your chances|manage to slice it to dripping tatters|You bumble the attempt|but only succeed in reducing|but end up destroying|You fumble and make an improper cut|Maybe helping little old Halfling widows across a busy Crossing street|You claw at|twists and slips in your grip|There isn't another|Living creatures often object|Skin what\?|Somehow managing to do EVERYTHING|your skinning attempt an unfortunate failure|You hideously bungle the attempt|renders your skinning attempt an unfortunate failure|mangling it beyond recognition|cannot be skinned
	matchre SKIN_FAIL ^You carefully fit.*into your bundle\.|manage to remove the|skillfully peel|from the oozing flesh beneath|work hard at peeling|only slightly tainted with gore and fluids|without too much damage or splashing of gore|you work loose a sterling example|Moving with impressive skill and grace|Blood soaks into it badly though|A worthy accomplishment to be certain|but the rewards are worth it|skillfully remove|work diligently at skinning|slice away a bloody trophy|Some greater force|has already been skinned|You're certain that wasn't at all how it was supposed|You must have one hand free to skin|knife moves as a fluid extension of your hand
	match BUNDLE_ON Roundtime
		put skin
		matchwait 3
    goto SKINNING
	
ARRANGE_KILL:
	var LAST PRE_SKIN
	var ArrNum 0
	ARRANGEIT:
			if %ArrNum >= $GH_ARR_NUM then goto PRE_SKIN
			evalmath ArrNum (%ArrNum + 1)
			pause 0.5
			match %LAST You can't do that while entangled in a web.
			matchre PRE_SKIN you can't|^You don't have enough experience|has already been arranged as much as you can manage
			matchre ARRANGEIT ^You might want to kill it first|but manage not to damage the corpse|You properly arrange the
			matchre SKIN_REEQUIP_DONE The corpse is worthless now|has already been skinned|Arrange what?
		put arrange
		matchwait

BUNDLE_ON:
#	var LOCAL $GH_SKINS
#	math LOCAL add 1
#	put #var GH_SKINS %LOCAL

# Shortcutting bundle check since I always have one
goto HAVE_ONE
var LAST BUNDLE_ON
	match %LAST You can't do that while entangled in a web.
  	match HAVE_ONE You tap
  	match CHECK_ROPE I could not find what you were
	put tap bundle
	matchwait
CHECK_ROPE:
	var LAST CHECK_ROPE
		match %LAST You can't do that while entangled in a web.
		match GET_ROPE You tap
		match NO_MORE_ROPE I could not find
	put tap bund rope
	matchwait
NO_MORE_ROPE:
	echo
	echo *** No more rope for bundling ***
	echo
	put #var GH_BUN OFF
	goto BUNDLE_OFF
GET_ROPE:
	var LAST GET_ROPE
	pause 1
	if ("$lefthandnoun" = "knife") then gosub SHEATHE skinning.knife
GET_ROPE_CONT:
	if ("%RANGED" = "ON") then
	{
		if ("%STACK" = "ON") then 
		{
			put stow %CURR_WEAPON;stow %CURR_WEAPON
			pause 0.5
		}
	 	else gosub RANGE_SHEATHE	
	}
	elseif ("%BRAWLING" != "ON") then gosub SHEATHE %CURR_WEAPON
	put get my bund rope	
	waitfor You get
	put bundle
	pause 1
	if ("$GH_BUN_WORN" = "ON") then
	{
		put wear my bundle
		waitforre You sling|You wear
	}
	else
	{
		put drop bundle
		waitfor You drop
	}
	goto SKIN_REEQUIP	
HAVE_ONE:
#	if ("$lefthandnoun" = "knife") then gosub SHEATHE skinning.knife
	if ("$righthand" = "Empty") then goto SKIN_ERROR
#	if ("$GH_BUN_WORN" = "OFF") then
#	{
#		put get bundle
#		put remove bundle
#		waitforre You pick|You sling|You are already holding that
#	}
		match %LAST You can't do that while entangled in a web.
		matchre TOO_HEAVY Time to start a new bundle|You try to stuff your|not going to work
		matchre HAVE_ONE_CONT You stuff
	put bundle
	matchwait 3
  goto HAVE_ONE

TOO_HEAVY:
	var LAST TOO_HEAVY
	if ("$GH_BUN_WORN" = "ON") then
	{
		put #var GH_BUN OFF
		put drop my hide;drop my skin;drop my beak;drop my talon
		pause 0.5
		goto HAVE_ONE_CONT
	}		
		match CHECK_ROPE You drop
	put tie my bundle;tie my bundle;drop bundle
	matchwait
HAVE_ONE_CONT:
	if ("$GH_BUN_WORN" = "OFF") then 
	{
		put drop bundle
		waitfor You drop
	}
	if ("%BRAWLING" = "ON") then goto SKIN_REEQUIP_DONE
	else goto SKIN_REEQUIP

SKIN_FAIL:
	# echo
	# echo *** SKIN_FAIL ***
	#echo Skinning failed
	# echo
	goto SKIN_KNIFE_SHEATH
	
SKIN_ERROR:
	echo
	echo *** SKIN_ERROR ***
	echo Error occured while skinning, aborting script
	echo
	goto ERROR_DONE
	
BUNDLE_OFF:
	# echo
	# echo *** BUNDLE_OFF ***
	# echo
#	var LOCAL $GH_SKINS
#	math LOCAL add 1
#	put #var GH_SKINS %LOCAL
	BUNDLE_OFF_DROP:
	VAR LAST BUNDLE_OFF_DROP
	if ("$righthand" != "Empty") then
	{
			match SKIN_REEQUIP You drop
		put empty right
		matchwait 5
		goto BUNDLE_OFF_DROP
	}
SKIN_KNIFE_SHEATH:
	if ("$lefthandnoun" = "knife") then gosub SHEATHE skinning.knife
	goto SKIN_REEQUIP

SKIN_REEQUIP:
	var LAST SKIN_REEQUIP
	var SKINNED YES
	if (("%BRAWLING" != "ON") && ("$GH_LOOT" = "OFF")) then
	{
		gosub WIELD_WEAPON %CURR_WEAPON
		if (("%HAND" = "left") && ("$righthand" != "Empty")) then gosub SWAP_LEFT $righthandnoun
	}
	if ((toupper("$GH_RETREAT") = "ON") && ("%RETREATING" = "ON")) then gosub RETREAT_UNTRIGGERS
	goto SKIN_REEQUIP_DONE
  
SKIN_MONSTER_OFF: 
SEAR_MONSTER: 
	var Monster $1
SKIN_REEQUIP_DONE: 
	pause 0.5
	# echo
	# echo *** SEAR_MONSTER: ***
	# echo
	var LAST SKIN_REEQUIP_DONE
	if (("%SHIELD" != "NONE") && ("%WORN" = "OFF")) then
	{
		if ("$lefthand" = "Empty")) then gosub EQUIP_SHIELD
	}
	SKIN_REEQUIP_LOOT:
		match %LAST You can't do that while entangled in a web.
		matchre DONE_LOOT I could not find what|not dead
		matchre SEARCH_OTHER_MONSTER Sheesh
		matchre LOOT_$GH_LOOT You search|You shove your arm|Roundtime|picked clean of anything|You should probably wait until|has already been searched
	put loot $GH_LOOT_TYPE
	matchwait 2
  goto SKIN_REEQUIP_LOOT
	
SEARCH_OTHER_MONSTER:
		match %LAST You can't do that while entangled in a web.
		matchre EXPCHECK_$GH_EXP I could not find what|not dead
		matchre SEARCH_THIRD_MONSTER Sheesh
		matchre LOOT_$GH_LOOT You search|You shove your arm|Roundtime
	put loot $GH_LOOT_TYPE
	matchwait 2
  goto SEARCH_OTHER_MONSTER
SEARCH_THIRD_MONSTER:
		match %LAST You can't do that while entangled in a web.
		matchre EXPCHECK_$GH_EXP I could not find what|not dead
		matchre NO_MONSTER Sheesh
		matchre LOOT_$GH_LOOT You search|You shove your arm|Roundtime
	put loot $GH_LOOT_TYPE
	matchwait 2
  goto SEARCH_THIRD_MONSTER

LOOT_OFF:
	# echo
	# echo *** Not looting ***
	# echo
	if (("%STACK" = "ON") || ("%THROWN" = "ON")) then gosub THROWN_CLEAN %CURR_WEAPON
	if (("%THROWN" = "OFF") && ("%RANGED" = "ON")) then 
	{
		if ("%STACK" = "ON") then 
			{
				gosub THROWN_CLEAN %CURR_WEAPON
				pause
			}
		else gosub RANGED_CLEAN
	}
	if contains("$roomobjs", "a light kertig throwing axe") then gosub THROWN_CLEAN throwing.axe
	if contains("$roomobjs", "a thin steel-tip bolt") then
	{
		put stow thin bolt
		pause 0.5
		goto LOOT_OFF
	}
	goto TIMER_$GH_TIMER
	
LOOT_ON:
	# echo
	# echo *** Looting ***
	# echo
	var LAST LOOT_ON
	if (("%STACK" = "ON") || ("%THROWN" = "ON")) then
	{
		gosub THROWN_CLEAN %CURR_WEAPON
		pause 2
	}
	elseif (("%THROWN" = "OFF") && ("%RANGED" = "ON")) then gosub RANGED_CLEAN
	elseif (("%SHIELD" != "NONE") && ("%WORN" = "OFF") && ("$righthand" != "Empty")) then
	{
		if ("%RANGED" = "ON") then gosub RANGE_SHEATHE
		else gosub SHEATHE %CURR_WEAPON
	}
	LOOT_BLADE_CHECK:
	var LAST LOOT_BLADE_CHECK
	if contains("$roomobjs", "a light kertig throwing axe") then
	{
		gosub THROWN_CLEAN throwing.axe
		goto LOOT_BLADE_CHECK
	}
	if contains("$roomobjs", "a thin steel-tip bolt") then
	{
		put stow thin bolt
		pause 0.5
		goto LOOT_OFF
	}
	goto LOOT_BOX_$GH_LOOT_BOX
  
LOOT_BOX_ON:
	goto GET_BOX
LOOT_BOX_OFF:
	goto LOOT_GEM_$GH_LOOT_GEM
  
LOOT_GEM_ON:
	goto GET_GEM
LOOT_GEM_OFF:
	goto LOOT_COIN_$GH_LOOT_COIN
	
LOOT_COIN_ON:
	if matchre ("$roomobjs", "(coin|coins)") then goto GET_COIN
LOOT_COIN_OFF:
	goto LOOT_JUNK_$GH_LOOT_JUNK

LOOT_JUNK_ON:
	if matchre("$roomobjs", "(%junkloot)") then goto GET_JUNK
LOOT_JUNK_OFF:
	goto LOOT_LOCK_$GH_LOOT_LOCK

LOOT_LOCK_ON:
	if matchre("$roomobjs", "(lockpick)") then goto STOW_LOCK
LOOT_LOCK_OFF:
	goto DONE_LOOT
	
GET_BOX:
	var BOX $0
	var LOOTED YES
STOW_BOX:
	var LAST STOW_BOX
		match %LAST You can't do that while entangled in a web.
		matchre STOW_BOX_2 any more room in|You just can't get
		match STOW_BOX You put your
		matchre LOOT_GEM_$GH_LOOT_GEM Stow what\?|What were you referring
	put stow box
	matchwait 2
  goto STOW BOX
STOW_BOX_2:
	put #math box_cont_num + 1
	if $box_cont_num > $box_cont_num_max then goto NO_MORE_ROOM_BOX
STOW_BOX_3:
	pause 0.5
	match STOW_BOX_4 You will now store boxes in
	put store box $box_cont_$box_cont_num
	matchwait 3
	goto STOW_BOX_3

STOW_BOX_4:
		var LAST STOW_BOX_4
		match %LAST You can't do that while entangled in a web.
		matchre STOW_BOX_2 any more room in|You just can't get
		match STOW_BOX You put your
		matchre LOOT_GEM_$GH_LOOT_GEM Stow what\?|What were you referring
	if (matchre("$lefthandnoun", "(%boxes)") || matchre("$righthandnoun", "(%boxes)") then put stow my $1
	else put echo Stow what?
	matchwait 2
	goto STOW_BOX_4
	
NO_MORE_ROOM_BOX:
	var LAST NO_MORE_ROOM_BOX
	put #var GH_LOOT_BOX OFF
	put #var loottype TREASURE
	put #var GH_LOOT_TYPE TREASURE
	if (matchre("$lefthandnoun", "(%boxes)") || matchre("$righthandnoun", "(%boxes)") then
	{
		match %LAST You can't do that while entangled in a web.
		match LOOT_GEM_$GH_LOOT_GEM You drop|What were you
		put drop my $1
		matchwait 2
		goto NO_MORE_ROOM_BOX
	}
	goto LOOT_GEM_$GH_LOOT_GEM
 
GET_GEM:
	var LOOTED YES
STOW_GEM:
	var LAST STOW_GEM
		match %LAST You can't do that while entangled in a web.
		matchre TIE_POUCH You can't fit anything else in the \w+ gem pouch|already got a wealth of gems in the|any more room in|You just can't get|You think the gem pouch is too full to fit another gem into
		matchre STOW_GEM You put your|You open your pouch and put
		match LOOT_COIN_$GH_LOOT_COIN Stow what?
	put stow gem
	matchwait 2
  goto STOW_GEM

TIE_POUCH:
	var LAST TIE_POUCH
	if (("$lefthand" != "Empty") && ("%hand" = "")) then
	{
		put empty left
		waitforre You drop|What were you
	}
	if (("$righthand" != "Empty") && ("%hand" = "left")) then 
	{
		put empty right
		waitforre You drop|What were you
	}

REMOVE_POUCH:
	var LAST REMOVE_POUCH
		match %LAST You can't do that while entangled in a web.
		matchre NEW_POUCH ^You put
	put remove my gem pouch;put my gem pouch in my %TIED_CONTAINER
	matchwait 5
	goto REMOVE_POUCH


NEW_POUCH:
	var LAST NEW_POUCH
		match %LAST You can't do that while entangled in a web.
		match WEAR_POUCH You get
		match NO_MORE_ROOM_GEM What were you referring to
	put get gem pouch from my %POUCH_CONTAINER
	matchwait 2
  goto NEW_POUCH

WEAR_POUCH:
	var LAST WEAR POUCH
	put wear my gem pouch
	waitforre You attach|You are already wearing
	goto STOW_GEM
	
	
NO_MORE_ROOM_GEM:
	if (("$lefthand" != "Empty") && (contains("(%gems1|%gems2|%gems3|%gems4)", "$lefthandnoun"))) then put empty left
	elseif (("$righthand" != "Empty") && (contains("(%gems1|%gems2|%gems3|%gems4)", "$righthandnoun"))) then put empty right
	else put echo You drop
	waitforre You drop|What were you	
	put #var GH_LOOT_GEM OFF
	goto LOOT_COIN_$GH_LOOT_COIN

GET_COIN:
	put get coin
	pause 0.5
	goto LOOT_COIN_ON
	
GET_JUNK:
	var JUNK $0
	if (("%JUNK" = "fragment") && ("$GH_AMBUSH" = "ON")) then goto NO_MORE_ROOM_JUNK
	var LOOTED YES
STOW_JUNK:
	var LAST STOW_JUNK
		match %LAST You can't do that while entangled in a web.
		matchre  NO_MORE_ROOM_JUNK any more room in|Stow what|You just can't get
		match LOOT_JUNK_ON You put your
#	put stow %JUNK in %JUNK_CONTAINER
  put stow %JUNK
	matchwait 2
  goto STOW_JUNK
	
NO_MORE_ROOM_JUNK:
	put drop %JUNK
	waitforre You drop|What were you	
	put #var GH_LOOT_JUNK OFF
	goto LOOT_LOCK_$GH_LOOT_LOCK

STOW_LOCK:
	var LAST STOW_LOCK
		match %LAST You can't do that while entangled in a web.
		match NO_MORE_ROOM_LOCKPICK That's too heavy to go
		matchre LOOT_LOCK_ON You put your|You place the|What were you
	put get lockpick;put my lockpick in %LOCKCASE
		matchwait 2
    GOTO STOW_LOCK

NO_MORE_ROOM_LOCKPICK:
	put drop my lockpick
	waitforre You drop|What were you	
	put #var GH_LOOT_LOCK OFF
	goto DONE_LOOT

TOO_DARK:
	echo
	echo *** It's too dark to see anything ***
	echo
	goto TIMER_$GH_TIMER
  
NO_MONSTER:
	echo
	echo *** No monsters. ***
	echo
	goto TIMER_$GH_TIMER
  
NO_LOOT:
	echo 
	echo *** No Loot ***
	echo 
DONE_LOOT:
	pause 0.5
	if ("%LOOTED" = "YES") then
	{
#		var LOCAL $GH_LOOTS
#		math LOCAL add 1
#		put #var GH_LOOTS %LOCAL
		var LOOTED NO
	}
#	if (((("%SHIELD" != "NONE") && ("%WORN" = "OFF")) || ("$GH_SKIN" = "ON")) && ("%BRAWLING" = "OFF")) then gosub WIELD_WEAPON %CURR_WEAPON
	if (("%SHIELD" != "NONE") && ("%WORN" = "OFF") && ("%CURR_WEAPON" != "")) then gosub WIELD_WEAPON %CURR_WEAPON
#	if (("%HAND" = "left") && ("$righthand" != "Empty")) then gosub SWAP_LEFT $righthandnoun
	goto TIMER_$GH_TIMER

TIMER_ON:
	if (%t > (%MAX_TRAIN_TIME)) then goto SWITCH_WEAPON
	goto EXPCHECK_$GH_EXP
	
TIMER_OFF:
	goto EXPCHECK_$GH_EXP
	
EXPCHECK_ON:
#	put exp
#	waitfor Overall state of mind
if ("$GH_TRAIN" = "ON") then gosub EXPCHECKING
goto EXPCHECK_OFF

EXPCHECKING:
	if "$GH_NOEXP" = "ON" then goto EXPCHECK_OFF
	if (("$GH_TIMER" = "ON") && (%t > (%MAX_TRAIN_TIME))) then goto SWITCH_WEAPON
	if ("%ALTEXP" = "ON") then
	{
		if (($%EXP2.LearningRate > $exp) && (("%RANGED" = "OFF") || (("%RANGED" = "ON") && (("%DEAD" = "YES") || ("$GH_NOLODGE" = "ON"))))) then goto SWITCH_WEAPON
    else return
	}
	if ("$GH_AMBUSH" = "ON") && ($Stealth.LearningRate >= $stealthexp) then goto SWITCH_WEAPON
	if (($%WEAPON_EXP.LearningRate > $exp) then
	{
		if (("%RANGED" = "OFF") || (("%RANGED" = "ON") && (("%DEAD" = "YES") || ("$GH_NOLODGE" = "ON")))) then goto SWITCH_WEAPON
	}
 	return

EXPCHECK_OFF:
	var LAST EXPCHECK_OFF
  gosub SPELLCHECKING
	if (("$GH_AMBUSH" = "OFF") && ("$GH_MAGIC_TYPE" = "OFF")) then put #var GH_NOHUNT 0
	if ("%MAGIC_TYPE" != "OFF") then 
	{ 
		counter set %MAGIC_COUNT
		save %c
	}
#	put #statusbar 1 GH - Kills:$GH_KILLS  Skins:$GH_SKINS  Loots:$GH_LOOTS
	if ("%DEAD" = "YES") then goto APPR_$GH_APPR
	elseif (("%RANGED" = "ON") && ("%STACK" = "OFF") && ("%THROWN" = "OFF")) then goto RANGE_LOAD
	else goto %c

SWITCH_WEAPON:
  put #var GH_NOHUNT 1
	gosub clear
	action remove ^\.\.\.wait|^Sorry, you may only type
	var LAST SWITCH_WEAPON
	echo
	echo *** SWITCH_WEAPON ***
	echo *** Weapon skill locked ***
	echo
#  if (%SORC_PREPPED = 1) then
#  {
#    if %SORC_READY = 1 then gosub SORC_CAST
#    else
#    {
#      pause 0.5
#      var SORC_READY 0
#      var SORC_PREPPED 0
#      action (sorc) off 
#      put release spell
#    }
#  }
	if "%CYCLIC" = "ON" then
	{
	  pause
    put .cast dema 30
    waitfor Spell Cast
	  pause
    if (("$GH_BUFF" = "ON") && ($spell_$GH_BUFF_SPELL_isactive = 0)) then
    {
      put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
      waitfor Spell Cast
    }
	}
	put #play ring
	if ($hidden = 1) then put unhide
	if ("$orb" != "none") then put rub orb in my $orb
  put whistle piercing
  pause 0.5
	SWITCH_WEAPON_STACK_CHECK:
	if (("%STACK" = "ON") || ("%THROWN" = "ON")) then
	{
		if ("%HAND" = "left") && ("$lefthand" != "Empty") then gosub SWAP_RIGHT %CURR_WEAPON
		gosub THROWN_CLEAN %CURR_WEAPON
		if ("%HAND" = "left") && ("$lefthand" != "Empty") then goto SWITCH_WEAPON_STACK_CHECK
	}
	if ("%RANGED" = "ON") then 
	{
			gosub RANGE_SHEATHE			
		} else 
		{
			gosub SHEATHE %CURR_WEAPON
			put ret
	}
	if ("$GH_AMBUSH" = "ON") then
	{
#		pause 0.5
#		put get my greaves;wear my greaves
		pause 0.5
		put get my armor;wear my armor
		pause 0.5
		put get my gauntlets;wear my gauntlets
		pause 0.5
		put get my tooled mask;wear my tooled mask
		pause 0.5
		put get my $buckler;wear my $buckler
		pause 0.5
		put #var GH_AMBUSH OFF;stop sing
#		put stance set $shieldstance
	}
	if "$GH_BACKTRAIN" = "ON" then
	{
		put #var GH_BACKTRAIN OFF
		pause 5
	}
	if "$GH_MAGIC_TYPE" != "OFF" then
	{
		put #var GH_MAGIC_TYPE OFF
		pause 5
	}
	if ("$GH_AMBUSH" = "ON") then
	{
		put #var GH_AMBUSH OFF
		pause 5
	}
	pause 0.5
	put get my $buckler;wear my $buckler
SWITCH_WEAPON_LAST_CHECKS:
	if matchre("$roomobjs", "(throwing axe|cuska|throwing mallet|hand mallet|tempered pitchfork|elongated stone)" then
	{
		gosub THROWN_CLEAN $1 $2
		goto SWITCH_WEAPON_LAST_CHECKS
	}
	if (toupper("$GH_MULTI") != "OFF") then
	{
		if ($GH_MULTI_CURR_NUM < $GH_MULTI_NUM) then 
		{
			var TEMP $GH_MULTI_CURR_NUM
			math TEMP add 1
			put #var GH_MULTI_CURR_NUM %TEMP
			put #var GHMCURRNUM $GH_MULTI_CURR_NUM
		}
		else 
		{
			put #var GH_MULTI_CURR_NUM 1
			put #var GHMCURRNUM $GH_MULTI_CURR_NUM
		}
		if $GH_MULTI_CURR_NUM = $GH_CIRCUIT then put #var GH_CYCLE_HUNT 1
		if (toupper("$GH_MULTI") = "MULTI") then goto MULTI_$GH_MULTI_CURR_NUM
		else goto DMULTI_$GH_MULTI_CURR_NUM
	} else goto DONE

BERSERK:
	# echo
	# echo *** BERSERK: ***
	# echo
	# echo This will berserk you to try to escape harm
	goto DONE
  
BLEEDING:
	echo
	echo *** BLEEDING: ***
	echo You are bleeding
	echo Retreating to check health
	echo
	var GOING_TO %LAST
	put .tend
	waitfor Done Tending
	goto HEALTH_CHECK

STUNNED:
	echo
	echo *** STUNNED: ***
	echo You have been stunned.
	echo Retreating to check health.
	echo
	var GOING_TO %LAST
HEALTH_CHECK:
	gosub clear
	#var LAST HEALTH_CHECK
		match PAUSE still stunned
		match HEALTH_CHECK pole
		matchre CHECKING_HEALTH retreat from combat|You try to back away|already as far away as you can get
	put ret
	matchwait
CHECKING_HEALTH:
	if ($health >= 70) then
	{
		echo
		echo Not too beat up, returning to combat
		echo Be careful!
		echo
		goto %GOING_TO
	} else
	{
		echo
		echo Too beat up, aborting
		echo
		goto ABORT
	}

DROPPED_WEAPON:
	pause
	gosub clear
	put get %CURR_WEAPON
	counter set 0
	goto BEGIN
	
ABORT:
	gosub RETREAT_TRIGGERS
ABORTING:
	put scream defiance
	echo
	echo *** ABORT: ***
	echo
	echo Injured badly, you need medical assistance
	if ("%DYING" = "ON") then 
	{
		put look sword
		put quit
	}
	if ($zoneid = 107) then
	{
		put ret;ret
		pause 0.5
		put .kresh
		exit
	}
	if ($zoneid = 127) then
	{
		put ret;ret
		pause 0.5
		put .p5
		exit
	}
	put ret;ret
	pause 0.5
	put pyron
	pause 2
	put .retreat;.enc lilt 30;.train
	if ($health <= 30) then goto DEAD
	put #play abort
	pause 2
	goto ABORTING
	
DEAD:
	echo
	echo *** DEAD: ***
	echo
	echo You are dead.
	if ("%DYING" = "ON") then
	{
		put look sword
		pause 0.5
		put look sword
	}
	put #play abort
	#put quit
exit

WEAPON_APP_ERROR:
	gosub clear
	echo
	echo *** WEAPON_ERROR: ***
	echo
	echo DEBUG: Something happened while trying to discern the type of weapon
	put #play ring
	goto DONE

SHIELD_ERROR:
	gosub clear
	echo
	echo *** SHIELD_ERROR: ***
	echo
	echo DEBUG: Shield problem. Couldn't find, wear, or stow... or something.
	put #play ring
	goto DONE
  
ERROR:
	gosub clear
	echo
	echo *** Some ERROR occured ***
	echo
	put #play ring
	goto DONE

NO_VALUE:
	echo
	echo *** NO_VALUE: ***
	echo
	echo Basic use of script .geniehunter <weapon>
	goto DONE
	
DONE:
	if ($sleep = 1) then send awaken
	echo ***  Done  ***
	pause 1
	put glance
exit

ERROR_DONE:
	pause 1
	echo
	echo *** Done, but with errors ***
	echo
	if ("righthandnoun" = "katana") then put sheath my katana in my katana sheath
	else put stow right
	pause 1
	put stow left
	pause 1
	put glance
exit

#################################
##                             ##
##  General Utility functions  ##
##                             ##
#################################
PAUSE:
	gosub clear
	pause
	goto %LAST

RETURN:
	return
	
	## Famous recalls
	famous-1:
	put recall famous Sirolarn
	return
	famous-2:
	put recall famous Lanival
	return
	famous-3:
	put recall famous Nissa
	return
	famous-4:
	put recall famous Teiro
	return
	famous-5:
	put recall famous Trimbolt
	return
	famous-6:
	put recall famous Grell
	return
	famous-7:
	put recall famous Mibgluc
	return
	famous-8:
	put recall famous Glacis
	return
	famous-9:
	put recall famous Twando
	return
	famous-10:
	put recall famous Dunshade
	return
	famous-11:
	put recall famous Tatia
	return
	famous-12:
	put recall famous Ralel
	return
	famous-13:
	put recall famous Lasarhhtha
	return
	famous-14:
	put recall famous Sidhlot
	return
	famous-15:
	put recall famous Arhat
	return
	famous-16:
	put recall famous Grishnok
	return
	famous-17:
	put recall famous Yabul
	return
	famous-18:
	put recall famous Arinni
	return
	famous-19:
	put recall famous Vorclaf
	return
	famous-20:
	put recall famous World Dragon
	return
	famous-21:
	put recall famous Tezirah
	return
	famous-22:
	put recall famous Jeladric Theren
	return
	famous-23:
	put recall famous Wren
	return
	famous-24:
	put recall famous Siryn
	return
	famous-25:
	put recall famous Corik
	return
	famous-26:
	put recall famous Ocular
	return
	famous-27:
	put recall famous Amfitro
	return
	famous-28:
	put recall famous Andraethu
	return
	famous-29:
	put recall famous Tenebraus
	return
	famous-30:
	put recall famous Emuin
	return
	famous-31:
	put recall famous Sadiaer
	return
	famous-32:
	put recall famous Sorrow
	return
	famous-33:
	put recall famous Daralaendra
	return
	famous-34:
	put recall famous Braushocra
	return
	famous-35:
	famous-36:
	put recall famous Octa
	return
	famous-37:
	put recall famous Darkensi
	return
	famous-38:
	put recall famous Kukalakai
	return
	famous-39:
	put recall famous Prayk
	return
	famous-40:
	put recall famous Morganae
	return
	famous-41:
	put recall famous Bembo
	return
	famous-42:
	put recall famous Ragge
	return

	## Holiday recalls
	holiday-1:
	put recall holiday Eluned
	return
	holiday-2:
	put recall holiday Hodierna
	return
	holiday-3:
	put recall holiday Tamsine
	return
	holiday-4:
	put recall holiday Faenella
	return
	holiday-5:
	put recall holiday Kertigen
	return
	holiday-6:
	put recall holiday Divyaush
	return
	holiday-7:
	put recall holiday Everild
	return
	holiday-8:
	put recall holiday Truffenyi
	return
	holiday-9:
	put recall holiday Hav'roth
	return
	holiday-10:
	put recall holiday Glythtide
	return
	holiday-11:
	put recall holiday Chadatru
	return
	holiday-12:
	put recall holiday Blufandu
	return
	holiday-13:
	put recall holiday Shosandu
	return
	holiday-14:
	put recall holiday Lormandu
	return
	holiday-15:
	put recall holiday Anlandu
	return
	holiday-16:
	put recall holiday Jeolandu
	return
	holiday-17:
	put recall holiday Surmirae Anladorlo
	return
	holiday-18:
	put recall holiday Aurilae's Sacrifice
	return
	holiday-19:
	put recall holiday Aesthene's Close
	return
	holiday-20:
	put recall holiday Day of Mourning
	return
	holiday-21:
	put recall holiday Sicle Grove
	return

	## Immortal recalls

	immortal-1:
	put recall immortal Kertigen
	return
	immortal-2:
	put recall immortal Divyaush
	return
	immortal-3:
	put recall immortal Zachriedek
	return
	immortal-4:
	put recall immortal Hodierna
	return
	immortal-5:
	put recall immortal Berengaria
	return
	immortal-6:
	put recall immortal Asketi
	return
	immortal-7:
	put recall immortal Meraud
	return
	immortal-8:
	put recall immortal Firulf
	return
	immortal-9:
	put recall immortal Kerenhappuch
	return
	immortal-10:
	put recall immortal Damaris
	return
	immortal-11:
	put recall immortal Phelim
	return
	immortal-12:
	put recall immortal Dergati
	return
	immortal-13:
	put recall immortal Everild
	return
	immortal-14:
	put recall immortal Kuniyo
	return
	immortal-15:
	put recall immortal Trothfang
	return
	immortal-16:
	put recall immortal Truffenyi
	return
	immortal-17:
	put recall immortal Alamhif
	return
	immortal-18:
	put recall immortal Huldah
	return
	immortal-19:
	put recall immortal Hav'roth
	return
	immortal-20:
	put recall immortal Peri'el
	return
	immortal-21:
	put recall immortal Ushnish
	return
	immortal-22:
	put recall immortal Eluned
	return
	immortal-23:
	put recall immortal Lemicus
	return
	immortal-24:
	put recall immortal Drogor
	return
	immortal-25:
	put recall immortal Glythtide
	return
	immortal-26:
	put recall immortal Saemaus
	return
	immortal-27:
	put recall immortal Be'ort
	return
	immortal-28:
	put recall immortal Tamsine
	return
	immortal-29:
	put recall immortal Albreda
	return
	immortal-30:
	put recall immortal Harawep
	return
	immortal-31:
	put recall immortal Faenella
	return
	immortal-32:
	put recall immortal Murrula
	return
	immortal-33:
	put recall immortal Idon
	return
	immortal-34:
	put recall immortal Chadatru
	return
	immortal-35:
	put recall immortal Rutilor
	return
	immortal-36:
	put recall immortal Botolf
	return
	immortal-37:
	put recall immortal Urrem'tier
	return
	immortal-38:
	put recall immortal Eylhaar
	return
	immortal-39:
	put recall immortal Aldauth
	return

	## Herb recalls
	herb-1:
	put recall herb blocil berries
	return
	herb-2:
	put recall herb eghmok moss
	return
	herb-3:
	put recall herb genich stem
	return
	herb-4:
	put recall herb georin grass
	return
	herb-5:
	put recall herb hulnik grass
	return
	herb-6:
	put recall herb hisan salve
	return
	herb-7:
	put recall herb jadice flower
	return
	herb-8:
	put recall herb jadice pollen
	return
	herb-9:
	put recall herb muljin sap
	return
	herb-10:
	put recall herb nemoih root
	return
	herb-11:
	put recall herb nilos grass
	return
	herb-12:
	put recall herb nuloe stem
	return
	herb-13:
	put recall herb plovik leaf
	return
	herb-14:
	put recall herb qun pollen
	return
	herb-15:
	put recall herb riolur leaf
	return
	herb-16:
	put recall herb sufil sap
	return
	herb-17:
	put recall herb yelith root
	return
	herb-18:
	put recall herb cebi root
	return
	herb-19:
	put recall herb junliar stem
	return
