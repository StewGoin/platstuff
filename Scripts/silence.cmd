# See if this is still possible.

#debug 8
if_1 goto start
exit

include listsubs.cmd

start:
if "%1" = "remove" then
{
	gosub remove %2
	exit
}
if "%1" = "removeall" then goto removeall
else goto addname

addname:
put gaze at %1 in silence;hum tuneless
pause
put perceive
pause
put gesture %1
if ("$silenced" = "\$silenced") || ("$silenced" = "") then put #var silenced %1
else put #var silenced $silenced|%1
put #gag {/(^%1 (whispers|says|yells).*|^Chatter\[%1\].*|^You hear %1.*|^Your mind hears the voice of %1.*)/i}
put smile in relief, now ignoring %1 completely for awhile.
#put #event 36000 .silence remove %1
#put #event 9000 .silence remove %1
put #event
put #var save;#gag save
exit


remove:
put frown in dismay, remembering $1's existence.
put #ungag {(^$1 (whispers|says|yells).*|^Chatter\[$1\].*|^You hear $1.*|^Your mind hears the voice of $1.*)}
if ("$silenced" = "\\$silenced") || ("$silenced" = "") then exit
else var remove_list $silenced
gosub list_remove remove_list $1
if ("%remove_list" = "\%remove_list") then put #var silenced ""
else put #var silenced %remove_list
put #var save;#gag save
return

removeall:
if ("$silenced" = "\\$silenced") || ("$silenced" = "") then exit
else var removeall_list $silenced
	removeloop:
	gosub list_pop removeall_list name
	gosub list_remove %name
	if ("%removeall_list" = "") then exit
	else goto removeloop
