#debug 10

##########################################################################
#						Author:		Londrin								 #
#						Version:	1.0								 	 #
#						Script:		SetHunt								 #
#				Feel free to update the script as you see fit			 #
##########################################################################

##########################################################################
##		                 Script: Genie Hunter                           ##
##		             General combat script                              ##
##		       By: Warneck (with help from SFHunter)                    ##
##		                                                                ##
##		General Options:                                                ##
## APPR: appraises monsters, will not appraise if appraisal is locked   ##
## ARRANGE #: arranges skinnable creatures before skinning them         ##
##		The # designates the number of times you want to arrange (1-5)  ##
##		If no # entered, will default to 1 time                         ##
## BARB: Analyzes monsters with Barbarian options for Expertise         ##
##		syntax is BARB (type)                                           ##
##		Valid types are: FLAME, ACCURACY, DAMAGE, INTIMIDATION,         ##
##		FATIGUE, BALANCE, VITALITY, RAGE or CALM.                       ##
## Only one type at a time can be active.                               ##
## BLOCK: sets stance to shield stance                                  ##
## BONE: arranges for bones                                             ##
## BUFF: uses buffing subroutine                                        ##
## BUNDLE: bundles skins if you have ropes.  Bundles are untied, and    ##
##		dropped.  See TIE and WEAR for other options                    ##
## COLLECTIBLE: loots collectibles (diras and cards)                    ##
## COUNT/DANCE: dances with X number of creatues.                       ##
## CUSTOM: sets stance to custom stance                                 ##
## DANGER: part of the BUFF command, it sets BUFF and retreats during   ##
##		casting                                                         ##
## DEFAULT: use the default setting, use DSET fist to set up defaults   ##
##		can also use .hunt with no arguments to do this                 ##
## DMSET: setup for multi-weapon with default settings                  ##
##		use is .hunt dmset weapon1 weapon2 ...                          ##
## DMULTI: Multi-weapon with default settings                           ##
## DODGE/EVADE: sets stance to evasion stance                           ##
## DSET: used to set up the default settings                            ##
##		run .hunt DSET <<all other options>> once to set the            ##
##		defaults, this will go through init like normal, and then       ##
##		save all the settings globally for use as default               ##
## ENCHANTE: casts designated Bard cyclic every 7 minutes               ##
## EXP: checks weapon experience.  Will end script when skill is        ##
##		bewildered or above                                             ##
## HUNT: will use the HUNT verb to train perception and stealth, but    ##
##		will not move around the hunting ground                         ##
## JUGGLE/YOYO: juggles when no more monsters in the room               ##
## JUNK: loots scrolls/runestones/cards, exclusive from LOOT            ##
## KHRI: Uses Thief khri. Please use the khri's name in lowercase       ##
## to set the correct variables on for the khri you use                 ##
## LOOTALL: loots everything it can                                     ##
## LOOTBOXES: loots  boxes, redundant if used with LOOTALL              ##
## LOOTCOINS: loots coins, redundant if used with LOOTALL               ##
## LOOTGEMS: loots gems, redundant if used with LOOTALL                 ##
## MANIP: adds manipulation (empathy training);                         ##
## requires $manipulate variable                                        ##
## MARK (Thief only): Utilizes MARK ALL instead of APPRAISE             ##
## MSET: setup for multi-weapon, break up multi setups with quotation   ##
##		marks: .hunt "setup 1" "setup 2"..."setup 10"                   ##
##		supports up to 10 setups currently                              ##
##		setups are saved as GH_MULTI_# for edittabillity                ##
## MULTI: multi-weapon training, will use a weapon until locked         ##
##		then switch to the next setup when locked                       ##
## NECROHEAL: Necromancer healing.  Only use if you have the consume    ##
##		spell.  Will not activate if below 80% mana or if               ##
##		$roomplayers shows anyone present.  Minor scuffs                ##
##		are not healed.                                                 ##
## NECRORITUAL: Will perform a necromancer ritual, if of right guild    ##
##		and $roomplayers shows no one present.  Options are             ##
##		preserve, harvest, arise.  If no ritual is specified,           ##
##		will use preserve usage is                                      ##
##		.hunt necroritual preserve/harvest/arise                        ##
## NOEVASION: Will skip the evasion stance when switching stances       ##
## NOPARRY: Will skip the parry stance when switching stances           ##
## NOSHIELD: Will skip the shield stance when switching stances         ##
## PARALYSIS: shock-free TM training for Empaths                        ##
##		requires $paralysis variable                                    ##
## PART: arranges for parts                                             ##
## PARRY: sets stance to parry stance                                   ##
## PILGRIM: prays on a pilgrim's badge every 30 minutes                 ##
## POINT: toggles hidden critter pointing (Default is OFF)              ##
## POUCH: changes gem pouches when current one is full.  See help       ##
## POWERP: will power perceive once every 6 minutes.                    ##
## RETREAT: turns on retreating for ranged weapons / spells. This       ##
##		does not work with poaching yet                                 ##
## ROAM: will roam around the hunting area if no more monsters in       ##
##		room to kill                                                    ##
##		!!!CAUTION!!!                                                   ##
##		There is no safeguard for leaving a hunting area or             ##
##		wandering into a more dangerous area.                           ##
## SCRAPE: scrape skins/pelts/hides after skinning, retreating works    ##
##		while doing this activity.  Use SKINRET for this                ##
## SEARCH: Sets loot option.  Treasure/Boxes/Equipment/Goods/All        ##
##    without setting an option, uses game default see in game          ##
##    LOOT HELP for more information on differences                     ##
## SKIN: skins monsters                                                 ##
## SKINRETREAT: will turn on retreating while skinning                  ##
## SLOW: for weaklings or noobs, will wait for stamina to refill        ##
##		before next attack if it drops below 90%                        ##
## STANCE: will cycle through stances once that skill is locked         ##
##		current cycle is evas -> shield -> parry and back               ##
## TACTICS: Will add tactics-training to your hunting routine           ##
## TEND: Will tend external wounds if bleeding - WILL NOT UNWRAP IF     ##
##  WOUND STARTS BLEEDING WORSE                                         ##
## TARGET: specifies a target to aim/target for attacks                 ##
## THIEF: This option uses Thief-only ambushes                          ##
## TIE: Ties bundles when first created, saves inventory space          ##
## TIMER: will set a timer to abort the script after x seconds          ##
## TRAIN: will check experience after every combat cycle, ranged        ##
##		weapon firing/throwing, or spell cast                           ##
## WEAR: Wears bundles.  Uses STOW verb to put skin into bundle if it   ##
##		this is used w/ the TIE option.                                 ##
##		                                                                ##
##		Weapon Options:                                                 ##
## AMBUSH: hides/stalks and attacks from hiding, checks stealth exp     ##
##    has a feature that will attempt to return to your original        ##
##    room if you stalk a creature into another by accident.            ##
##		If you have the ROAM option activated, this part of the         ##
##		feature is deactivated.                                         ##
## ANALYZE: Analyzes monsters to get debuff combos;                     ##
## syntax is ANALYZE # (1-10)                                           ##
## BACKSTAB: backstabs with weapon                                      ##
## BRAWL: brawls, will brawl with a weapon out if so desired            ##
## CONSTRUCT: adds construct check (to avoid Empathic shock) to weapon  ##
##		and TM training													##
## EMPATH: non-lethal brawling (trains tactics)                         ##
## FEINT: use a feinting routine to keep balance up                     ##
## MAGIC: uses magic in the same syntax as TM/PM, but will only cast    ##
##		once per critter, then use the primary weapon to kill           ##
## OFFHAND: uses weapon in offhand, works with melee or thrown          ##
## POACH: poaches with a ranged weapon, checks stealth exp              ##
## SNAP: snap-fires ranged weapon and snapcasting for magic             ##
##  Following this command with a # will pause for that many seconds    ##
##   before casting/firing                                              ##
## SNIPE: snipes with a ranged weapon                                   ##
## STACK: throws stacks of weapons (throwing blades). If you use        ##
##		this, don't use THROW too                                       ##
## SWAP/BASTARD: swappable weapon support, equips the weapon and        ##
##		swaps it to the desired weapon "mode"                           ##
##		Available mode options:                                         ##
##			1 - one handed                                              ##
##			2 - two handed                                              ##
##			b - blunt                                                   ##
##			e - edged                                                   ##
##			ha - halberd                                                ##
##			pi - pike                                                   ##
##			qs - quarter staff                                          ##
##			ss - short staff                                            ##
## TSWAP: does the same as SWAP, but for throwing weapons               ##
## THROW: throws a thrown weapon                                        ##
## TM/PM: uses magic as the primary weapon, with brawling as the        ##
##		backup if no other weapon is specified (and you run out of      ##
##		mana). The extra harness is optional. TM for targeted exp       ##
##		check, PM for primary magic exp checks. SNAP will snapcast.     ##
##		Use as follows:                                                 ##
##		(SNAP) <TM|PM> <spell> <mana> (extra mana) <weapon> <shield>    ##
##		                                                                ##
## Use:                                                                 ##
## .hunt (General options) (Weapon Options) weapon shield               ##
##		                                                                ##
## Note: You must have the EXP Tracker Plugin for this script to work   ##
##########################################################################


