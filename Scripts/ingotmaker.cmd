## Smelt and Flux script in one handy package.
## Author: Player of Hervean
## Version 1
## Updated: 11/26/2011

## Usage: .ingotmaker <optional>
## Command Options: smelt, flux, full
## smelt: Use the objects in the crucible to smelt an ingot. This will also remelt anything in there.
## flux: Places the ingot in your hand in the crucible to flux.
## full: Uses the objects in the crucible to smelt, and then flux an ingot.
##Debug 5

##defaults when not used with a command
var tool rod
var toflux no

if_1
{
eval command tolower("%1")
	if "%command" = "smelt" then
	{
		var tool rod
		var toflux no
	}
	if "%command" = "flux" then
	{
		var tool flux
		var toflux no
	}
	if "%command" = "full" then
	{
		var tool rod
		var toflux yes
	}

}

## Action Queue for roundtimes.
action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait

## Actions for smelting
action var tool ingot when ^At last the metal appears to be thoroughly mixed and you pour it into an ingot mold
action var tool rod when ^push fuel with my shovel|^push bellows|^turn cru|^pour flux in cru
action var tool turn when ^Upon finishing you observe clumps of molten metal
action var tool bellows when ^As you finish the fire flickers and is unable to consume its fuel
action var tool shovel when ^As you complete working the fire dies down and needs more fuel

start.work:
send count cru
pause 0.2
if "%command" = "flux" then
{
	send put my ingot in cru
	waitforre ^You put
}


do.work:
gosub %tool
goto do.work

rod:
gosub check.tool
send mix cruc with my rod
waitforre ^Roundtime
return

flux:
gosub check.tool
send pour flux in cru
waitforre ^Roundtime
var toflux no
return

turn:
send turn cru
waitforre ^Roundtime
return

bellows:
gosub check.tool
send push bellows
waitforre ^Roundtime
return

shovel:
gosub check.tool
send push fuel with my shovel
waitforre ^Roundtime
return

check.tool:
if ("$righthandnoun" = "%tool") then return
if ("$righthand" != "Empty") then 
{ 
	send stow
	waitforre ^You put|^Stow what
}
send get my %tool
waitforre ^You get
return

ingot:
if "%toflux" = "yes" then
{
	var tool flux
	send put my ingot in cru
	waitforre ^You put
	return
}
echo INGOT COMPLETED
put #parse INGOT COMPLETED
exit