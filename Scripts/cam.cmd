# Include in Base, etc...

## If including from another script
## Set %cambrinth and optionally %singlcast
var camcalled no
var singlecast no

cam.start:
#put #script abort enc;stop sing;rel all
var cambrinth $cambrinth
var cambcon $cambcon
var cambexp $cambexp
goto cam.charge

cam.check:
	match camb.worn that you are wearing.
	matchre camb.get You tap|you tap|is delicate
	put tap my %cambrinth
	matchwait 5
	goto cam.check

cam.expcheck:
#	put exp
#	waitfor EXP HELP
	if $Arcana.LearningRate > %cambexp then goto cam.done
	else goto cam.charge

camb.worn:
	var cambworn yes
	put remove my %cambrinth
	goto cam.expcheck
	
camb.get:
	var cambworn no
	put get my %cambrinth
	goto cam.expcheck

cam.fill:
	var camtype fill
	match cam.fill ...wait
	match cam.fill.focus dissipates
	match cam.fill absorbs
	match cam.chill cannot harness
	matchre return Something in the area|Something is damping
	put charge my $cambrinth 15
	matchwait 5
	goto cam.fill

cam.fill.focus:
	match cam.fill.focus ...wait
	matchre return You reach for its center and forge a magical link to it|Your link.*is intact|You focus your magical senses on
	matchre return Something in the area|Something is damping
	put focus my $cambrinth 3
	matchwait 5
	goto cam.fill.focus
	
cam.charge:
	if $mana < 10 then goto cam.chill
	var camtype charge
	match cam.charge ...wait
	match cam.prep dissipates
	match cam.expcheck absorbs
	match cam.chill cannot harness
	matchre cam.done Something in the area|Something is damping
	put charge my %cambrinth 15
	matchwait 5
	goto cam.charge
	
cam.focus:
	match cam.focus ...wait
	matchre cam.cast You reach for its center and forge a magical link to it|Your link.*is intact|You focus your magical senses
	matchre cam.done Something in the area|Something is damping
	put focus my %cambrinth
	matchwait 5
	goto cam.focus
	
cam.prep:
	match cam.prep ...wait
	match cam.focus Lay Ward
	match cam.release You are already preparing
	matchre cam.done Something in the area|Something is damping
	put prep LW
	matchwait 5
	goto cam.prep
	
cam.cast:
	match cam.cast.2 You feel fully prepared
	matchwait 15
	cam.cast.2:
	put cast
	if "%singlecast" = "yes" then goto cam.done
	goto cam.expcheck
cam.release:
	put release spell
	goto cam.prep
cam.chill:
	echo              Chillin'
	pause 10
	if $mana < 10 then goto cam.chill
	goto cam.%camtype
cam.done:
	pause
#	put wear my %cambrinth
#	put put my %cambrinth in my $cambcon
	if "%camcalled" != "no" then return
	put #parse Script Done
	exit
