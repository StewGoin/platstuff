# Integrate with other repair scripts to make a single.

#debug 10
# ------------------------------------------------
# Auto Repairer Ver 1.0
# By VTCifer
# ------------------------------------------------


#---------------------------------------
# INCLUDES
#---------------------------------------
	include base.cmd
goto SubSkip
#---------------------------------------
# Local Subroutines
#---------------------------------------
	Set.Name:
		var Name $1
		return
SubSkip:

#---------------------------------------
# CONSTANT VARIABLES
#---------------------------------------
	var Repairer.List Ylono|Kamze
	var Item.List $Repair.Item.List
	eval MaxItems count("%Item.List","|")
#---------------------------------------
# VARIABLES
#---------------------------------------
	Var Name
	var CurrentItem -1
#---------------------------------------
# ACTIONS
#---------------------------------------

#---------------------------------------
# SCRIPT START
#---------------------------------------
	Start:
		if ("$lefthand" != "Empty") then gosub Base.Stow.Left
		if ("$righthand" != "Empty") then gosub Base.Stow.Right
		if matchre("$roomdesc" "(%Repairer.List)") then var Name $0
		if "%Name" = "" then exit
	Repair.All:
		match Repair.List.Loop I will not repair something that isn't broken.
		match NoMoney You will need more coin if I am to be repairing that!
		match Stow.Right Please don't lose this ticket!
		put ask %Name about repair all
		put ask %Name about repair all
		matchwait
		
	Repair.List.Loop:
		math CurrentItem add 1
		if (%CurrentItem > %MaxItems) then exit
		gosub Base.Get %Item.List(%CurrentItem)
		if ("$righthand" == "Empty" then goto Repair.List.Loop
	Repair.List.Item:
		match NoMoney You will need more coin if I am to be repairing that!
		match Stow.Right I will not repair something that isn't broken.
		match Stow.Right Please don't lose this ticket!
		put give %Name
		put give %Name
		matchwait
		
	Stow.Right:
		gosub Base.Stow.Right
		goto Repair.List.Loop
	NoMoney:
		exit
