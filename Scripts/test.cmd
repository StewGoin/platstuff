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
gosub list_pop boxes box
if "%box" = "trunkes" then goto DONE

LOOP:
	if (matchre("$roomobjs", "(\bbox\b|caddy|casket|chest|coffer|crate|skippet|strongbox|trunk)")) then echo $1
	else echo %box