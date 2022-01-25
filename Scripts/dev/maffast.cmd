# Needs to be integrated into generic spellcasting.

loop:
	put #script pause enc;#script pause geniehunter;#script pause hunt
	pause
#	put #send stop sing
#	waitforre you stop performing|But you're not performing anything|You stop performing
#	# put ret;ret
#	pause
#	put release all
	var prepped 0
	action var prepped 1 when You feel fully prepared to cast your spell
	put prep maf 10
	pause
	gosub harness
	put ret;ret
	pause
	gosub harness
	pause
	put ret;ret
	pause
	gosub harness
	pause
	put ret;ret
	pause
	if %prepped = 1 then goto cast
	waitfor You feel fully prepared to cast your spell
	goto cast

cast:
	pause
	send cast %1
	pause
	put #script resume enc
	pause 0.5
	put .retreat
	put #echo >Log Yellow MAF back up!;#parse MAF back up
	pause 10
	put #script resume all;#send 2 #parse you stop performing
	put #script abort retreat
	put #parse Face what?;#parse Roundtime;#parse Your target pattern is already formed;#parse The formation of the target pattern around
	exit

harness:
	pause 0.1
		matchre HARNESS ^\.\.\.wait|^Sorry, you may only type
		matchre return You tap into 
	put harness 10
	matchwait 10
	goto return
	
CAMB_HARNESS2:
	pause 0.1
		matchre CAMB_HARNESS2 ^\.\.\.wait|^Sorry, you may only type
		matchre CAMB_FOCUS dissipates|cannot harness|Something in the area|Something is damping|absorbs
	put charge my $cambrinth 24
	matchwait 10
	goto CAMB_FOCUS

CAMB_FOCUS:
	pause 0.1
	matchre CAMB_FOCUS ^\.\.\.wait|^Sorry, you may only type
	matchre RETURN Roundtime|Your link.*is intact|Something in the area|Something is damping
	put focus my $cambrinth
	matchwait 10
	goto RETURN

RETURN:
	return
