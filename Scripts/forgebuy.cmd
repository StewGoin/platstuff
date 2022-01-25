# FIX cleanup validate and consider Base/gosub usage

debug 5
#buy stuff
# .forgebuy <item>

if matchre(tolower("%1"), "(br|oi|be)") then
{
	if "$1" = "br" then var Item Brush
	if "$1" = "be" then var Item Bellows
	if "$1" = "oi" then var Item Oil
}
else
{
	echo USAGE .forgebuy <brush|oil|bellows> (amount)
	exit
}
	
var OrderOil 6
var OrderBrush 10
var OrderBellows 5
var ItemCount 0
var ItemMax 2
if_2 var ItemMax %2

GO_TO_STORE:
	var ReturnRoom $roomid
	if (($zoneid = 30) && ($roomid != 402)) then gosub go_room 402
	if (($zoneid = 67) && ($roomid != 653)) then gosub GO_ROOM 653
	goto BUY_ITEM


BUY_ITEM:
if %ItemCount < %ItemMax then
{
	put order %Order%Item;order %Order%Item
	pause 0.5
	gosub put my %Item in my $craftpack
	pause 0.5
	math ItemCount add 1
	goto BUY_ITEM
}
else goto DONE

DONE:
	gosub GO_ROOM %ReturnRoom
	put #parse Item Bought
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
	 match NO_%Get What were you referring to?
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

go_room:
	pause 1
	match good_move YOU HAVE ARRIVED
	match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return
	
MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Obvious
   send %Dir
   matchwait
