action var target $1 when (scoundrel|warrior|gentleman|farmer|scholar|mage|hunter)
action goto wand when ^You also see .* scoundrel|warrior|gentleman|farmer|scholar|mage|hunter
#action goto light when It's pitch dark and you can't see a thing!
#action goto pull when You also see a rope.
start:
pause

waitfor ALL DONE
goto start

WAND:
	send wave my wand at %target
	pause
	goto start