# Set the below variables with the sequence you want to run them with using the Genie Hunter options above
# Example: Var Heavy_Thrown "appr hunt arrange 5 Wear Tie lootcoin lootgem powerp timer 600 Train Slow parry offhand throw javelin"

# Start this script like:
# .sethunt base - Will just set your multi hunt setup. Still need to start genie hunter with .hunt multi
# .sethunt cont - Will start genie hunter for you and watch for failures, but also will check your learning rates to not waste time training weapons already trained

# 	Ranged
Var Heavy_Thrown "appr hunt arrange 5 Wear Tie lootcoin lootgem powerp timer 600 Train Slow parry offhand throw javelin"
Var Light_Thrown ""
Var Bows ""
Var Slings ""
Var Crossbows ""

#	Melee
Var Large_Edged ""
Var Small_Blunt ""
Var Brawling ""
Var Twohanded_Edged ""
Var Polearms ""
Var Twohanded_Blunt ""
Var Staves ""
Var Small_Edged ""
Var Large_Blunt ""

#	Magic
Var Targeted_Magic ""
Var Debilitation ""

#	Set this value to whatever number you would like the cont option to skip training if the current learning
#	rate of this weapon is higher than it.
#	Example: Var LearningRate 10
#	Current LearningRate in Heavy Thrown is 15
#	Cont will skip training this weapon because it currently has more field experience than your setting.
#	Any weapons under this value will be trained.
Var LearningRate 10

