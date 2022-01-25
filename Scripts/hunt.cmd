# Cleanup and such.

var hunting on
if_1 var hunting off

start:
	timer clear
	timer start
	goto timeloop

timeloop:
	delay 5
  	if $GH_NOHUNT = 1 then goto timeloop
	if (%t > 80) then goto skillcheck
	goto timeloop

skillcheck:
	if $Perception.LearningRate >= 32 then goto start
	else goto hunt

hunt:
#	if (($sleep = 1) || ("$GH_AMBUSH" = "ON") || ("$GH_MAGIC_TYPE" != "OFF") || ("$GH_BACKTRAIN" = "ON")) then goto start
	if ("%hunting" = "on") then waitforre Roundtime|There is nothing else to face
	put #script pause geniehunter;#script pause bob
	pause

		matchre hunt ^\.\.\.wait|you may only type
		matchre exit You find yourself unable to hunt
		matchre restart Roundtime
	send 2 hunt
	matchwait 10
	goto restart

restart:
	pause 0.5
	put #script resume geniehunter;#script resume bob
	put #parse Roundtime
#	put #parse You tap into the mana from
#	delay 2
#	put #parse Your target pattern is already formed
#	put #parse The formation of the target pattern around
	put #parse Face what?
	put #parse You think you have your best shot possible now.
	goto start

exit:
exit
	
