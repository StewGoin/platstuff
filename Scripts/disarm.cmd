# Get a more recent version and edit it w/ same options

## Box Picking - Genie 3 Edition
## Thanks Han

var hum $hum
var Trigger off
var Speed normal
var TrapCount 0
var BoxCount 0
var LockCount 0
var AfterLoot DISMANTLE
var Container1 %1
var Container2 lockpick case in my thigh bag
var style NONE
var SLEEP OFF
var GEM_CONTAINER ox.pouch
var TIED_CONTAINER $pack
var POUCH_CONTAINER thigh.bag
IF_2 var SLEEP %2
IF_3 var style %3



put stow left;stow right
pause
put remove my $headarmor;stow my $headarmor
put remove my $handarmor;stow my $handarmor
pause
put remove my target.shield;stow target.shield
pause
put open my %Container2;put awaken
gosub humstart

## Actions ##
action goto TIE_POUCH when ^You can't fit anything
action goto ARMOR when Your armor hinders your attempt
action goto TRAP.ID when is not fully disarmed, making any chance of picking it unlikely
action goto BLEW.IT when (Almost immediately, you grow dizzy, tottering from side to side until finally collapsing to the ground, dead asleep|The dart flies through your fingers and plants itself solidly in your forehead|With a sinister swishing noise|There is a sudden flash of greenish light|A stoppered vial opens with a pop|A stream of corrosive acid sprays out from|Just as your ears register the sound of a sharp snap|you realize that you must have been less than successful|you find yourself being hurled half-senseless through the air|you suddenly feel horribly transformed|emits a sound like tormented souls being freed|you notice the world around you has gotten much bigger|If you had to guess, you would say your carelessness did not disarm the trap|You are poisoned)
action var Speed careful when You get the distinct feeling your manipulation caused something to shift inside the trap mechanism

## Room Trap Saves ##
action var RoomTrap shrapnel when packed tightly with a powder
action var RoomTrap concussion when small wad of brown clay
action var RoomTrap laughing gas when a black gaseous substance
action var RoomTrap reaper when A crust-covered black scarab
action var RoomTrap naptha when A tiny striker is
action var RoomTrap gasser when vial of lime green liquid
action var RoomTrap teleport when thin metal circle that has been lacquered

WHAT.BOX:
save WHAT.BOX
matchre NOBOX ^There is nothing in there\.|Encumbrance|but there is nothing in there like that
matchre SET.COFFER (\S+\scoffer\b)
matchre SET.SKIPPET (\S+\sskippet\b)
matchre SET.STRONGBOX (\S+\sstrongbox\b)
matchre SET.CRATE (\S+\scrate\b)
matchre SET.CHEST (\S+\schest\b)
matchre SET.CASKET (\S+\scasket\b)
matchre SET.CADDY (\S+\scaddy\b)
matchre SET.TRUNK (\S+\strunk\b)
matchre SET.BOX (\S+\sbox\b)
if "%Container1" = "ground" then put look;enc
else put RUMMAGE /B MY %Container1;enc
matchwait

SET.COFFER:
math BoxCount add 1
setvariable BoxType coffer
goto GET.BOX
SET.SKIPPET:
math BoxCount add 1
setvariable BoxType skippet
goto GET.BOX
SET.BOX:
math BoxCount add 1
setvariable BoxType box
goto GET.BOX
SET.STRONGBOX:
math BoxCount add 1
setvariable BoxType strongbox
goto GET.BOX
SET.CRATE:
math BoxCount add 1
setvariable BoxType crate
goto GET.BOX
SET.CHEST:
math BoxCount add 1
setvariable BoxType chest
goto GET.BOX
SET.CASKET:
math BoxCount add 1
setvariable BoxType casket
goto GET.BOX
SET.CADDY:
math BoxCount add 1
setvariable BoxType caddy
goto GET.BOX
SET.TRUNK:
math BoxCount add 1
setvariable BoxType trunk
goto GET.BOX

GET.BOX:
pause 0.5
save GET.BOX
matchre GET.BOX ^\.\.\.wait|^Sorry\,
matchre APP You get|You pick up
match DONE referring to
if "%Container1" = "ground" then put GET %BoxType
else put GET MY $1 FROM %Container1
matchwait

APP:
pause 0.5
save APP
matchre APP ^\.\.\.wait|^Sorry\,
match TRAP.ID is a container
put APP MY %BoxType QUICK
matchwait

