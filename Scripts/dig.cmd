var keepers alerce ring|audrualm ring|darkstone ring|glitvire ring|gloomwood ring|haralun ring|iroko ring|niello ring|tiny pine coffin

	evalmath inttime $gametime + 3660
	put #var raventime %inttime

loop:
	match KEEPCHECK Roundtime
	put dig %1
	matchwait 5
	goto loop


KEEPCHECK:
	pause 1
	if contains("$righthand", "%keepers") then
	{
		put stow $righthandnoun
	}
	else
	{
		put put my $righthandnoun in bin
	}
	goto loop