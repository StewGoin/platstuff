# Update for 3.0 and make more suitable to generic "waste time" situations.

put awaken
put #var GH_RANGED OFF;#var GH_MAGIC_TYPE OFF;#var GH_AMBUSH OFF;#var GH_MAGIC OFF;#var GH_XPTYPE ""

IF_1 goto start
	put .noafk
goto start

## includes
include includes.cmd
include cam.cmd
include origami.cmd

start:

	
loop:
#	put .assess
#	waitfor Script Done
	put #script abort enc;stop sing	
	pause
	put .cam
	waitfor Script Done
	pause
	gosub origami.start
	pause
	put .cam
	waitfor Script Done
	pause
#	put .scholarbook
#	waitfor Script Done
#	pause
#	put .collect 1
#	waitfor Script Done
#	pause
	put .reckus
	waitfor Script Done
	pause
	put #parse Twiddle Done
	exit

