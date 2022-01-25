# Needs to be integrated into BUFF / generic spellcasting.

start:
	if $GH_PARRYING = 1 then
	{
		matchre start_1 You are now set to|Setting your
		put stance set $shieldstance
		matchwait 2
		goto start
	}
start_1:
	var usecamb $usecamb
	if (tolower("%1") = "camb") then var usecamb 1
	if (tolower("%1") = "nocamb") then var usecamb 0
	put #script pause all except maf
songstop:
	pause
	matchre prep you stop performing|But you're not performing anything|You stop performing
	put #send stop sing
	matchwait 3
	goto songstop
	
prep:
	# put ret;ret
	pause
#	put release all
	var prepped 0
	var slipped 0
	action var prepped 1 when You feel fully prepared to cast your spell
	action var slipped 1 when Your concentration slips for a moment
	pause 0.5
	if %usecamb = 1 then goto use_camb
	else goto NO_CAMB
	
use_camb:
	matchre use_camb ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
	matchre camb_prepped You trace an arcane sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth
	put prep maf 12
	matchwait 2
	goto use_camb

camb_prepped:
	gosub CAMB_HARNESS1
	if %slipped = 1 then goto prep
	put harness 10
	if %slipped = 1 then goto prep
	if %prepped = 1 then goto cast
	waitfor You feel fully prepared to cast your spell
	goto cast

no_camb:
	matchre no_camb ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
	matchre no_camb_prepped You trace an arcane sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth
	put prep maf 20
	matchwait 2
	goto no_camb

no_camb_prepped:
	# put ret;ret
	pause
	gosub MAGIC_HARNESS 25
	#put ret;ret
	pause
	gosub MAGIC_HARNESS 25
	#put ret;ret
	pause
#	gosub MAGIC_HARNESS 20
	goto cast

cast:
	pause
	send cast %1
	pause
	put #script resume enc
	pause 0.5
	#put .retreat
	put #echo >Log Yellow MAF back up!;#parse MAF back up
	pause 10
	put #script resume all;#send 2 #parse you stop performing
	put #script abort retreat
	put #parse Face what?;#parse Roundtime;#parse Your target pattern is already formed;#parse The formation of the target pattern around
	exit
	
cast_1:
if $GH_PARRYING = 1 then
	{
		matchre cast_2 You are now set to|Setting your
		put stance set $parrystance
		matchwait 2
		goto cast_1
	}
cast_2:
exit

CAMB_HARNESS1:
	#put ret;ret
	pause
		matchre CAMB_HARNESS1 ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
		matchre CAMB_FOCUS dissipates|cannot harness|Something in the area|Something is damping
		match CAMB_HARNESS2 absorbs
	put charge my $cambrinth 24
	matchwait 10
	goto CAMB_HARNESS2
	
CAMB_HARNESS2:
	#put ret;ret
	pause
		matchre CAMB_HARNESS2 ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
		matchre CAMB_FOCUS dissipates|cannot harness|Something in the area|Something is damping|absorbs
	put charge my $cambrinth 24
	matchwait 10
	goto CAMB_FOCUS

CAMB_FOCUS:
	#put ret;ret
	pause
	matchre CAMB_FOCUS ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
	matchre RETURN You reach for its center and forge a magical link to it|Your link.*is intact|Something in the area|Something is damping
	put focus my $cambrinth
	matchwait 10
	goto RETURN

MAGIC_HARNESS:
	var mana $1
	MAGIC_HARNESS_1:
		matchre MAGIC_HARNESS_1 ^\.\.\.wait|^Sorry, you may only type|seem to be able to move to do that
		matchre return You tap into the mana from|You strain, but cannot harness
	put harness %mana
	matchwait

RETURN:
	return
