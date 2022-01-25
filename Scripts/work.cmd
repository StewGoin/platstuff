# Redo for "work" situations

put #script abort all except work

put .afk on
put .retreat
put awaken
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type

if $zoneid = 34 then goto mist_148
goto work_start

include includes.cmd
include origami.cmd

work_start:
	put stop sing
	gosub go_room 266
	put stop sing
	pause 3
	put .aoff
	waitfor Armor Off
	pause
	put get my shield;wear my shield
	put stance set $evastance
#	action remove ^\.\.\.wait|^Sorry, you may only type
#	gosub origami.start
	pause
	put hide
	exit
	
mist_148:
	pause
	if matchre("$roomobjs", "a dark bronze blade") then
	{
		gosub THROWN_CLEAN dark.blade
		goto mist_148
	}
	if matchre("$roomobjs", "some dark bronze blades") then
	{
		gosub THROWN_CLEAN dark.blade
		goto mist_148
	}
	if matchre("$roomobjs", "hand mallet") then
	{
		gosub THROWN_CLEAN mallet
		goto mist_148
	}
	if matchre("$roomobjs", "war hammer") then
	{
		gosub THROWN_CLEAN war.hammer
		goto mist_148
	}
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put pyron
		pause 3
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	pause
	put stop sing
	put .retreat
	pause
	gosub go_room 137
	gosub go_room 231
	put stop sing
	pause 3
	put .aoff
	waitfor Armor Off
	pause
	put get my shield;wear my shield
	put stance set $evastance
#	action remove ^\.\.\.wait|^Sorry, you may only type
#	gosub origami.start
	pause
	put hide
	exit
