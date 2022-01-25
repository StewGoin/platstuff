# This looks like Barn's -- see how it works.

# Combat Loader
cl.init:
eval mode tolower("%2")
eval weapon tolower("%1")
var weapon_type melee
if contains("%mode", "thrown") then var weapon_type thrown
if contains("%mode", "bow") then var weapon_type bow

var is_crossbow 0
var is_offhand 0
if "%weapon_type" = "bow" then {
	if matchre("%weapon","(crossbow|slurbow|arbalest|uanstaho|stonebow)") then  {
		var is_crossbow 1
	}
} else {
	if "%weapon_type" = "thrown" then {
		if contains("%mode", "offhand") then {
			var is_offhand 1
		}
	}
}
cl.checkhands:
	if is_offhand = 0 then {
		if "$righthand" = "Empty" then GOTO cl.get.weapon
		if contains("$righthand","%weapon") then goto start.combat
		if contains("$lefthand","%weapon") then goto cl.swap
	}
	if is_offhand = 1 then {
		if "$lefthand" = "Empty" then GOTO cl.get.weapon
		if contains("$righthand","%weapon") then goto cl.swap
		if contains("$lefthand","%weapon") then goto start.combat
	}
	if matchre("$lefthand","arrow|quadrello|bolt") then goto start.combat
	if "$righthand" != "Empty" && "$lefthand" = "Empty" then GOTO cl.stow.right
	if "$lefthand" != "Empty" && "$righthand" = "Empty" then GOTO cl.stow.left
	GOTO cl.get.weapon
cl.swap:
	PUT SWAP
	WAIT
	GOTO cl.checkhands
cl.stow.left:
	PUT STOW LEFT
	WAIT
	GOTO cl.checkhands
cl.stow.right:
	PUT STOW RIGHT
	WAIT
	GOTO cl.checkhands
cl.get.weapon:
	if "%weapon_type" = "bow" && %is_crossbow = 0 then {
		PUT GET %weapon FROM $container3
	} else {
		PUT GET %weapon FROM $container
	}
	waitforre ^You get
start.combat:
	shift
	match cl.stow.check COMBAT CRITTER DEAD
	match cl.stow COMBAT ABORT
	match cl.done COMBAT DEAD
	put .combat %0
	matchwait
cl.stow.check:
	if "%weapon_type" = "bow" then {
		goto cl.stow
	}
	goto cl.done
cl.stow:
	PAUSE .5
	PUT STOW %weapon
cl.done:
	exit
