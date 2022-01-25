#####################################################
#######         Forging tool repair           #######
#######        Written by The Exoduss         #######
#######           v2.0 10/26/2017             #######
#####################################################
#
#
#I got tired of analyzing and repairing my tools manually... took too long..
#So this script should fix that!
#Its only made to repair forging equipment, although I am planning on adding support for all tools from all societies, once I get the techs.
# 
# Its simple to run, just copy and paste into a new script, and run it!
#
# It will automatically detect if you have the tools on a forge belt or not, and will tie them back if they were.. If not it will send your tools to your STOW location.
#debug 10
var BELTTOOLS YES

main:
	gosub gettool hammer 
	gosub gettool shovel
	gosub gettool pliers
	gosub gettool rod
	gosub gettool tongs
	gosub gettool bellows
	echo
	echo All done!
	echo
	exit

gettool:
	pause .5
	var tool $1
	send get %tool
	match untie You pull at
	match clean You get
	match next What were
	matchwait

untie:
	var BELTTOOLS YES
	pause .5
	send untie %tool
	waitforre ^You remove
	goto clean

next:
	put #echo >log #8000AA %tool not found, skipping.
	unvar tool
	return

clean:
	pause .5
	send get brush
	match clean2 You get
	match needstuff What were you
	matchwait

clean2:
	pause .5
	send scrape my %tool with brush
	match clean2 Roundtime
	match oilit The %tool appears ready to be oiled
	match stowit  is not damaged enough to warrant repair
	matchwait

oilit:
	pause .5
	send stow brush
	pause .5
	send get oil
	match oilit2 You get
	match needstuff What were you
	matchwait

oilit2:
	pause .5
	send pour oil on my %tool
	waitforre ^Roundtime
	pause 1
	send stow oil
	goto clean

stowit:
    pause .5
	if "%BELTTOOLS" = "YES" then send tie my %tool to my for belt
	else send stow my %tool
	pause .5
	if "$lefthandnoun" != "" then send stow $lefthandnoun
	send #echo >log %tool cleaned, going to next.
	var BELTTOOLS NO
	unvar tool
	return

needstuff:
	pause .5
	if "%BELTTOOLS" = "YES" then send tie my %tool to my for belt
	else send stow my %tool
	var BELTTOOLS NO
	unvar tool
	echo
	echo YOU NEED TO BUY SUPPLIES... OIL OR BRUSH
	echo 
	echo RUN SCRIPT AGAIN WHEN YOU HAVE THEM
	echo
	exit
	
	

