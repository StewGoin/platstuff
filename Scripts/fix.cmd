# Cleanup and consider incorporate into includes/Base
#debug 5
### USAGE: .fix <item to fix>
### You need to have your wire brush and flask of oil

if ("%1" = "") then
{
	echo USAGE: .fix <item to fix>
	exit
}

#GOTO END2

MAIN:
	if ("$righthandnoun" <> "") then gosub stow right
	if ("$lefthandnoun" <> "") then gosub stow left
	pause
	action var itemcon $1 when ^You get.* (\w+)\.
  action var itemcon $1 when ^You are already (holding) that\.
  action var itemcon $1 when ^But that is already in your (inventory)\.
  if "%1" = "throwing.axe" then gosub get my %1 from my $pack
	else gosub get my %1
	action remove ^You get.* (\w+)\.
  action remove ^You are already (holding) that\.
  action remove ^But that is already in your (inventory)\.

BRUSH:	
	gosub get my wire brush
	pause 0.5
  if "%itemcon" = "inventory" then
    {
      pause 0.5
      put remove my %1
      pause 0.5
    }
  if "%1" = "throwing.axe" then var itemcon sheath
BRUSH_1:
	match BRUSH You must be holding the wire brush to do that.
  match BRUSH You must be holding the brush to do that.
	match NOFIX does not need repair.
	matchre NOFIX not damaged enough to warrant repair\.|You cannot do that while engaged\!
	match OIL appears ready to be oiled.
	put rub my %1 with my wire brush
	matchwait 2
	goto BRUSH_1

OIL: 	
	gosub put my wire brush in my $craftpack
	gosub get my oil from my $craftpack
	pause 0.5
OIL_1:
	matchre OIL ^You rub
#	match RECHECK Roundtime
  match NOFIX Roundtime
	put pour my oil on my %1
	matchwait 2
	goto OIL_1

RECHECK:
	goto BRUSH
	
NOFIX:
	if matchre("oil", "$righthandnoun|$lefthandnoun") then gosub put my oil in my $craftpack
	gosub put my wire brush in my $craftpack

END:
  if "%itemcon" = "holding" then goto END2
  if "%itemcon" = "inventory" then
  {
    pause 0.5
    put wear my %1
    goto END2
  }
	if %itemcon <> "" then gosub put my %1 in my %itemcon
END2:
  pause 0.5
	put #parse ITEM FIXED
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
	 matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up|^But that is already in your inventory\.
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