TRAP.ID:
pause 0.5
save TRAP.ID
var RoomTrap None
gosub PERC.CHECK
matchre TRAP.ID ^\.\.\.wait|^Sorry\,
match ARMOR Your armor hinders your attempt
## Sets speed based on chances
match TRAP.ID fails to reveal to you what type of trap protects it
match TRAP.BLIND trivially constructed gadget which you can take down any time
match TRAP.BLIND This trap is a laughable matter, you could do it blindfolded
match TRAP.BLIND An aged grandmother could defeat this trap in her sleep
match TRAP.QUICK will be a simple matter for you to disarm
match TRAP.QUICK should not take long with your skills
match TRAP.QUICK You think this trap is precisely at your skill level
match TRAP.NORMAL with only minor troubles
match TRAP.NORMAL trap has the edge on you, but you've got a good shot at disarming
match TRAP.CAREFUL You have some chance of being able to disarm
match TRAP.CAREFUL odds are against you
match TRAP.CAREFUL would be a longshot
match TRAP.CAREFUL You have an amazingly minimal chance
matchre TOO.HARD You really don't have any chance|Prayer would be a good start for any|You could just jump off a cliff and save|You probably have the same shot as a snowball|A pitiful snowball encased in the Flames
## Already disarmed
matchre GET.PICK positive attitude|It seems far enough away from the lock to be harmless|has been bent away from the casing|have been bent in such a way|rests a small deflated bladder|It is no longer attached to a razor|have been bent away from each other|has been pried out|separated harmlessly from their charge|you nudge the black crystal away from its position next to the lock|You cautiously pry the seal away from the lid|you unhook the stopper from the lid|the trap is no longer a threat|It's not exactly an original solution, but it still works
put DISARM ID
matchwait

TRAP.BLIND:
math TrapCount add 1
setvariable Speed quick
if "%style" != "NONE" then var Speed %style
setvariable AfterLoot DISMANTLE
if "%RoomTrap" != "None" then goto ROOM.TRAP
goto DISARM
TRAP.QUICK:
math TrapCount add 1
setvariable Speed normal
if "%style" != "NONE" then var Speed %style
setvariable AfterLoot DISMANTLE
if "%RoomTrap" != "None" then goto ROOM.TRAP
goto DISARM
TRAP.NORMAL:
math TrapCount add 1
setvariable Speed normal
if "%style" != "NONE" then var Speed %style
setvariable AfterLoot DISMANTLE
if "%RoomTrap" != "None" then goto ROOM.TRAP
goto DISARM
TRAP.CAREFUL:
math TrapCount add 1
setvariable Speed careful
if "%style" != "NONE" then var Speed %style
setvariable AfterLoot DISMANTLE
if "%RoomTrap" != "None" then goto ROOM.TRAP
goto DISARM

DISARM:
pause 0.5
save DISARM
gosub DISARM.CHECK
matchre DISARM ^\.\.\.wait|^Sorry\,
matchre DISARM did not disarm|caused something to shift|^You work with the trap for a while but are unable to make any progress
matchre TRAP.ID proves too difficult to manipulate|is not yet fully disarmed
matchre GET.PICK positive attitude|It seems far enough away from the lock to be harmless|you finally bend it away from any spark|you cautiously bend closed the metal plates over the bolts|unsavory contents to spray harmlessly upon|unhook it from the blade rendering it harmless|you flick the tube a couple of times with the tip of your finger|you carefully pry at the studs working them away|push it deep inside the box|You manage to work the contact fibers away|you carefully bend the head of the needle so|you carefully pack it into the small hole|you nudge the black crystal away from its position|You cautiously pry the seal away from the lid
put DISARM %Speed
matchwait

TRAP.ANALYZE:
pause 0.5
save TRAP.ANALYZE
gosub PERC.CHECK
matchre TRAP.ANALYZE ^\.\.\.wait|^Sorry\,
match TRAP.ANALYZE FAIL
match TRAP.ANALYZE You are unable to determine a proper 
matchre HARVEST you may be able to safely retrieve|^You've already analyzed this trap in preparation|positive attitude
put DISARM ANALYZE
matchwait

HARVEST:
pause 0.5
save HARVEST
gosub DISARM.CHECK
matchre HARVEST ^\.\.\.wait|^Sorry\,
match HARVEST You fumble around with the trap apparatus
match ANALYZE You will need to analyze the chest before 
match DISMANTLE much for it to be successfully harvested.
match DROPPER Roundtime
put DISARM HARVEST
matchwait

