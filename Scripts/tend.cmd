# Fixup, cleanup, Base it.

var person my
IF_1 var person %1
if $bleeding = 0 then exit
else goto bleeding_check

include listsubs.cmd

tend_area:
		match tended Roundtime
		match lie_down will have to lie down for you 
		match bad_match That area is not bleeding
	put tend %person $1
	matchwait 5
	goto bad_match
	
tended:
	pause 0.5
	put #echo Tended %person $1
	return

lie_down:
	put #echo %person must lie down for you to tend.
	exit

bad_match:
	pause 0.5
	put #echo There was an error in matching $1.
	return

bleeding_check:
	var wounds temp
	action var wounds %wounds|right arm when ^\s+right arm\s+\S+$
	action var wounds %wounds|left arm when ^\s+left arm\s+\S+$
	action var wounds %wounds|right hand when ^\s+right hand\s+\S+$
	action var wounds %wounds|left hand when ^\s+left hand\s+\S+$
	action var wounds %wounds|head when ^\s+head\s+\S+$
	action var wounds %wounds|neck when ^\s+neck\s+\S+$
	action var wounds %wounds|right leg when ^\s+right leg\s+\S+$
	action var wounds %wounds|left leg when ^\s+left leg\s+\S+$
	action var wounds %wounds|chest when ^\s+chest\s+\S+$
	action var wounds %wounds|abdomen when ^\s+abdomen\s+\S+$
	action var wounds %wounds|back when ^\s+back\s+\S+$

	put health
	pause
	gosub list_removeat wounds 0
	gosub list_do wounds "tend %person"
	pause
	put #parse Done Tending
	exit