###################################
#                                 #
# Do NOT alter the below sections #
#                                 #
###################################

if !matchre (toupper("%1"), "(\bBASE|CONT)") then
{
	echo Start SetHunt with "Base" or "Cont" next time!
	goto SETHUNT.ExitNow
}

action goto SETHUNT.Watch when ^DONE, BUT WITH ERRORS

Var allCombats |Heavy_Thrown|Large_Edged|Small_Blunt|Light_Thrown|Targeted_Magic|Debilitation|Brawling|Twohanded_Edged|Polearms|Twohanded_Blunt|Bows|Staves|Small_Edged|Large_Blunt|Slings|Crossbows
Var combatsToCheck 
Var combatsToTrain

SETHUNT.AddCombatsToUse:
eval numberOfAllCombats count("%allCombats", "|")
Var count 0
Var combatCounter 1
SETHUNT.AddCombatsToUseLoop:
if %count < %numberOfAllCombats then
{
	if %%allCombats(%combatCounter) != "" then
	{
		Var combatsToCheck %combatsToCheck|%allCombats(%combatCounter)
	}
	math count add 1
	math combatCounter add 1
	goto SETHUNT.AddCombatsToUseLoop
}

eval numberOfTotalCombats count("%combatsToCheck", "|")

SETHUNT.CombatRankCheck:
Var count 0
Var RankCounter1 1
Var RankCounter2 1

