# Blast -- this uses a global VAR instead, so set it with the line below this one.

action var item $2 when , and you pull out (some|an?) (.*)\!$
action var item $2 when He rummages through the skippet and pulls (some|an?) (.*) from it,
action var score $1 when You got a score of (\d+)
action var ticket True when you pull out an orange-colored ticket

goto start

include includes.cmd

HEALUP:
    pause
    if $stunned = 1 then goto HEALUP
    if $standing != 1 then
    {
      put stand
      goto HEALUP
    }
    gosub move go arch
    gosub move nw
    gosub go_room clearing
    gosub move go path
    waitfor festive meeting portal
    gosub move go meeting.portal
    gosub go_room healer
    put join list
    goto HEALCHECK

HEALCHECK:
    waitfor Yrisa crosses Ryken's name from the list.
    gosub go_room portal
    gosub move go exit.portal
    gosub move go path
    waitfor [Paasvadh Forest, Clearing]
    gosub go_room boggle
    goto start


ALMANAC_CHECK:
  pause 0.5
  if $almanactime > $gametime then return
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  gosub get my almanac
  put study my almanac
  pause 0.5
  put stow my almanac
  pause 0.5
  return

start:
    pause 0.5
    if $bleeding = 1 then goto HEALUP
	gosub ALMANAC_CHECK
	var ticket False
	var score 0
	put give farmer 200 dokoras
	waitfor Obvious exits

# get bucket / throw
PUNKIN:
	if $stunned = 1 then
	{
		pause
		goto PUNKIN
	}
	if $standing != 1 then
	{
		put stand
		pause
		goto PUNKIN
	}
	pause 0.5
	put get pumpkin;load sling
	waitfor Roundtime
	pause
	match PRIZE You've taken all your shots
	matchre PUNKIN ^You have \d shots? remaining
	put fire sling
	matchwait 5
	goto PUNKIN

	
PRIZE:
	gosub move go door
	pause 0.5
	put get prize
	pause

CHECKPRIZE:
#check prize
	put #echo >Log Lime Score: %score Ticket: %ticket Item: %item
	#waitfor Go On.
	if matchre("$righthand", "$hekeepers") then
	{
		if matchre("%item", "simple \w+ ring") then put put my $righthandnoun in bucket
		if matchre("%item", "ornate \w+ ring") then put put my $righthandnoun in my bag
		if matchre("%item", "tickets") then put redeem my tickets
		if matchre("%item", "wallet") then put put my wallet in my backpack
		if matchre("%item", "infuser stone") then put put my stone in my backpack
		if matchre("%item", "potency crystal") then put put my crystal in my backpack
		pause 0.5
		if $righthandnoun !=  "" then put stow $righthandnoun
		pause 0.5

	}
	if "$righthandnoun" = "fan" then put close my fan
    if matchre("%item", "innocent-looking doll") then
    {
        put empty right
        pause
    }
	if $righthandnoun !=  "" then put put my $righthand in bucket;put my $righthandnoun in bucket

LOOPDELOOP:
	goto start
