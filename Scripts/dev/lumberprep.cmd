debug 10
#Lumber prep by Arvedui Iorlas
#Script loosely based on previous mastercraft suite scripts
#
# Script Usage: .lumberprep <item>		--runs lumber prep on the item

var BELTTOOLS OFF
var Action wood.saw
var lumber (stick|limb|branch|log)

include mc include.cmd

action var Action wood.saw when You begin sawing the ends|The blade vanishes as it cuts deeper into the wood
action var Action drawknife when At last you complete sawing through|You begin scraping the edge of the drawknife along|With most of the bark removed you begin focusing
action (work) goto Retry when \.\.\.wait|type ahead
action goto done when ready to be stacked with other lumber

first.cut:
	if matchre("$lefthandnoun", ("%lumber")) then send swap
	pause 1
	if !contains("$righthandnoun", "%Action") then
	{
	 gosub ToolStow
	 gosub ToolGet
	}
	matchre work Roundtime: \d+
	send cut my $righthandnoun with my %Action
	matchwait

work:
action (work) on
save %Action
gosub %Action
goto work

ToolStow:
	pause .5
	if "%BELTTOOLS" = "YES" then send tie my $lefthandnoun to my belt
	else send put my $lefthandnoun in my %engineering.storage
	###Reset BELTTOOLS for a new Tool
	var BELTTOOLS NO
	return

ToolGet:
	pause .5
	###Action var will contain the tool to be used next
	send get my %Action
		match Untie You pull at it
		match ToolGot You get
	matchwait
	
Untie:
	pause .5
	var BELTTOOLS YES
	send untie my %Action
	
ToolGot:
	return

wood.saw:
	if !contains("$lefthandnoun", "saw") then
	{
	 gosub ToolStow
	 gosub ToolGet
	}
	 send cut my $righthandnoun with my %Action
	 pause 1
	return

drawknife:
	if !contains("$lefthandnoun", "drawknife") then
	{
	 gosub ToolStow
	 gosub ToolGet
	}
	send scrape my $righthandnoun with my %Action
	pause 1
	return
	
Retry:
	pause 1
	var Action %s
	goto work

return:
	return

done:
	 gosub ToolStow
	 wait
	 put #parse LUMBER PREP DONE
	exit