SETHUNT.CombatRankCheck.ONE:
if %count < %numberOfTotalCombats then
{
	Var LowestRank %combatsToCheck(%RankCounter1)
	gosub SETHUNT.CombatRankCheck.TWO
	Var combatsToTrain %combatsToTrain|%LowestRank
	eval combatsToCheck replace("%combatsToCheck", "%LowestRank", "")
	eval combatsToCheck replace("%combatsToCheck", "||", "|")
	math RankCounter2 set 1
	math count add 1
	goto SETHUNT.CombatRankCheck.ONE
}
goto SETHUNT.SetHunt

SETHUNT.CombatRankCheck.TWO:
if "%LowestRank" != "%combatsToCheck(%RankCounter2)" then
{
	if $%LowestRank.Ranks >= $%combatsToCheck(%RankCounter2).Ranks then
	{
		Var LowestRank %combatsToCheck(%RankCounter2)
	}
}
if %RankCounter2 < %numberOfTotalCombats then
{
	math RankCounter2 add 1
	goto SETHUNT.CombatRankCheck.TWO
}
return

SETHUNT.SetHunt:
eval numberOfCombatsToTrain count("%combatsToTrain", "|")
Var count 0
Var huntCounter 1
Var huntSet
SETHUNT.SetHuntLoop:
if %count < %numberOfCombatsToTrain then
{
	Var huntSet %huntSet %%combatsToTrain(%huntCounter)
	math count add 1
	math huntCounter add 1
	goto SETHUNT.SetHuntLoop
}

if_1 then
{
	if matchre (toupper("%1"), "(\bBASE)") then goto SETHUNT.Exit
	if matchre (toupper("%1"), "(\bCONT)") then goto SETHUNT.Watch
}

SETHUNT.Watch:
echo WATCHING YOU
eval combatsToCheck replace("%combatsToTrain", "|", "-> ")
put #echo >Log #8080FF Starting Genie Hunter!
put #echo >Log #8080FF Training Order: %combatsToCheck
Var count 0
Var huntCounter 1
SETHUNT.WatchSetVariablesLoop:
if %count < %numberOfCombatsToTrain then
{
	eval len length(%%combatsToTrain(%huntCounter))
	eval %combatsToTrain(%huntCounter) substr(%%combatsToTrain(%huntCounter), 0, %len)
	math count add 1
	math huntCounter add 1
	goto SETHUNT.WatchSetVariablesLoop
}
Var count 0
Var huntCounter 1
SETHUNT.WatchLoop:
if %count < %numberOfCombatsToTrain then
{
	if $%combatsToTrain(%huntCounter).LearningRate < %LearningRate then
	{
		put .hunt %%combatsToTrain(%huntCounter)
		waitforre ^You glance down at
		math count add 1
		math huntCounter add 1
		goto SETHUNT.WatchLoop
	}
	math count add 1
	math huntCounter add 1
	goto SETHUNT.WatchLoop
}
goto SETHUNT.ExitNow

SETHUNT.Exit:
eval combatsToTrain replace("%combatsToTrain", "|", "-> ")
put #echo >Log #8080FF Starting Genie Hunter!
put #echo >Log #8080FF Training Order: %combatsToCheck
put .hunt mset %huntSet
SETHUNT.ExitNow:
put #echo >Log #8080FF SetHunt is done!
exit