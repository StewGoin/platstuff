# Fixup, cleanup, integrate into a better repair script
debug 5
	put stow right;stow left;sheath

	equipping:
  	pause
  		if $righthandnoun != "" then put wear my $righthandnoun
		match items_stow You get
		match equipped What were you referring to
			put get my %1 ticket
		matchwait 3
  goto equipping

	items_stow:
	put give %1
#	waitforre You hand|frowns and says
#	if matchre("$righthand", "sack") then waitfor Sack Done
#	else put stow my $righthandnoun
#  pause 2
  waitfor Repair Done
	goto equipping
	
	equipped:
	put #parse Script Done
	exit
