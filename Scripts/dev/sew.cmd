#debug 10
#MasterCraft - by the player of Jaervin Ividen
# A crafting script suite...
#v 0.1.6
#
# Script Usage: .sew <item>						--sews the item
#				.sew <item> <no. of times>		--to sew more than one, assuming you have enough material
#
#   This script is used in conjunction with the mastercraft.cmd script, and is used to produce cloth and leather items. To use it, hold the
#	material to be used, study your instructions, then start the script. Be sure to have all the relevant tailoring tools in your outfitting bag,
#	as well as any parts to be assembled. If you have a Maker's Mark, be sure that it is also on you if your character profile in MC INCLUDE.cmd
#	is toggled to mark items.
#
#	If you are holding an unfinished item instead, this script will try to finish it for you.
#

var BELTTOOLS OFF
var sew.repeat 0
if_2 var sew.repeat %2
if_1 put #var MC.order.noun %1
var tool sew.needle
var pins.gone 0
include mc include.cmd


action var tool yardstick when could benefit from some remeasuring.*|be benefited by remeasuring
action var tool scissors when now it is time to cut away more of the \S+ with scissors.*|appears ready for further cutting with some scissors.
action var tool pins when could use some pins to.*|is in need of pinning
action var tool slickstone when ^A deep crease develops along the fabric.*|The fabric develops wrinkles from.*|RUB
action var tool awl when needs holes punched.*|requires some holes punched
action var tool assemble when ASSEMBLE Ingredient1 WITH Ingredient2
action var tool done when Applying the final touches, you complete working|^You realize that cannot be repaired
action var tool sew.needle when ^measure my \S+ with my yardstick|^rub my \S+ with my slickstone|poke my \S+ with my pins|^poke my \S+ with my awl|^cut my \S+ with my scissors|pushing it with a needle and thread
action (work) goto Retry when \.\.\.wait|type ahead
action (work) off

action (order) var thread.order $1 when (\d+)\)\..*yards of cotton thread.*(Lirums|Kronars|Dokoras)
action (order) var pins.order $1 when (\d+)\)\..*some straight iron pins.*(Lirums|Kronars|Dokoras)
action var pins.gone 1 when ^The pins is all used up, so you toss it away.
action var thread.gone 1 when ^The last of your thread is used up with the sewing.|^The needles need to have thread put on them
action (order) off

action var assemble $1 padding when another finished (small|large) cloth padding 
action var assemble $1 when another finished \S+ shield (handle)
action var assemble $1 $2 when another finished (long|short|small|large) leather (cord|backing)

unfinished:
	send glance
	waitforre ^You glance down (.*)\.$
	pause 1
	if contains("$0", "unfinished") then
	{
	send analyze my $MC.order.noun
	waitforre ^You.*analyze
	if !contains("$righthandnoun", "$MC.order.noun") then send swap
	pause 1
	goto work
	}

first.cut:
	if (contains("$righthandnoun", "cloth") || contains("$lefthandnoun", "cloth")) then var material cloth
	if (contains("$righthandnoun", "leather") || contains("$lefthandnoun", "leather")) then var material leather
	 pause 1
	###if contains("%material", "$lefthandnoun") then send swap
	if "$lefthandnoun" = "%material" then send swap
	 pause 1
 	if !contains("$lefthandnoun", "scissors") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my scissors
	 ###waitforre ^You get
	 var tool scissors
	 gosub ToolStow
	 gosub ToolGet
	}
	 matchre excess You carefully cut off the excess material and set it on the ground.
	 matchre work Roundtime: \d+
	 send cut my %material with my scissor
	matchwait

excess:
	 pause 1
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###waitforre ^You put
	 gosub ToolStow
	 var tool sew.needle
	 send get %material
	 send put %material in my %outfitting.storage
	waitforre ^You put

work:
	action (work) on
	save %tool
	 if "%tool" = "done" then goto done
	 gosub %tool
	goto work
	
ToolStow:
	pause .5
	if "%BELTTOOLS" = "YES" then send tie my $lefthandnoun to my belt
	else send put my $lefthandnoun in my %outfitting.storage
	###Reset BELTTOOLS for a new Tool
	var BELTTOOLS NO
	return

ToolGet:
	pause .5
	###Action var will contain the tool to be used next
	send get my %tool
		match Untie You pull at it
		match ToolGot You get
	matchwait
	
Untie:
	pause .5
	var BELTTOOLS YES
	send untie my %tool
	
