# fix this so the array isn't... lolwut
#var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox\b
var boxes box|caddy|casket|chest|coffer|crate|skippet|strongbox|trunk
var box null

var boxnum 1

put look in my portal

goto TOP
include includes.cmd

action put #echo >Log Gem Pouch Full when ^The pouch is too full to fit any more, and will need to be sold before using it again\.

TOP:
var typedone 0
gosub list_pop boxes boxtype
if "%boxtype" = "trunkes" then goto DONE

LOOP:
	gosub SKELE_GET
	if (matchre("$roomobjs", "(\bbox\b|caddy|casket|chest|coffer|crate|skippet|strongbox|trunk)")) then
	{
		var box $1
		gosub get %box
	}
	else
	{
		var box %boxtype
		gosub BOX_GET my %box
	}
	if %typedone = 1 then goto TOP
	put turn my key at my %box
	pause
	gosub put my skele.key in my cloak
	pause 0.2
	put open my %box
	pause 0.2
	GET_GEM:
		matchre REMOVE_POUCH You can't fit anything else in the \w+ gem pouch|already got a wealth of gems in the|any more room in the (\w+ )?gem pouch|You just can't get|You think the gem pouch is too full to fit another gem into|The pouch is too full to fit any more|The gem pouch is too full to fit any more gems|^You can't fill anything with a
		matchre GOT_GEM ^Stow what\?|^There aren't any gems|^You put your|^You open your pouch and put|^You open your gem pouch and quickly fill it with
		put fill my gem pouch with my $lootsack
		matchwait 2
		goto GET_GEM

	GOT_GEM:
	pause 0.2
	put tie my gem pouch
#	pause 0.2
#	put get coin from my %box
#	pause 0.2
#	put get coin from my %box
#	pause 0.2
#	put get coin from my %box
#	pause 0.2
#	put get coin from my %box
#	pause 0.2
#	put get coin from my %box
	pause 0.2
	put .moveitems my.%box deep.sash
	waitfor Done Moving Items.
	pause 0.2
	put put my %box in bucket
	put #parse Box Opened
	put #echo Box %boxnum
	math boxnum add 1
	goto LOOP

DONE:
	gosub put my skele.key in my cloak
	put #parse All Boxes Opened
	put fill my gem pouch with my deep.sash
	pause 0.5
	exit

BOX_GET:
	matchre RETURN ^You get|^You are already holding that
	match BOX_PORTAL What were you referring to
	put get my %box
	matchwait 2
  goto BOX_GET

BOX_PORTAL:
	match RETURN You get
	match BOX_MISSING What were you referring to
	put get %box from my portal
	matchwait 2
  goto BOX_PORTAL

BOX_MISSING:
	var typedone 1
	goto TOP

SKELE_GET:
	gosub get my skele.key from my cloak
	return

SKELE_STOW:
	gosub put my skele.key in my cloak
	return

REMOVE_POUCH:
	var LAST REMOVE_POUCH
		matchre NEW_POUCH ^You put
	put remove my gem pouch;put my gem pouch in my kirmiko.pocket
	matchwait 5
	goto REMOVE_POUCH


NEW_POUCH:
	var LAST NEW_POUCH
		match WEAR_POUCH You get
		match NO_MORE_ROOM_GEM What were you referring to
	put get gem pouch from my backpack
	matchwait 2
  goto NEW_POUCH

WEAR_POUCH:
	var LAST WEAR POUCH
	put wear my gem pouch
	waitforre You attach|You are already wearing
	goto GET_GEM

NO_MORE_ROOM_GEM:
	echo OUT OF POUCHES
	goto DONE