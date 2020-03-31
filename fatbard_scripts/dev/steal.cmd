#include this file.
action var STEAL.fullpool 1 when ^You feel that for the moment you've learned all you can about putting one over on the dupes.
action var STEAL.caught 1 when ^([\w ]+) (you attempting to make the grab|points to where you lie concealed) and begins to shout loudly for help
action var STEAL.trivial 1 when ^You don't feel you learned anything useful from this trivial theft
var STEAL.fullpool 0
var STEAL.caught 0
var STEAL.trivial 0
var STEAL.container
GOTO STEAL.END

MOVE:
	PAUSE 1
	MATCH ACTION YOU HAVE ARRIVED
	MATCH RETRYMOVE MOVE FAILED
	PUT #goto $1
	MATCHWAIT
ACTION:
	return
	
STEAL:
	setvar STEAL.fullhands 0
	setvar STEAL.caught 0
	setvar STEAL.trivial 0
	setvar STEAL.list $1
	eval STEAL.length count("%STEAL.list", "|")  
	evalmath STEAL.length %STEAL.length + 1
	counter set 0
STEAL.SHOPLIFT:
	pause 0.5
	if (%STEAL.fullpool = 1) then goto STEAL.STOLEN
	if ("$righthand" != "Empty" and "$lefthand" != "Empty") then
	{
		if ("%STEAL.container" = "") then
		{
			put drop $righthandnoun
			put drop $lefthandnoun
			pause
			if "$righthand" != "Empty" then put lower $righthandnoun
			if "$lefthand" != "Empty" then put lower $lefthandnoun
		}
		else
		{
			put stow right in %STEAL.container
			put stow left in %STEAL.container
		}
		pause 1
	}
	if ("$hidden" != "1") then
	{
		put hide
		pause 2
	}
	put steal %STEAL.list(%c)
	pause 5
	if (%STEAL.trivial = 1) then
	{
		echo ***
		echo *** %STEAL.list(%c) is trivial at $Stealing.Ranks ranks.
		echo ***
		goto STEAL.STOLEN
	}
	if (%STEAL.caught = 1) then
	{
		echo ***
		echo *** YOU GOT CAUGHT by $1!
		echo ***
		goto STEAL.STOLEN
	}
	counter add 1
	if (%c < %STEAL.length) then goto STEAL.SHOPLIFT
STEAL.STOLEN:
	if ("%STEAL.container" = "") then
	{
		if ("$righthand" != "Empty") then put drop $righthandnoun
		if ("$lefthand" != "Empty") then put drop $lefthandnoun
	}
	else
	{
		if ("$righthand" != "Empty") then put stow right in %STEAL.container
		if ("$lefthand" != "Empty") then put stow left in %STEAL.container
	}
	pause 1
	if ("$hidden" = "1") then put unhide
	return
STEAL.END: