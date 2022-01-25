# Replace / integrate with mining script on forums.

### Can make just about any room have a huge Quantity by prospect careful right after ya prospect normal?
### For rooms you want to start off with a shovel, issue 1 parameter e.g.: .mine 1
### For rooms you want to rip through and empty without saving stuff, issue 2 parameters e.g: .mine 1 2
#debug 10
###

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
	var skinnablemonsters5 la'heke|vykathi soldier|boa|warcat|moda|arzumo|carcal|blood warrior|goblin
	var skinnablemonsters6 rat|antelope|giant blight bat|leucro|wasp|mottled westanuryn|blight ogre|gryphon|caracal|basilisk
	var skinnablemonsters7 dobek moruryn|sinuous elsralael|sleek hele'la|shadow mage|marbled angiswaerd|retan dolomar|faenrae stalker
	var skinnablemonsters8 shadow beast|cinder beast|asaren celpeze|spirit dancer|scaly seordmaor|poloh'izh|armadillo|shalswar|hierophant|black ape|Isundjen conjurer|cave troll|warklin mauler|armored warklin

	var skinnableundead1 ghoul|squirrel|grendel|reaver|mey|shadow hound|lach|mastiff|gremlin|enraged tusky
	var skinnableundead2 zombie kobold savage|zombie kobold headhunter|ghoul crow|misshapen germish'din|ice adder

	var invasioncritters transmogrified oaf|flea-ridden beast|(Rakash|Elven|Human|Prydean) ranger|bone warrior|shambling horror|skeletal (peon|hound|warrior|archer)|(revivified|zombie|peon) mutt|fleshreaper|(Rakash|Prydaen|goblin) zombie|snaer hafwa|black death spirit|patchwork abomination|necrotic warrior|ghoul seagull|putrefying shambler|ghoulish slayer|Prydaen|Rakash|cadaverous hulk|preserved zombified \w+|gestalt draugen|unctuous \w+ zombie

	var skinnvasioncritters grey ghoul

	var skinnablecritters %skinnablemonsters1|%skinnablemonsters2|%skinnablemonsters3|%skinnablemonsters4|%skinnablemonsters5|%skinnablemonsters6|%skinnablemonsters7|%skinnablemonsters8|%skinnableundead1|%skinnableundead2|%skinnvasioncritters
	var nonskinnablecritters %monsters1|%monsters2|%monsters3|%monsters4|%monsters5|%monsters6|%monsters7|%undead1|%undead2|%undead3|%invasioncritters

	var critters %skinnablecritters|%nonskinnablecritters

STANDING:
if $standing != 1 then
{
	pause
	put stand
	goto STANDING
}


### Set this to how many seconds you want to wait in-between swinging your pick or shovel
var MINEPAUSE 2

### Set this to the number of times you want to mine, not get anything, and then mine careful (can set from %1)
var CLEANNUMBER 5

### Set this to the maximum number of times you want to use prospect danger before stopping. Set to 0 to disable.
var DANGER_USES 0

### Don't mess with these unless you like breaking scripts
var COUNTER %CLEANNUMBER
var SWITCH 0
IF_1 var SWITCH 1
var SHOVELONLY 0
IF_1 var SHOVELONLY 1
var PICKONLY 0
var GoodOre 1
IF_2 var PICKONLY 1
IF_2 var GoodOre 0
var CAREFUL_DONE 0
var ROOM_CLEAN_CHECK 0
var DANGER_USED 0
var DANGER_CHECK 0
var NO_COLLECT 0
IF_3 var NO_COLLECT 1
var FREED 0
var METAL 0

