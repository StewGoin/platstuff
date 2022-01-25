# keep GH going when it errors


TOP:
	if contains("$scriptlist", "geniehunter.cmd") then goto WAITING
	else goto RESTART

RESTART:
	var GHCM "$GH_MULTI_CURR_NUM"
	pause
	put stow almanac
	pause 0.5
	put stow throw.axe;stow sis
	pause 0.5
	put stow cuska;stow spear
	pause 0.5
	put stow sphere;stow allarh
	pause 0.5
	put stow right;stow left
	pause 0.5
	put gm %GHCM
	put #echo >Log Red Restarted GenieHunter!
	goto WAITING

WAITING:
	delay 10
	goto TOP