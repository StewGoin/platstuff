# Entrail Toss
goto start

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

start:

#Pay crone
	put give crone 500 dokoras
	waitfor Obvious exits

# get bucket / throw
BUCKET:
	pause 0.5
	match THROW You reach into the Bucket
	match PRIZE Yer've had yer five tosses o' guts
	put get bucket
	matchwait 5
	goto BUCKET

THROW:
	pause 0.5
	put throw $righthandnoun at skeleton
	waitfor Roundtime
	goto BUCKET

#ask ghoul for prize
PRIZE:
	pause 0.5
	match CHECKPRIZE The battered ghoul hands you your prize
	match LOOPDELOOP The battered ghoul shakes his head
	put ask ghoul about prize
	matchwait 5

CHECKPRIZE:
#check prize
	gosub move east
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
		put put my $righthandnoun in bucket
	}
	gosub move west
LOOPDELOOP:
	gosub move go gap
	goto start
#loop