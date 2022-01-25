#start (fail here: 5 BS), barrel (10 BS), log (15 BS), platform (20 BS), crate (100 BS)

action goto EXIT when One of Plixbraggle's goats appears out of nowhere and headbutts you!   You're knocked back outside!
action put #echo >Log Cyan $1 when In the leather package you see (.*)

# where the lewt goes -- use my.
var container my.pale.pouch

# take random pauses if you want (set userand to 1 to be random, randmin to lower bound, randmax to upper bound)
var randmin 2
var randmax 6
var userand 0

# pauses to take in each room as you progress
var ladderpause 0.5
var barrelpause 0.5
var trunkpause 0.5
var logpause 0.5
var polepause 0.5

goto START2
include moveitems.cmd

START:
put .goatwerx
pause 0.5
START2:
if $standing = 0 then
{
	pause 0.5
	put stand
	goto START
}

HANDCHECK:
if ("$righthandnoun" = "package" || "$lefthandnoun" = "package") then
{
	pause 0.5
	put open my package
	pause 0.3
	put get my bloodscrip from my.package
	put redeem my bloodscrip
	gosub moveitems my.package %container
	gosub put my package in basket
}
if ("$righthand" != "Empty" || "$lefthand" != "Empty") then
{
	put stow left;stow right
	pause 0.5
	goto HANDCHECK
}

# [Plixbraggle's Goat-Werx]
ROOM_0:
	match ROOM_1 [Plixbraggle's Goat Agility Course, Ladder]
	put climb ladder
	matchwait 1
	goto ROOM_0

# [Plixbraggle's Goat Agility Course, Ladder]
ROOM_1:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_1
	}
	if %userand = 1 then
	{
		random %randmin %randmax
		pause %r
	}
	else pause %ladderpause
	match START [Plixbraggle's Goat-Werx]
	match ROOM_2 [Plixbraggle's Goat Agility Course, Barrel Top]
	put go barrel
	matchwait 2
	goto ROOM_1

# [Plixbraggle's Goat Agility Course, Barrel Top]
ROOM_2:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_2
	}
	if %userand = 1 then
	{
		random %randmin %randmax
		pause %r
	}
	else pause %barrelpause
	if "$roomname" = "Plixbraggle's Goat-Werx" then goto START
	match START [Plixbraggle's Goat-Werx]
	match ROOM_3 [Plixbraggle's Goat Agility Course, The Trunks]
	put go trunk
	matchwait 2
	goto ROOM_2

# [Plixbraggle's Goat Agility Course, The Trunks]
ROOM_3:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_3
	}
	if %userand = 1 then
	{
		random %randmin %randmax
		pause %r
	}
	else pause %trunkpause
	if "$roomname" = "Plixbraggle's Goat-Werx" then goto START
	match START [Plixbraggle's Goat-Werx]
	match ROOM_4 [Plixbraggle's Goat Agility Course, The Log]
	put go log
	matchwait 2
	goto ROOM_3

# [Plixbraggle's Goat Agility Course, The Log]
ROOM_4:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_4
	}
	if %userand = 1 then
	{
		random %randmin %randmax
		pause %r
	}
	else pause %logpause
	if "$roomname" = "Plixbraggle's Goat-Werx" then goto START
	match START [Plixbraggle's Goat-Werx]
	match ROOM_5 [Plixbraggle's Goat Agility Course, Pole]
	put go platform
	matchwait 2
	goto ROOM_4

# [Plixbraggle's Goat Agility Course, Pole]
ROOM_5:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_5
	}
	if %userand = 1 then
	{
		random %randmin %randmax
		pause %r
	}
	else pause %polepause
	if "$roomname" = "Plixbraggle's Goat-Werx" then goto START
	match START [Plixbraggle's Goat-Werx]
	match ROOM_WIN [Plixbraggle's Goat Agility Course, Crates]
	put go crate
	matchwait 2
	goto ROOM_5

# [Plixbraggle's Goat Agility Course, Crates]
ROOM_WIN:
	if $standing = 0 then
	{
		pause 0.5
		put stand
		goto ROOM_WIN
	}
	pause 0.5
	if "$roomname" = "Plixbraggle's Goat-Werx" then goto START
	match ROOM_ROPE [Plixbraggle's Goat Agility Course, Finish Line]
	put down
	matchwait 2
	goto ROOM_WIN

# [Plixbraggle's Goat Agility Course, Finish Line]
ROOM_ROPE:
	pause 0.5
	put pull rope
	echo You Win!
	put #echo >Log You Win!
	goto START

EXIT:
	exit


PUT:
	var put $0
PUT.1:
  pause .1
  matchre PUT.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	send put %put
	matchwait 1
	goto PUT.1

RETURN:
	return
