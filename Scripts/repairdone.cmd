# Consolidate into the repair stuff

#debug 10
#debug 5
#---------------------------------------
# INCLUDES
#---------------------------------------
goto SubSkip

Base.ListExtract:
		var Base.ListVar $1
		var Base.NounListVar $2
		var Base.ItemCountVar $3

		eval %Base.ListVar replace("%%Base.ListVar", ", ", "|")
		eval %Base.ListVar replacere("%%Base.ListVar", "( and )(?:a |an |some )(?!.*and (a |an |some ))","|")
		var %Base.ListVar |%%Base.ListVar
		eval %Base.ItemCountVar count("%%Base.ListVar", "|")
		var %Base.NounListVar %%Base.ListVar
Base.ListExtract.Loop.Trim:
		eval %Base.NounListVar replacere ("%%Base.NounListVar", "\|[\w'-]+ ", "|")
		if contains("%%Base.NounListVar", " ") then goto Base.ListExtract.Loop.Trim
return

#---------------------------------------
# Local Subroutines
#---------------------------------------

SubSkip:
pause 0.5

#---------------------------------------
# CONSTANT VARIABLES
#---------------------------------------

#---------------------------------------
# VARIABLES
#---------------------------------------
	var ItemList
	var NounList
	var MaxItemCount
	var Source
	var ItemCount 1
#---------------------------------------
# ACTIONS
#---------------------------------------
	action (sack) var ItemList $1 when ^In the .+ you see (.*)\.

#---------------------------------------
# SCRIPT START
#---------------------------------------
	Repair.Done.Check.Args:
		action (sack) off
		if ("$righthandnoun" != "sack") then
		{
			if matchre("$righthandnoun" = "rod|bellows|shovel|stamp|tongs|shovel|pickaxe|pliers") then put put my $righthandnoun in my $craftpack
			elseif ("$righthand" = "ball-peen hammer") then put put my $righthandnoun in my $craftpack
			else
			{
				put sheath my $righthandnoun
				put stow my $righthandnoun
			}
			pause 0.5
			put #parse Repair Done
			exit
		}
		action (sack) on

	Repair.Done.Get.Item.List:
		put look in my sack
		waitfor In the
		pause
		gosub Base.ListExtract ItemList NounList MaxItemCount
		goto Repair.Done.Get

	Repair.Done.Get:
		if (%ItemCount > %MaxItemCount) then goto Repair.Done.CheckSource
		put get %NounList(%ItemCount) from my sack
		waitforre You get|You remove 
		put wear my %NounList(%ItemCount)
		put stow my %NounList(%ItemCount)
		pause .5
		math ItemCount add 1
		goto Repair.Done.Get
	
	Repair.Done.CheckSource:
		match Repair.Done.Exit There is nothing in there.
		match Repair.Done.Fail You glance 
		put look in my sack
		put glance
		matchwait
	Repair.Done.Exit:
		put drop my sack
		put #parse Repair Done
		exit
	Repair.Done.Fail:
		echo ***
		echo ***
		echo Still Items in the sack! Get them out and type GO ON to continue
		echo ***
		echo ***
		waitfor GO ON
		goto Repair.Done.CheckSource
