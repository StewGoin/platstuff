# See if there are elements to integrate into mining script
put get my shovel
pause

var PANIC 0
var CLEANED 0
var COUNTER 5
var SWITCH 0
var CAREFUL_DONE 0
var ROOM_CLEAN_CHECK 0
var DANGER_USED 0
var NO_COLLECT 0

action goto stow_nug when eval matchre("$roomobjs", "(?:covellite|gold|silver|tyrium|platinum|orichalcum|darkstone|animite|niniam|haralun|lumium|damite|kertig|glaes|electrum|oravir) nugget")
action goto stow_frag when eval matchre("$roomobjs", "fragment")
action goto stow_shard when eval matchre("$roomobjs", "shard")
action goto stow_tear when eval matchre("$roomobjs", "tear")
action goto stow_lump when eval matchre("$roomobjs", "lump")

action var DANGER 1 when ^The floor shudders briefly,
action var DANGER 1 when ^A bitter smell seeps into the air.
action var DANGER 1 when ^The ground rumbles ominously.
action var DANGER 1 when ^Studying the geology, you are certain that continued mining will be rather dangerous.
action var DANGER 1 when ^Studying the geology, you are certain that continued mining will be somewhat dangerous.
action var DANGER 1 when ^The ground rumbles ominously.
action var DANGER 1 when ^The floor shudders briefly,
action var UNCONCIOUS 1 when ^A large, oblong fragment slams into your forehead and you feel yourself toppling backwards as the world goes black!
action var PINNED 1 when You seem to be pinned in place.$
ACTION var CLEANED 0 WHEN eval matchre("$roomobjs", "(?:pebble|stone|rock|boulder|nugget|shard|tear|fragment|lump)")

if "$roomplayers" <> "" and %ROOM_CLEAN_CHECK = 0 then 
{
	goto ROOMDONE
}


and_again:
put prospect careful
waitfor You carefully scan

keep_on:
	if (%CLEANED < 6 && %PANIC = 0) then
	{
		echo %CLEANED
		put mine
		math CLEANED add 1
		waitfor Roundtime
			goto keep_on
	}
  	elseif (%PANIC = 1) then
	{
		put prospect danger
		match done Unfortunately, you are unable to find any way around the instability in the geology.
		match fixed Using a discarded stone you make several notations on the wall
		matchwait
	}
	else
	{
		put prospect
		var CLEANED 0
		match keep_on can be mined here.
		match done Roundtime
		matchwait	
	}

fixed:
var PANIC 0
	goto and_again

stow_nug:
pause
put stow nug
match keep_on You pick up
match keep_on Stow what?
matchwait

stow_frag:
pause
put stow frag
match keep_on You pick up
match keep_on Stow what?
matchwait

stow_lump:
pause
put stow lump
match keep_on You pick up
match keep_on Stow what?
matchwait

stow_shard:
pause
put stow shard
match keep_on You pick up
match keep_on Stow what?
matchwait

stow_tear:
pause
put stow tear
match keep_on You pick up
match keep_on Stow what?
matchwait

done:
	exit
