# Dead script, mine for useful info

#debug 5
# Enchantes used in combat / with this script.
var chants pyre|dema|rage|fae|care|repr
var songs harm|lilt|tear|balm|resonance|mere|eye|dmrs|misdirection|madm|cry|aban|joy|aewo|sire
var play drum|naga|dalu|drums|sanc|sanctuary|aura

# var alwaysdone drum|drums|naga|dalu|sanc|sanctuary|lilt|tear|balm|mere|eye|dmrs|misdirection|madm|cry|aban|joy|aewo|dema|fae|care|rage

# set your minimum safe levels of stamina and mana to avoid backfires / attunement loss.
var minmana 94
var minstam 92

## enchante variables setup section (not always run)
set:
put #var magicenchante harm
put #var magicencstyle sing
put #var magicencvol quiet
put #var magicencmana 35

put #var backenchante harm
put #var backencstyle sing
put #var backencvol loud
put #var backencmana 15
put #var backencharn 35

put #var rangedenchante madm
put #var rangedencstyle sing
put #var rangedencvol quiet
put #var rangedencmana 35

put #var ambenchante pyre
put #var ambencstyle chant
put #var ambencvol quiet
put #var ambencmana 52

if_1 goto enchante_top

usage:
	echo *** .enc <enchante shortname/name> <prep mana> (extra harnesses) ***
	exit

# NOTE: This script will also trigger off enchantes and go into a "wait" mode while Geniehunter is hunting via MAGIC os some variety to avoid attunement issues.

enchante_top:
send release all
action goto enchante_abort when $stamina < 70
action goto mana_waiting when You are unable to harness sufficient energy to power the enchante
	
enchante_check:
	if matchre ("%1","(%chants)") then put #var encstyle chant
	if matchre ("%1","(%play)") then put #var encstyle play
	if matchre ("%1","(%songs)") then put #var encstyle sing
	put #var enchante %1
	shift
	put #var encmana %1
	var localmana %1
	shift
	if matchre("%1","^\d+$") then
	{
		put #var harnmana %1
		shift
	}
	else put #var harnmana 0
	put #var encvol loud
	if_1 put #var encvol %1
	if_1 shift
	var ALWAYSON 0
	if (toupper("%1") = "ON") then
	{
		var ALWAYSON 1
		shift
	}
	if_1 put #var encstyle %1

if ($harnmana = 0) then goto PRE_RELEASE
else goto enchante_start

PRE_RELEASE_PAUSE:
delay 15

PRE_RELEASE:
	matchre PRE_RELEASE \.\.\.wait
	matchre enchante_start You aren't|You release|You let your concentration lapse
	matchre PRE_RELEASE_PAUSE ^You are too busy concentrating on your journey to do that
	put release all
	matchwait 2
	goto PRE_RELEASE
		
MAGIC_PAUSE:
	delay 15

backfire:
delay 5
enchante_start:
	pause 0.5
	if ($harnmana = 0) then goto enchante_start_2
	MAGIC_HARNESS:
			matchre MAGIC_HARNESS \.\.\.wait
			matchre MAGIC_HARNESS_1 You aren't|You release|You let your concentration lapse
			matchre MAGIC_PAUSE ^You are too busy concentrating on your journey to do that
		put release all
			matchwait 2
		goto MAGIC_HARNESS
	MAGIC_HARNESS_1:
	if ("$GH_MAGIC_TYPE" != "OFF") then goto enchante_start_2
	if $GH_SETUP = 1 then waiteval $GH_SETUP = 0
		matchre MAGIC_HARNESS_1 ^\.\.\.wait|^Sorry, you may only type
		matchre enchante_start_2 You tap into the mana from|You strain, but cannot harness
		if ("$GH_BACKTRAIN" = "ON") then put harness $backencharn
		else put harness $harnmana
	matchwait 5
	goto MAGIC_HARNESS
enchante_start_2:	
	pause 0.1
	action remove eval "$GH_AMBUSH" = "OFF"
	action remove eval "$GH_BACKTRAIN" = "OFF"
	action goto enchante_restart when You stop performing|not performing anything|you stop performing|The enchante you were performing dissipates|You have difficulty manipulating the mana streams, and the song collapses in a crashing of dissonance and awkward notes|As you attempt to perform the enchante, a sense of ennui washes over you and the music and magic slips away|^The music of your enchante falls apart
	action goto backfire when ^Your spell.*backfires
#	if "$GH_CAMB" = "ON" then
#	{
#		action remove eval "$GH_CAMB" = "OFF"
#		action goto enchante_restart when eval "$GH_CAMB" = "ON"
#		evalmath actual_mana ($encmana - $cam_mana)
#	}
#	else
#	{
#		action remove eval "$GH_CAMB" = "ON"
#		action goto enchante_restart when eval "$GH_CAMB" = "OFF"
		var actual_mana $encmana
