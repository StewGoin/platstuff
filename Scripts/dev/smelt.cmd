debug 10
#MasterCraft - by the player of Jaervin Ividen
# A crafting script suite...
#v 0.1.6
#
# Script Usage: .smelt				--smelts material in a crucible
#
#   Place material in crucible and start script. Be sure to have all tools on you.
#

var BELTTOOLS OFF
var Action rod

action var Action shovel when As you complete working the fire dies down and needs more fuel.
action var Action bellows when and produces less heat from the stifled coals\.|is unable to consume its fuel\.
action var Action turn when Upon finishing you observe clumps of molten metal accumulating along the crucible's sides.
action var Action rod when ^push my bellows|^turn crucible|^push fuel with my shovel|^stir crucible with my rod
action goto end when At last the metal appears to be thoroughly mixed and you pour it into an ingot mold.
action goto Retry when \.\.\.wait|type ahead

if "$righthandnoun" != "rod" && "$righthand" != "Empty" then send stow right
if "$lefthandnoun" != "nugget" && "$lefthand" != "Empty" then send stow left
if "$righthandnoun" != "rod" then send get my rod
pause 1

Action:
save %Action
gosub %Action
goto Action

turn:
	 send turn crucible
	 pause 1
	return

bellows:
	if !contains("$righthandnoun", "bellows") then
	{
	 ###send stow right in $MC_FORGING.STORAGE
	 ###send get my bellows
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send push my bellows
	 pause 1
	return

shovel:
	if !contains("$righthandnoun", "shovel") then
	{
	 ###send stow right in $MC_FORGING.STORAGE
	 ###send get my shovel
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send push fuel with my shovel
	 pause 1
	return

rod:
	if !contains("$righthandnoun", "rod") then
	{
	 ###send stow right in $MC_FORGING.STORAGE
	 ###send get my rod
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send stir crucible with my rod
	 pause 1
	return
	
Retry:
	pause 1
	var Action %s
	goto Action
	
ToolStow:
	pause .5
	if "%BELTTOOLS" = "YES" then send tie my $righthandnoun to my belt
	else send put my $righthandnoun in my $MC_FORGING.STORAGE
	###Reset BELTTOOLS for a new Tool
	var BELTTOOLS NO
	return

ToolGet:
	pause .5
	###Action var will contain the tool to be used next (or turn if rod is next)
	if "%Action" = "turn" then send get my rod
	else send get my %Action
		match Untie You pull at it
		match ToolGot You get
	matchwait
	
Untie:
	pause .5
	var BELTTOOLS YES
	if "%Action" = "turn" then send untie my rod
	else send untie my %Action
	
ToolGot:
	return


end:
pause 1
echo
echo *** All done
echo
###send stow right in $MC_FORGING.STORAGE
gosub ToolStow