### Various actions to catch important events.
action var DANGER_CHECK 1 when ^A bitter smell seeps into the air.
action var DANGER_CHECK 1 when ^Studying the geology, you are certain that continued mining will be rather dangerous.
action var DANGER_CHECK 1 when ^Studying the geology, you are certain that continued mining will be somewhat dangerous.
action var DANGER_CHECK 1 when ^The ground rumbles ominously.
action var DANGER_CHECK 1 when ^The floor shudders briefly,
action var DANGER_CHECK 1 when punctures a thin veneer of stone and releases a plume of corrosive gas|Fetid warmth washes over you after your
action var UNCONCIOUS 1 when ^A large, oblong fragment slams into your forehead and you feel yourself toppling backwards as the world goes black\!|^Sweet smelling air fills your nostrils following the swing of your
action var PINNED 1 when You seem to be pinned in place.$
action var GET_OUT 1 when Your nostrils detect nothing, but moments later you feel your muscles seize up in response|The gas seems to shoot through your veins, instantly wracking your entire body with pain
action var FREED 1 when The world slowly comes into focus again
action var FREED 1 when You finally manage to clear away enough rubble to lever yourself free.

#action var METAL 1 when ^A spill of stone reveals the faint glimmer of metal beneath

action var ROOM_RESET 1 when deed resources
action var ROOM_RESET 1 when ^Miners stand ready to trade resources in for deeds
action var CAREFUL_CHECK 1 when scattering of resources
action var MINED_OUT 1 when Your analysis has revealed no additional resources to be unearthed here

action var CLEANNUMBER 15 when a substantial quantity remains to be found\.$
action var CLEANNUMBER 12 when a good quantity remains to be found\.$
action var CLEANNUMBER 8 when a decent quantity remains to be found\.$
action var CLEANNUMBER 5 when a small quantity remains to be found\.$
action var CLEANNUMBER 3 when a scattering of resources remains to be found\.$

var MINED_OUT 0

TOOL_FIX_1:
	pause .5
		put .fix pickaxe
		waitfor ITEM FIXED
		pause .5
		gosub put my pickaxe in my $craftpack
		pause .5
		put .fix shovel
		waitfor ITEM FIXED
		gosub put my shovel in my $craftpack
		pause .5

### Start doing stuff
pause .5
if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
if %SHOVELONLY = 1 && %PICKONLY = 0 then gosub get my shovel
else gosub get my pickaxe
pause .5
var COUNTER 20

MAIN:
	if %UNCONCIOUS = 1 then goto UNCONCIOUS
	if %PINNED = 1 then goto PINNED
	if %DANGER_CHECK = 1 then goto DANGER_CHECK

	if "$roomplayers" <> "" and %ROOM_CLEAN_CHECK = 0 then
	{
		goto ROOMDONE
	}
	math ROOM_CLEAN_CHECK set 1

ROOM_MINE:
	pause %MINEPAUSE
ROOM_MINE_1:
	var ROOM_RESET 0
	var CAREFUL_CHECK 0
	if %UNCONCIOUS = 1 then goto UNCONCIOUS
	if %PINNED = 1 then goto PINNED
	if %DANGER_CHECK = 1 then goto DANGER_CHECK
	if ((%COUNTER < %CLEANNUMBER) || (%NO_COLLECT = 1)) then
	{
		matchre ROOM_MINE_1 ^\.\.\.wait|you may only type
		match ROOM_MINED Roundtime
		put mine
		matchwait 2
		goto ROOM_MINE_1
	}
	else
	{
		matchre ROOM_PROSPECTED Roundtime|Your analysis has revealed no additional resources to be unearthed here
		put pros
		matchwait 2
		goto ROOM_MINE_1
	}

ROOM_PROSPECTED:
	if %ROOM_RESET = 0 then
	{
		if ((%CAREFUL_DONE = 1) && (%t < 600)) then goto ROOMDONE
		else goto CAREFUL_CHECK
	}