#	}
	if %ALWAYSON = 1 then
	{
		put mana song $encmana
		put song $encvol
		var COMMAND $encstyle $enchante
		goto enchante_start_3
	}
	action goto to_ambush when eval "$GH_AMBUSH" = "ON"
	action goto to_backtrain when eval "$GH_BACKTRAIN" = "ON"
	if ($stamina < %minstam) then goto stamina_wait
	if ($mana < %minmana) then goto mana_waiting
	#action goto enchante_abort when eval "$GH_XPTYPE" = "OFF"
	if ("$GH_AMBUSH" = "ON") then
	{
		put song $ambenchcvol;mana song $ambencmana
		var COMMAND $ambencstyle $ambenchante
		action remove eval "$GH_AMBUSH" = "ON"
		action goto from_ambush when eval "$GH_AMBUSH" = "OFF"
		goto enchante_start_3
	}
	if ("$GH_BACKTRAIN" = "ON") then
	{
		put song $backvol;mana song $backencmana
		var COMMAND $backencstyle $backenchante
		action remove eval "$GH_BACKTRAIN" = "ON"
		action goto from_backtrain when eval "$GH_BACKTRAIN" = "OFF"
		goto enchante_start_3
	}
	if ("$GH_MAGIC_TYPE" != "OFF") then
	{
		action goto magic_switch when eval "$GH_MAGIC_TYPE" = "OFF"
		put mana song $magicencmana
		put song $magicencvol
		var COMMAND $magicencstyle $magicenchante
		goto enchante_start_3
	}
	else
	{
		action goto magic_switch when eval "$GH_MAGIC_TYPE" != "OFF"
		put mana song %actual_mana
		put song $encvol
		var COMMAND $encstyle $enchante
		goto enchante_start_3
	}
	enchante_start_3:
	if ($stamina < %minstam) then goto stamina_wait
	if ($mana < %minmana) then goto mana_waiting
	pause 0.5
		if contains("%COMMAND" = "harm") then var COMMAND sing harmony OFF
			matchre enchante_start_3 ^\.\.\.wait|^Sorry, you may only type|It's all a blur
			matchre enchante_waiting already playing a song|you launch into the introduction|you begin to sing|you begin to chant|hummed tones form a soft backdrop for the opening notes|you begin the opening passages|You begin to sing|You hum the low|In a low tone you begin your enchante|then begin to chant|take shape in your mind|you launch yourself into the introduction of
		put %COMMAND
		matchwait 5
		goto enchante_start_3


to_melee:
	if "$enchante" = "$rangedenchante" then goto enchante_restart
	pause 0.1
	matchre to_melee ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre enchante_start You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto to_melee

to_ranged:
	if ("$GH_AMBUSH" = "ON") then goto to_ambush
	if "$enchante" = "$rangedenchante" then goto enchante_waiting
	if "$enchante" = "rage" then goto enchante_waiting
	if (("$enchante" = "joy") || ("$enchante" = "tear") || ("$enchante" = "misdirection") || ("$enchante" = "eye")) then goto enchante_start
	pause 0.1
	matchre to_ranged ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre enchante_start You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto enchante_start

to_ambush:
	matchre to_ambush ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre enchante_start You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto to_ambush

from_ambush:
	matchre from_ambush ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre from_ambush_2 You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto from_ambush
	from_ambush_2:
	pause 0.1
	goto enchante_start

to_backtrain:
	matchre to_backtrain ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre enchante_start You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto to_backtrain

from_backtrain:
	pause
	matchre from_backtrain ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre from_backtrain_2 You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto from_backtrain
	from_backtrain_2:
	pause 0.1
	goto enchante_start

magic_switch:
	if "$enchante" = "$magicenchante" then goto enchante_restart
	pause 0.1
	matchre magic_switch ^\.\.\.wait|^Sorry, you may only type|It's all a blur
	matchre enchante_start You stop performing|not performing anything|you stop performing|backfires
	put stop sing
	matchwait 15
	goto to_melee

enchante_restart:
	delay 1
	if "$enchante" = "dalu" then
	{
		delay 30
	}
	goto enchante_start

mana_waiting:
	delay 5
	goto enchante_start_2

enchante_waiting:
	waitfor ALL DONE WITH ENCHANTES
	exit
	
enchante_abort:
	action remove You stop performing|not performing anything|you stop performing
	action remove backfires
	action remove eval "$GH_XPTYPE" = "OFF"
		matchre enchante_abort ^\.\.\.wait|^Sorry, you may only type|It's all a blur
		matchre stamina_wait You stop performing|not performing anything|you stop performing|backfires
	put stop sing
		matchwait 15
	
	goto enchante_abort

stamina_wait:
	if $stamina > 85 then goto enchante_start
	delay 5
	goto stamina_wait

enchante_off:
	action remove You stop performing|not performing anything|you stop performing
	action remove backfires
	action remove eval "$GH_AMBUSH" = "ON"
	action remove eval "$GH_MAGIC" = "ON"
	action remove eval "$GH_MAGIC_TYPE" != "OFF"
	action goto enchante_restart when eval "$GH_AMBUSH" = "OFF"
	action goto enchante_restart when eval "$GH_MAGIC" = "OFF"
	action goto enchante_restart when eval "$GH_MAGIC_TYPE" = "OFF"
	pause 0.1
		matchre enchante_off ^\.\.\.wait|^Sorry, you may only type|It's all a blur
		matchre enchante_waiting You stop performing|not performing anything|you stop performing|backfires
	put stop sing
		matchwait 15
		
	goto enchante_off
