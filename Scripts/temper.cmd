# Integrate, etc...

### Weapon Tempering

if ("%1" = "") then
{
	echo USAGE .temper <weapon>
	exit
}
else put #var temperitem %1

pause 0.5
gosub get my $temperitem

BEGIN:
	pause 1
	if matchre(tolower("$lefthandnoun"), "$temperitem") then
	{
		put swap
		goto BEGIN
	}
	gosub put my $lefthandnoun in my $craftpack
	gosub get my $tongs
	
START_TEMPER:
	match OIL need to be cleaned of the clay by pouring oil on it.
	match OIL needs to be cleaned of the clay by pouring oil on it.
	match OIL need of some oil to preserve and protect it.
	matchre NEED_BELLOWS ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS ^As you finish working the fire dims and produces less heat from the stifled coals
	matchre NEED_FUEL ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL ^As you complete working the fire dies down and appears to need some more fuel
	match NO_PROBLEM Roundtime:
	put put my $temperitem on forge
	matchwait 2
	goto START_TEMPER

NEXT_TURN:
	match OIL need to be cleaned of the clay by pouring oil on it.
	match OIL needs to be cleaned of the clay by pouring oil on it.
	match OIL need of some oil to preserve and protect it.
	matchre NEED_BELLOWS ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS ^As you finish working the fire dims and produces less heat from the stifled coals
	matchre NEED_FUEL ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL ^As you complete working the fire dies down and appears to need some more fuel
	match NO_PROBLEM Roundtime:
	put turn $temperitem on forge with my $tongs
	matchwait 5
	goto NEXT_TURN

NEED_BELLOWS:
	gosub get bellows from my $craftpack
NEED_BELLOWS_1:
	match OIL need to be cleaned of the clay by pouring oil on it.
	match OIL needs to be cleaned of the clay by pouring oil on it.
	match OIL need of some oil to preserve and protect it.
	matchre NEED_BELLOWS_1 ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS_1 ^As you finish working the fire dims and produces less heat from the stifled coals
	matchre NEED_FUEL ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL ^As you complete working the fire dies down and appears to need some more fuel
	match NO_PROBLEM Roundtime:
	put push my bellows
	matchwait 2
	goto NEED_BELLOWS_1

NEED_FUEL:
	pause .5
	if (("$lefthandnoun" <> "tongs") && ("$lefthandnoun" <> "")) then gosub PUT my $lefthandnoun in my $craftpack
	pause .5
	gosub GET my tongs
  	gosub ADJUST_SHOVEL
NEED_FUEL_1:
	match TONG_OIL need to be cleaned of the clay by pouring oil on it.
	match TONG_OIL needs to be cleaned of the clay by pouring oil on it.
	match TONG_OIL need of some oil to preserve and protect it.
	matchre NEED_BELLOWS ^As you finish the fire flickers and is unable to consume its fuel
	matchre NEED_BELLOWS ^As you finish working the fire dims and produces less heat from the stifled coals
	matchre NEED_FUEL_1 ^As you complete working the fire dies down and needs more fuel
	matchre NEED_FUEL_1 ^As you complete working the fire dies down and appears to need some more fuel
	match TONG_GOOD_POUND Roundtime:
	put push fuel with my tongs
	matchwait 2
	goto NEED_FUEL_1

NO_PROBLEM:
	if "$lefthandnoun" != "" then gosub put my $lefthandnoun in my $craftpack
	if "$righthandnoun" != "" then gosub put my $righthandnoun in my $craftpack
	gosub get my $tongs
	pause 0.5
	goto NEXT_TURN

ADJUST_SHOVEL:
  match RETURN You lock the tongs into a fully extended position.  Then you reach alongside the tong's body, and pull free the head of a shovel.
  match ADJUST_SHOVEL With a yank you fold the shovel head back alongside the tong's body.  Then you unlock the arms, readying them for use as tongs once more.
  put adjust my tongs
  matchwait 1
  goto ADJUST_SHOVEL

ADJUST_TONGS:
  match RETURN With a yank you fold the shovel head back alongside the tong's body.  Then you unlock the arms, readying them for use as tongs once more.
  match ADJUST_TONGS You lock the tongs into a fully extended position.  Then you reach alongside the tong's body, and pull free the head of a shovel.
  put adjust my tongs
  matchwait 1

TONG_GOOD_POUND:
  gosub ADJUST_TONGS
  GOTO NO_PROBLEM

TONG_OIL:
  gosub ADJUST_TONGS
  GOTO OIL

OIL:
	gosub put my $lefthandnoun in my $craftpack
	gosub put my $tongs in my $craftpack
	gosub get $temperitem from forge
	gosub get oil from my $craftpack
OIL_1:
	match OILED Roundtime
	put pour my oil on my $temperitem
	matchwait 2
	goto OIL_1
OILED:
	gosub put my oil in my $craftpack
#	put anal my $temperitem
#	pause
#	put app my $temperitem careful
	pause
	put #parse Item Tempered
	exit
	
### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts	

PUT:
	var put $0
PUT.1:
  matchre PUT.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	put put %put
	matchwait 2
	goto PUT.1

GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up
   send get %Get
   matchwait 2
	 goto GET.2

STOW:
   var Stow $0
STOW.2:
   pause .2
   matchre STOW.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You put (a|an|some|your|the)|Stow what\?
   send stow %Stow
   matchwait 2
	 goto STOW.2

RETURN:
	return