#	if %MINED_OUT = 1
#	if (((%MINED_OUT = 1) || (%CAREFUL_CHECK = 1)) && ((%CAREFUL_DONE = 1) && (%t < 600))) then goto ROOMDONE
#	if ((%MINED_OUT = 1) || (%CAREFUL_CHECK = 1)) && ((%CAREFUL_DONE = 0) || (%t > 600))) then goto CAREFUL_CHECK
	if %ROOM_RESET = 1 then goto ROOM_RESET
#	goto ROOMDONE

ROOM_RESET:
	math COUNTER set 0
	goto ROOM_MINE

ROOM_MINED:
	math COUNTER add 1

ROOM_CHECK:
ROOM_CHECK_1:
	if %UNCONCIOUS = 1 then goto UNCONCIOUS
	if %PINNED = 1 then goto PINNED
	if %DANGER_CHECK = 1 then goto DANGER_CHECK
	pause .5
#	if (%PICKONLY = 1) then goto ROOM_MINE
	if ((%SWITCH = 0) && (%METAL = 1)) then
			{
				pause .5
				gosub put my pickaxe in my $craftpack
				gosub get my shovel
				math SWITCH set 1
			}
#unused for now	covellite|nickel|pewter|tin|zinc
#	if matchre("$roomobjs", "((((?:massive|enormous|gigantic) (?:$mineMassivePlus))|((?:huge|massive|enormous|gigantic) (?:$mineMediumPlus))|((?:medium|large|huge|massive|enormous|gigantic) (?:$mineMediumPlus))|(?:$mineAll)) (nugget|shard|tear|fragment|lump))") then
  if matchre("$roomobjs", "((which|that) appears dead|\(dead\))" then goto DEAD_MONSTER
ROOM_CHECK_2:
  if matchre("$roomobjs", "(((?:($mineAll|$mineRip))) (nugget|shard|tear|fragment|lump))") then
	{
		var ITEM $0
		eval ITEM replacere("%ITEM", "medium|large|huge|massive|enormous|gigantic " , "")
		math COUNTER set 0
		pause .5
		var GoodOre 1
		if (%NO_COLLECT = 0) then
		{
			gosub get %ITEM
			gosub put my %ITEM in my $minepack
			if ((%SWITCH = 0) && (%PICKONLY = 0)) then
			{
				pause .5
				gosub put my pickaxe in my $craftpack
				gosub get my shovel
				math SWITCH set 1
			}
			goto ROOM_CHECK_1
		}
	}
	else goto ROOM_MINE

DEAD_MONSTER:
  if "%DEAD" = "YES" then
  {
    var DEAD NO
    pause 2
    goto ROOM_CHECK_2
  }
	echo *** DEAD_MONSTER: ***
	var DEAD YES
	if matchre("$roomobjs", "(%skinnablecritters|%skinnvasioncritters) ((which|that) appears dead|\(dead\))") then goto SKIN_MONSTER
	if matchre("$roomobjs", "(%critters) ((which|that) appears dead|\(dead\))") then goto SEAR_MONSTER
	goto NO_MONSTER

SKIN_MONSTER:
	var Monster $1
	var LAST SKIN_MONSTER
	pause 1
SKINNING:
	var LAST SKINNING
	match SKINNING You approach
	matchre SKIN_FAIL Some days it just doesn't pay to wake up|A heartbreaking slip at the last moment renders your chances|manage to slice it to dripping tatters|You bumble the attempt|but only succeed in reducing|but end up destroying|You fumble and make an improper cut|Maybe helping little old Halfling widows across a busy Crossing street|You claw at|twists and slips in your grip|There isn't another|Living creatures often object|Skin what\?|Somehow managing to do EVERYTHING|your skinning attempt an unfortunate failure|You hideously bungle the attempt|renders your skinning attempt an unfortunate failure|mangling it beyond recognition|cannot be skinned
	matchre SKIN_FAIL ^You carefully fit.*into your bundle\.|manage to remove the|skillfully peel|from the oozing flesh beneath|work hard at peeling|only slightly tainted with gore and fluids|without too much damage or splashing of gore|you work loose a sterling example|Moving with impressive skill and grace|Blood soaks into it badly though|A worthy accomplishment to be certain|but the rewards are worth it|skillfully remove|work diligently at skinning|slice away a bloody trophy|Some greater force|has already been skinned|You're certain that wasn't at all how it was supposed|You must have one hand free to skin|knife moves as a fluid extension of your hand
	match BUNDLE_ON Roundtime
		put skin
		matchwait 3
    goto SKINNING

BUNDLE_ON:
		matchre TOO_HEAVY Time to start a new bundle|You try to stuff your|not going to work
		matchre HAVE_ONE_CONT You stuff
	put bundle
	matchwait 3
  goto HAVE_ONE

TOO_HEAVY:
	var LAST TOO_HEAVY
		match CHECK_ROPE You drop
	put tie my bundle;tie my bundle;drop bundle
	matchwait
HAVE_ONE_CONT:
	else goto SKIN_REEQUIP

SKIN_FAIL:
SKIN_REEQUIP:
SKIN_MONSTER_OFF:
SEAR_MONSTER:
	var Monster $1
SKIN_REEQUIP_DONE:
	pause 0.5
	var LAST SKIN_REEQUIP_DONE
	SKIN_REEQUIP_LOOT:
		matchre DONE_LOOT I could not find what|not dead
		matchre LOOT_ON You search|You shove your arm|Roundtime|picked clean of anything|You should probably wait until|has already been searched
	put loot treasure
	matchwait 2
  goto SKIN_REEQUIP_LOOT

LOOT_ON:
	var LAST LOOT_ON
LOOT_GEM_ON:
	goto GET_GEM
LOOT_GEM_OFF:
	goto LOOT_COIN_ON

LOOT_COIN_ON:
	if matchre ("$roomobjs", "(coin|coins)") then goto GET_COIN
LOOT_COIN_OFF:
	goto LOOT_JUNK_ON

LOOT_JUNK_ON:
	if matchre("$roomobjs", "(%junkloot)") then goto GET_JUNK
LOOT_JUNK_OFF:
	goto DONE_LOOT

GET_GEM:
	var LOOTED YES
STOW_GEM:
	var LAST STOW_GEM
		matchre TIE_POUCH You can't fit anything else in the \w+ gem pouch|already got a wealth of gems in the|any more room in|You just can't get|You think the gem pouch is too full to fit another gem into
		matchre STOW_GEM You put your|You open your pouch and put
		match LOOT_COIN_ON Stow what?
	put stow gem
	matchwait 2
  goto STOW_GEM

TIE_POUCH:
	var LAST TIE_POUCH
	if ("$lefthand" != "Empty") then
	{
		put empty left
		waitforre You drop|What were you
	}

REMOVE_POUCH:
	var LAST REMOVE_POUCH
		matchre NEW_POUCH ^You put
	put remove my gem pouch;put my gem pouch in my $pack
	matchwait 5
	goto REMOVE_POUCH


NEW_POUCH:
	var LAST NEW_POUCH
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
	else put echo You drop
	waitforre You drop|What were you
	goto LOOT_COIN_ON

GET_COIN:
	put get coin
	pause 0.5
	goto LOOT_COIN_ON

GET_JUNK:
	var JUNK $0
	if ("%JUNK" = "fragment") then goto NO_MORE_ROOM_JUNK
	var LOOTED YES
STOW_JUNK:
	var LAST STOW_JUNK
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
	goto DONE_LOOT

TOO_DARK:
	echo
	echo *** It's too dark to see anything ***
	echo
  goto DONE_LOOT

NO_MONSTER:
	echo
	echo *** No monsters. ***
	echo
  goto DONE_LOOT

NO_LOOT:
	echo
	echo *** No Loot ***
	echo
DONE_LOOT:
	pause 0.5
	if ("%LOOTED" = "YES") then
	{
		var LOOTED NO
	}
  goto ROOM_CHECK_2

CAREFUL_CHECK:
	if %UNCONCIOUS = 1 then goto UNCONCIOUS
	if %PINNED = 1 then goto PINNED
	if %DANGER_CHECK = 1 then goto DANGER_CHECK
	if %GoodOre = 0 then goto ROOMDONE
	if %CAREFUL_DONE = 0 then goto CAREFUL
	goto ROOMDONE

CAREFUL:
	var MINED_OUT 0
	timer clear
	timer start
	pause
  matchre ROOMDONE Your analysis has revealed no additional resources to be unearthed here.
	matchre CAREFUL_1 Roundtime
	put prospect CAREFUL
	matchwait 2
	goto CAREFUL

CAREFUL_1:
	pause
  pause .5
    var fixnoun $righthandnoun
    put .fix $righthandnoun
    waitfor ITEM FIXED
    pause .5
    gosub get my %fixnoun
	math CAREFUL_DONE set 1
	math COUNTER set 1
	goto MAIN

DANGER_CHECK:
	if %UNCONCIOUS = 1 then goto UNCONCIOUS
	if %PINNED = 1 then goto PINNED

DANGER:
	put #echo ***** DANGER MINER-ROBINSON!!! *****
	pause 0.5
	matchre DANGER_FAIL you are unable to find any way around the instability in the geology
	matchre DANGER_1 continued mining here would be slightly dangerous
	match NODANGER You scan the area for danger and find nothing of concern lurking within the nearby geology.
	put prospect DANGER
	matchwait 2
	goto DANGER

DANGER_FAIL:
	pause
	if (%DANGER_USES > 0) then
	{
		math DANGER_USED ADD 1
	  if (%DANGER_USED >= %DANGER_USES) then goto ROOMDONE
	}
	else goto DANGER
DANGER_1:
	pause
	if (%DANGER_USES > 0) then
	{
		math DANGER_USED ADD 1
	  if (%DANGER_USED >= %DANGER_USES) then goto ROOMDONE
	}
NODANGER:
	var DANGER_CHECK 0
	math COUNTER set %CLEANNUMBER
	goto MAIN

UNCONCIOUS:
	put #play abort;#echo ***** UNCONCIOUS!!! *****
	if %FREED = 0 then waitforre The world slowly comes into focus again|You peacefully awaken
	var UNCONSCIOUS 0
	goto FREED

PINNED:
	put #play abort;#echo ***** PINNED!!! *****
	if %FREED = 0 then waitfor You finally manage to clear away enough rubble to lever yourself free.
	var PINNED 0
	goto FREED

FREED:
	var FREED 0
	pause
	put stand
	pause
	if $standing <> 1 then goto FREED
	math COUNTER set %CLEANNUMBER
	goto MAIN


ROOMDONE:
	pause .5
	gosub put $lefthandnoun in my $craftpack
	gosub put $righthandnoun in my $craftpack

### .fix is a separate script
TOOL_FIX_2:
	pause .5
	if %PICKONLY = 0 then
	{
		put .fix shovel
		waitfor ITEM FIXED
		pause .5
		gosub put my shovel in my $craftpack
		pause .5
	}
	if %SHOVELONLY = 0 then
	{
		put .fix pickaxe
		waitfor ITEM FIXED
		gosub put my pickaxe in my $craftpack
		pause .5
	}

ALLDONE:
	put enc
	put #parse Mining Done
	exit

### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

PUT:
	var put $0
PUT.1:
  matchre PUT.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	put put %put
	matchwait 2
	goto PUT.1

GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up
   send get %Get
   matchwait 2
	 goto GET.2

STOW:
   var Stow $0
STOW.2:
   pause .2
   matchre STOW.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You put (a|an|some|your|the)|Stow what\?
   send stow %Stow
   matchwait 2
	 goto STOW.2

RETURN:
	return
