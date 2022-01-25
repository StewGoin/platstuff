# re-write this to be smarter and use arrays, etc..

put dig Ryken grave
pause
put gw $chestarmor
pause 0.5
put gw $headarmor
pause 0.5
put gw $handarmor
pause 0.5
put gw $legarmor
pause 0.5
put gw gweth
pause 0.5
put gw gweth
pause 0.5
put gw amuluet
pause 0.5
put gw locket
pause 0.5
put gw cloak
pause 0.5
put gw robes
pause 0.5
put gw charm
pause 0.5
put gw shield
pause 0.5
put gw rucksack
pause 0.5
put gw cotton.shirt
pause 0.5
put gw armband
pause 0.5
put gw band
pause 0.5
put gw band
pause 0.5
put gw ring
pause 0.5
put gw belt
pause 0.5
put gw pouch
pause 0.5
put gw pouch
pause 0.5
put gw envelope
pause 0.5
put gw tankard
pause 0.5
put gw pants
pause 0.5
put gw thigh.bag
pause 0.5
put gw boots
pause 0.5
put gw stick
pause 0.5
goto graveloop

graveloop:
	match emptygrave There is nothing in there.
	matchre graveitem grave you see .* (\w+)\.|
	put look in Ryken grave
	matchwait

emptygrave:
	exit

graveitem:
	put gw $1
	pause 0.5
	goto graveloop
