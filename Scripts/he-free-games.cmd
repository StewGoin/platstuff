# HE GAMES!
#var hekeepers alerce ring|audrualm ring|darkstone ring|glitvire ring|gloomwood ring|haralun ring|iroko ring|niello ring|quadrello|tiny amethyst|scorpion diamond|shark's tooth|potency crystal|infuser stone|diamond comb|sana'ati heart|heart garnet|potter's clay|silk fabric|animite ring|moonspun silk robe|silver torque|tickets|atulave

if $leechtime < $gametime then goto LEECHSTART
else goto DIGSTART

go_room:
		pause 1
		match good_move YOU HAVE ARRIVED
		match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return

	good_MOVE_2:
		PAUSE 1
		MATCH ACTION YOU HAVE ARRIVED
		MATCH good_MOVE_2 MOVE FAILED
		PUT #goto $1 $2
		MATCHWAIT
	ACTION:
		return

MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Obvious
   send %Dir
   matchwait


RETURN:
   return

LEECHSTART:
	# goto leeches
	gosub go_room 26
	gosub move go flap

LEECHLOOP:
	match LEECH_CHECK You just got a leech
	match LEECH_CHECK You bite down and come up with
	match LEECHLOOP You bite down but the leech slips
	put get leech
	matchwait 5
	goto LEECHLOOP

LEECH_CHECK:
	evalmath inttime $gametime + 630
	put #var leechtime %inttime
	gosub move go flap
	gosub go_room 22
	goto DIGCHECK

DIGSTART:
	if $roomid != 22 then gosub go_room 22

DIGLOOP:
	match DIGCHECK Roundtime
	put dig pile
	matchwait 5
	goto DIGLOOP


DIGCHECK:
	pause
	if matchre("$righthand", "$hekeepers") then
	{
		put stow $righthandnoun
		pause
	}
	elseif matchre("$righthand", "leech") then
	{
		put drop $righthandnoun
		pause
	}
	else
	{
		put put my $righthandnoun in bin
	}
	if $leechtime < $gametime then goto LEECHSTART
	else goto DIGLOOP