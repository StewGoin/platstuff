# compare to ingotmaker and see which to keep / integrate.

NO_NUGGET:
if (("$lefthandnoun" <> "rod") && ("$lefthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
if (("$righthandnoun" <> "rod") && ("$righthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack

pause .5
put .fix rod
waitfor ITEM FIXED
pause .5
put .fix shovel
waitfor ITEM FIXED
pause .5
put .fix bellows
waitfor ITEM FIXED

var SmeltQuick = 0
if ("%1" = "quick") then
{
	var SmeltQuick = 1
	shift
}

IF_2 goto FLUX
goto NEXT_STIR

FLUX:
if (("$lefthandnoun" <> "flux") || ("$righthandnoun" <> "flux")) then gosub get my borax flux
match TURN_CRUCIBLE Upon finishing you observe clumps of molten metal accumulating along the crucible's sides.
match NEED_BELLOWS As you finish the fire flickers and is unable to consume its fuel.
match NEED_FUEL As you complete working the fire dies down and needs more fuel.
match GOOD_STIR Roundtime:
put pour my flux into crucible
matchwait


NEXT_STIR:
if (("$lefthandnoun" <> "rod") || ("$righthandnoun" <> "rod")) then gosub get my stirring rod
match TURN_CRUCIBLE Upon finishing you observe clumps of molten metal accumulating along the crucible's sides.
match NEED_BELLOWS As you finish the fire flickers and is unable to consume its fuel.
match NEED_FUEL As you complete working the fire dies down and needs more fuel.
match GOOD_STIR Roundtime:
put stir cruc with my rod
matchwait

TURN_CRUCIBLE:
pause
if (("$lefthandnoun" <> "rod") && ("$lefthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
if (("$righthandnoun" <> "rod") && ("$righthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
pause
put turn cruc
pause
goto CHECK_INGOT_DONE

NEED_BELLOWS:
pause
if (("$lefthandnoun" <> "bellows") && ("$lefthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
if (("$righthandnoun" <> "bellows") && ("$righthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
pause .5
gosub get my bellows
put push my bellows
pause
gosub put my bellows in my $craftpack
goto CHECK_INGOT_DONE

NEED_FUEL:
pause 1
if (("$lefthandnoun" <> "shovel") && ("$lefthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
if (("$righthandnoun" <> "shovel") && ("$righthandnoun" <> "")) then gosub put my $righthandnoun in my $craftpack
pause
gosub get my shovel
put push fuel with my shovel
pause 10
gosub put my shovel in my $craftpack
goto CHECK_INGOT_DONE

GOOD_STIR:
pause
CHECK_INGOT_DONE:
if (("$lefthandnoun" = "flux") || ("$righthandnoun" = "flux")) then gosub put my borax flux in my $craftpack
match INGOT_DONE ingot
match NO_INGOT_YET You glance down
put glance
matchwait

INGOT_DONE:
pause .5
if %SmeltQuick = 0 then
{
	put anal %1 ingot
	pause 4
	put app %1 ingot careful
	pause 12
	}
gosub put %1 ingot in my $craftpack
pause .5
if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
put #parse Ingot Smelted
exit

NO_INGOT_YET:
pause .5
if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $craftpack
if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $craftpack
goto NEXT_STIR

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