DROPPER:
pause 0.5
save DROPPER
matchre DROPPER ^\.\.\.wait|^Sorry\,
matchre DISMANTLE You drop|is already empty
put EMPTY LEFT HAND
matchwait

GET.PICK:
pause 0.5
if "$lefthandnoun" = "lockpick" then goto PICK.ID
save GET.PICK
matchre GET.PICK ^\.\.\.wait|^Sorry\,
matchre PICK.ID from inside|You pick up
put GET LOCKPICK FROM MY %Container2
matchwait

PICK.ID:
pause 0.5
save PICK.ID
gosub PERC.CHECK
matchre PICK.ID ^\.\.\.wait|^Sorry\,
match PICK.ID fails to teach you anything about the lock guarding
match ARMOR Your armor hinders your attempt
match GET.PICK Find a more appropriate tool and try again
## Sets speed based on chances
match PICK.BLIND trivially constructed gadget which you can take down any time
match PICK.BLIND An aged grandmother could
match PICK.BLIND you could do it blindfolded
match PICK.QUICK will be a simple matter for you to unlock
match PICK.QUICK should not take long with your skills
match PICK.QUICK You think this lock is precisely at your skill level
match PICK.QUICK with only minor troubles
match PICK.NORMAL lock has the edge on you, but you've got a good shot at
match PICK.NORMAL You have some chance of being able to
match PICK.NORMAL odds are against you
match PICK.CAREFUL would be a longshot
match PICK.CAREFUL You have an amazingly minimal chance
matchre TOO.HARD You really don't have any chance|Prayer would be a good start for any|You could just jump off a cliff and save|You probably have the same shot as a snowball|A pitiful snowball encased in the Flames
## Already unlocked
match STOW.PICK not even locked
matchre PICK.ANALYZE Somebody has already inspected the current lock
put PICK ID
matchwait

PICK.BLIND:
math LockCount add 1
setvariable Speed quick
if "%style" != "NONE" then var Speed %style
goto PICK.ANALYZE
PICK.QUICK:
math LockCount add 1
setvariable Speed normal
if "%style" != "NONE" then var Speed %style
goto PICK.ANALYZE
PICK.NORMAL:
math LockCount add 1
setvariable Speed normal
if "%style" != "NONE" then var Speed %style
goto PICK.ANALYZE
PICK.CAREFUL:
math LockCount add 1
if "%style" != "NONE" then var Speed %style
setvariable Speed careful
goto PICK.ANALYZE

PICK.ANALYZE:
pause 0.5
save PICK.ANALYZE
gosub PERC.CHECK
match GET.PICK Find a more appropriate tool and try again
matchre PICK This lock has already helpfully been analyzed|Somebody has already inspected the current lock on this chest|structure is relatively basic|positive attitude| This big lock obviously is meant for a correspondingly large key|An intricate steel star houses a complex locking mechanism|a thin hole along the bottom of the lock
matchre PICK.ANALYZE ^\.\.\.wait|^Sorry\,|You are unable to determine
put PICK ANALYZE
matchwait

PICK:
pause 0.5
save PICK
gosub PICK.CHECK
matchre PICK ^\.\.\.wait|^Sorry\,
match PICK You are unable to make any progress towards opening the lock
match GET.PICK Find a more appropriate tool and try again
match PICK.ID You discover another lock
matchre STOW.PICK But it's wide open\!|It\'s not even locked|positive attitude|Roundtime
match GET.PICK With a grimace, you discard the now useless lockpick
put PICK %Speed
matchwait

STOW.PICK:
pause 0.5
save STOW.PICK
matchre STOW.PICK ^\.\.\.wait|^Sorry\,
matchre OPEN You put|referring to
put PUT MY LOCKPICK IN MY %Container2
matchwait

OPEN:
pause 0.5
save OPEN
match GET.PICK It is locked
matchre OPEN ^\.\.\.wait|^Sorry\,
matchre COIN You open|already open
put OPEN MY %BoxType
matchwait

COIN:
pause 0.5
save COIN
matchre COIN ^\.\.\.wait|^Sorry\,
match COIN You pick up
match GEMS referring to?
put GET MY COIN
matchwait

OPEN.POUCH:
pause 0.5
save OPEN.POUCH
matchre OPEN.POUCH ^\.\.\.wait|^Sorry\,
matchre GEMS You open|positive attitude
put OPEN MY %GEM_CONTAINER
matchwait

