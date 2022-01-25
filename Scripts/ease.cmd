# Seems pointless, needs to be mined for useful stuff for Base/includes and BUFF script

start:
	var usecamb $usecamb
	if (tolower("%1") = "camb") then var usecamb 1
	if (tolower("%1") = "nocamb") then var usecamb 0
	put #script pause enc;#script pause geniehunter;#script pause hunt
	pause
	put #send stop sing
	waitforre you stop performing|But you're not performing anything|You stop performing
	# put ret;ret
	pause
	put release all
	var prepped 0
	action var prepped 1 when You feel fully prepared to cast your spell
	pause 0.5
	if %usecamb = 1 then
	{
		put prep ease 11
		gosub CAMB_HARNESS1
		put harness 12
		if %prepped = 1 then goto cast
		waitfor You feel fully prepared to cast your spell
	}
	else
	{
		put prep ease 11
		gosub MAGIC_HARNESS 20
		gosub MAGIC_HARNESS 20
		gosub MAGIC_HARNESS 20
	}
	goto cast

cast:
	pause
	send cast %1
	put #script resume enc
	pause 0.5
	put #echo >Log Yellow EASE back up!;#parse EASE back up
	put #script resume geniehunter;#send 2 #parse you stop performing
	put #parse Face what?;#parse Roundtime;#parse Your target pattern is already formed;#parse The formation of the target pattern around
	put #script resume hunt
exit

CAMB_HARNESS1:
	put ret;ret
	pause 0.1
		matchre CAMB_HARNESS1 ^\.\.\.wait|^Sorry, you may only type
		matchre CAMB_FOCUS dissipates|cannot harness|Something in the area|Something is damping
		match CAMB_HARNESS2 absorbs
	put charge my $cambrinth 24
	matchwait 10
	goto CAMB_HARNESS2
	
CAMB_HARNESS2:
	put ret;ret
	pause 0.1
		matchre CAMB_HARNESS2 ^\.\.\.wait|^Sorry, you may only type
		matchre CAMB_FOCUS dissipates|cannot harness|Something in the area|Something is damping|absorbs
	put charge my $cambrinth 24
	matchwait 10
	goto CAMB_FOCUS

CAMB_FOCUS:
	put ret;ret
	pause 0.1
	matchre CAMB_FOCUS ^\.\.\.wait|^Sorry, you may only type
	matchre RETURN Roundtime|Your link.*is intact|Something in the area|Something is damping
	put focus my $cambrinth
	matchwait 10
	goto RETURN
	
MAGIC_HARNESS:
	var mana $1
	MAGIC_HARNESS_1:
	put ret;ret
	pause 0.1
		matchre MAGIC_HARNESS_1 ^\.\.\.wait|^Sorry, you may only type
		matchre return You tap into the mana from|You strain, but cannot harness
	put harness %mana
	matchwait

RETURN:
	return