ToolGot:
	return

sew.needle:
	if %thread.gone = 1 then gosub new.tool
	if !contains("$lefthandnoun", "needles") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my sewing needle
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send push my $MC.order.noun with my needle
	 pause 1
	return

yardstick:
	if !contains("$lefthandnoun", "yardstick") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my yardstick
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send measure my $MC.order.noun with my yardstick
	 pause 1
	return

slickstone:
	if !contains("$lefthandnoun", "slickstone") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my slickstone
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send rub my $MC.order.noun with my slickstone
	 pause 1
	return

pins:
	if %pins.gone = 1 then gosub new.tool
	if !contains("$lefthandnoun", "pins") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my pins
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send poke my $MC.order.noun with my pins
	 pause 1
	return
	
scissors:
	if !contains("$lefthandnoun", "scissors") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my scissors
	 ###waitforre ^You get
	 gosub ToolStow
	 gosub ToolGet
	}
	 send cut my $MC.order.noun with my scissors
	 pause 1
	return

awl:
	if !contains("$lefthandnoun", "awl") then
	{
	 ###send put my $lefthandnoun in my %outfitting.storage
	 ###send get my awl
	 ###waitforre ^You get
	}
	 send poke my $MC.order.noun with my awl
	 pause 1
	return
	
assemble:
	if "$lefthandnoun" != "%assemble" then
	{
	 pause 1
	 ###send put my $lefthandnoun in my %outfitting.storage
	 gosub ToolStow
	 send get my %assemble
	 waitforre ^You get
	}
	 send assemble my $MC.order.noun with my %assemble
	 pause 1
	 send analyze my $MC.order.noun
	 pause 1
	return

new.tool:
if contains("$scriptlist", "mastercraft.cmd") then
	{
	action (work) off
	 var temp.room $roomid
	 gosub check.location
	if %pins.gone = 1 then
		{
		 gosub automove %tool.room
		 if !("$righthand" = "Empty" || "$lefthand" = "Empty") then send put my $MC.order.noun in my %outfitting.storage
		 action (order) on
		 send order
		 pause .5
		 action (order) off
		 gosub purchase order %pins.order
		 send put my pins in my %outfitting.storage
		 if "$righthandnoun" != "$MC.order.noun" && "$lefthandnoun" != "$MC.order.noun" then send get my $MC.order.noun from my %outfitting.storage
		 pause .5
		 var pins.gone 0
		}
	if %thread.gone = 1 then
		{
		 gosub automove %supply.room
		 if !("$righthand" = "Empty" || "$lefthand" = "Empty") then send put my $MC.order.noun in my %outfitting.storage
		 action (order) on
		 pause 1
		 send order
		 pause .5
		 action (order) off
		 gosub purchase order %thread.order
		 wait
		 send put my thread on my sew.needles
		 waitforre ^You carefully thread
		 if "$righthandnoun" != "$MC.order.noun" && "$lefthandnoun" != "$MC.order.noun" then send get my $MC.order.noun from my %outfitting.storage
		 var thread.gone 0
		}
	 gosub automove %temp.room
	 unvar temp.room
	action (work) on
	return
	}
else
{
echo *** Out of pins or thread! Go get more!
exit
} 

purchase:
     var purchase $0
     goto purchase2
purchase.p:
     pause 0.5
purchase2:
     matchre purchase.p type ahead|...wait|Just order it again
	 matchre lack.coin you don't have enough coins|you don't have that much
     matchre return pay the sales clerk|takes some coins from you
	 put %purchase
    matchwait

lack.coin:
	 if contains("$scriptlist", "mastercraft.cmd") then put #parse LACK COIN
	 else echo *** You need some startup coin to purchase stuff! Go to the bank and try again!
	exit

return:
return

Retry:
	pause 1
	var tool %s
	goto work
	
repeat:
	math sew.repeat subtract 1
	send put my $MC.order.noun in my %outfitting.storage
	waitforre ^You put
	send get my tailor book
	send study my book
	waitforre Roundtime
	send put my book in my %outfitting.storage
	send get my %material
	waitforre ^You get
	var tool needle
	goto first.cut


done:
	if %pins.gone = 1 then gosub new.tool
	if %thread.gone = 1 then gosub new.tool
	 ###send put my $lefthandnoun in my %outfitting.storage
	 gosub ToolStow
	 wait
	 gosub mark
	 pause 1
	 if %sew.repeat > 1 then goto repeat
	 put #parse SEWING DONE
	exit