GEMS:
pause 0.5
save GEMS
matchre GEMS ^\.\.\.wait|^Sorry\,
match OPEN.POUCH Open your
matchre TIE_POUCH fit any more gems|fit anything else
matchre NEW_POUCH You have to be holding or wearing
matchre LOOT You take|aren\'t any gems
put FILL MY %GEM_CONTAINER WITH MY %BoxType
matchwait

TIE_POUCH:
	var LAST TIE_POUCH
	put remove my %GEM_CONTAINER
	waitforre You remove|You aren't wearing that|What were you referring to
	put tie my %GEM_CONTAINER
	waitforre You tie up|has already been tied off|Tie what
	put put my %GEM_CONTAINER in my %TIED_CONTAINER
	waitforre You put your|What were you referring to
	goto NEW_POUCH

NEW_POUCH:
	var LAST NEW_POUCH
		match WEAR_POUCH You get
		match DONE What were you referring to
	put get %GEM_CONTAINER from my %POUCH_CONTAINER
	matchwait

WEAR_POUCH:
	var LAST WEAR POUCH
	put wear my %GEM_CONTAINER
	waitforre You attach|You are already wearing
	goto GEMS

LOOT:
pause 0.5
save LOOT
matchre LOOT ^\.\.\.wait|^Sorry\,
match %AfterLoot nothing in there
match RUNE.LOOT runestone
match CARD.LOOT card
matchre LOOT.JUNK In the .* you see .* (\w+).
put LOOK IN MY %BoxType
matchwait

LOOT.JUNK:
pause 0.5
put GET $1 FROM MY %BoxType
put DROP MY $1
pause
goto LOOT

CARD.LOOT:
pause 0.5
save
put GET CARD FROM MY %BoxType
put STOW MY CARD
goto LOOT

RUNE.LOOT:
pause 0.5
save
put GET RUNE FROM MY %BoxType
put STOW MY RUNE
goto LOOT

DISMANTLE:
pause 0.5
save DISMANTLE
setvariable AfterLoot DISMANTLE
matchre DISMANTLE ^\.\.\.wait|^Sorry\,
match TRAP.ID You must first disarm
matchre EXP Rolling your shoulders to loosen them|You move your hands|You place some meat|positive attitude
put DISMANTLE MY %BoxType
matchwait

EXP:
save
put EXP
waitfor EXP HELP
if "%SLEEP" = "ON" then goto WHAT.BOX
if "%SLEEPING" = "ON" then put awaken
if $Disarm_Traps.LearningRate > 10 then goto DONE
if $Appraisal.LearningRate > 10 then setvariable AfterGet ID
else setvariable AfterGet APP
if $Vocals.LearningRate >10 then gosub humstop
else gosub humstart
goto WHAT.BOX

PICK.CHECK:
put EXP
waitfor EXP HELP
if $Lockpicking.LearningRate > 11 then
{
	put sleep
	var SLEEPING ON
	return
}
elseif "%SLEEPING" = "ON" then
{
	put awaken
	var SLEEPING OFF
	return
}
else return

DISARM.CHECK:
put EXP
waitfor EXP HELP
if $Disarm_Traps.LearningRate > 11 then
{
	put sleep
	var SLEEPING ON
	return
}
elseif "%SLEEPING" = "ON" then
{
	put awaken
	var SLEEPING OFF
	return
}
else return

PERC.CHECK:
put EXP
waitfor EXP HELP
if $Perception.LearningRate > 11 then
{
	put sleep
	var SLEEPING ON
	return
}
elseif "%SLEEPING" = "ON" then
{
	put awaken
	var SLEEPING OFF
	return
}
else return

humstart:
put hum $hum
return

humstop:
put stop hum
return

BLEW.IT:
echo ********************
echo ** YOU BLEW IT! **
echo ********************
put #play abort.wav
put awaken
exit

TOO.HARD:
echo *******************************
echo ** OK this is way too hard **
echo *******************************
put awaken
exit

ROOM.TRAP:
 echo *******************************************
 echo ** Sorry bud room trap, are you alone? **
 echo *******************************************
 waitfor positive attitude
 goto DISARM

DONE:
echo *** MIND LOCKED \n Boxes opened %BoxCount, Traps worked %TrapCount, Locks worked %LockCount
put awaken
exit

NOBOX:
echo *** Out of boxes in that container.
put awaken
exit

ARMOR:
echo *** Yo genius, ditch the armor! Then type YES.
waitfor positive attitude
goto %s
