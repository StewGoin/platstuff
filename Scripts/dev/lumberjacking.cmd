debug 10

###Lumberjacking by Arvedui Iorlas
###Based off the original Mining Script

### User Defined Settings

# Which sizes of lumber to deed
var LumberDeed (log)
# Which sizes of lumber to stow
var LumberStow (branch|limb|stick)
# Where to put the stowed Lumber
var LumberStorage duffel.bag

# List of materials to keep
###var MaterialKeepList (copper|iron|tin|zinc|covellite|lead|nickel|oravir|silver|animite|audrualm|damite|darkstone|electrum|glaes|gold|haralun|kertig|lumium|niniam|platinum|boulder) (\w*)
var MaterialKeepList (ash|elm|oak|pine|willow) (\w*)

# How long to wait after chopping before going again.
# Too small a value may cause dangers to happen before they can be corrected.
var SaftyPause 12

############################################################################
###Variable declaration.

# Did we find anything on the last chop?
var FoundWood 0

# How many times in a row have we failed to find anything?
var Failure 0

# How many times have we found something since the last time we watched?
var Success 0

# How much material is left in the room.
var MaterialLevel 0

# Are there workers available to deed?
var DeedWorkers 0

# Variable used for data tracking
var TotalWood 0

############################################################################
###Trigger setup

# If roundtime wasn't up try sending the last command again.
action (Retry) pause, put $lastcommand when ...wait

# Check if we find anything when mining
action (Lumberjacking) %FoundWood = 1 when You roll a 

# Update the amount of material left in the room when checking.
action (WatchForest) %MaterialLevel = 6 when enormous number remains to be found
action (WatchForest) %MaterialLevel = 5 when substantial number remains to be found.
action (WatchForest) %MaterialLevel = 4 when good number remains to be found.
action (WatchForest) %MaterialLevel = 3 when decent number remains to be found.
action (WatchForest) %MaterialLevel = 2 when small number remains to be found.
action (WatchForest) %MaterialLevel = 1 when scattering of resources remains to be found.
action (WatchForest) %MaterialLevel = 0 when Despite thoroughly exploring the area you fail to find any trees to chop.

# Does the room have workers to deed stone, or do we have to provide our own?
action (WatchForest) %DeedWorkers = 0 when This area has no workers present to help haul away your items.
action (WatchForest) %DeedWorkers = 1 when Loggers stand ready

# Immediately handle any dangerous conditions when they pop up.
action goto Danger when A monotonous buzzing sound fills the air.
action goto Danger when You notice an unusual smell drifting through the area.
action goto Danger when  A loud cracking sound resonates from somewhere closeby.

############################################################################

Main:
	action (Retry) off
	action (Lumberjacking) off

	gosub WatchForest
MainLoop:
	if ( %Success >= %MaterialLevel ) then
	{
		echo *** Success >= MaterialLevel
		gosub WatchForest
	}

	else
	{
		if ( %Failure > 5 ) then
		{
			echo *** Failure >= 5
			gosub WatchForest
		}
		else
		{
			echo *** Else
			gosub Chop
		}
	}
	
	goto MainLoop
	

WatchForest:
	%Failure = 0
	%Success = 0
	action (WatchForest) on
	action (Retry) on
	
	pause

	match WatchForestContinue Studying the forest
	match RoomEmpty Roundtime:
	put watch forest
	matchwait

WatchForestContinue:
	action (WatchForest) off
	action (Retry) off

	return


# Perform CHOP action
Chop:
	action (Lumberjacking) on
	action (Retry) on

	%FoundWood = 0

	pause

	put chop tree
	pause %SaftyPause

	action (Lumberjacking) off
	action (Retry) off
	
	if %FoundWood == 1 then
	{
		%Failure = 0
		math Success add 1
		
		if %FoundWood == 1 then math TotalWood add 1
		
		%FoundWood = 0
		
		gosub Collect
	}
	else
	{
		math Failure add 1
	}
	
	echo *** Failure = %Failure
	echo *** Success = %Success
	echo *** MaterialLevel = %MaterialLevel
	return


Collect:
	if matchre("$roomobjs", ("%MaterialKeepList")) then
	{
		var result $0
		if ( matchre("%result", ("%LumberDeed") ) then gosub Deed %result
		else
		{
			action (Retry) on
			put stow %result in %LumberStorage
			action (Retry) off
		}
	}
	return

Deed:
	var item $0
	
	action (Retry) on
	if ( %DeedWorkers = 1 ) then
	{
		put push $1
		pause
		put stow deed
	}
	else
	{
		put take packet
		pause
		put push %item with packet
		pause
		put stow packet
		pause
		put stow deed
	}
	action (Retry) off
	return
	
Danger:
	put #queue clear
	pause
	
	if %FoundWood == 1 then math TotalWood add 1

	#Might have found something up on the last chop
	gosub Collect

DangerFailure:
	action (WatchForest) on
	match DangerFailure Unfortunately, you are unable to find any way to avoid the danger.
	match DangerClear To remind yourself and warn other loggers of the danger, you stack a pile of stones as a warning signal.
	put watch forest danger
	matchwait

DangerClear:
	pause
	action (WatchForest) on
	action (Retry) on
	match MainLoop You scan the area for danger and find nothing of concern lurking within the nearby forest.
	match StillDanger Roundtime:
	put watch forest danger
	matchwait

StillDanger:
	echo WARNING: CONTINUED mining WILL BE DANGEROUS!
RoomEmpty:
	echo ===Total wood found = %TotalWood
	exit