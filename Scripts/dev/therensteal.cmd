# Steal in northern Therengia
## Starts inside Therenborough
include steal.cmd
START:
	var elbain.delkai tinderbox|tinderbox|tinderbox|tinderbox
	var theren.generalstore vanity.case|vanity.case|vanity.case|vanity.case
	var lang.netandbait berry.wine|berry.wine|berry.wine|berry.wine
	var lang.bowyershop short.bow|short.bow|short.bow|short.bow
	
	var total 0
	var caught 0
	var trivial 0

	put remove my $buckler;stow my $buckler
	pause 0.5
	put .aoff
	waitfor Armor Off
	put #var powerwalk 1
	gosub move 63
	put #var powerwalk 0
	gosub steal %theren.generalstore
	gosub move 251
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
		
	gosub move 249
	gosub steal %lang.netandbait
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 267
	gosub steal %lang.bowyershop
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 268 
	gosub steal %elbain.delkai
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	
DONE:
	gosub move 144
	put .aon
	waitfor Armor On
	echo *** You managed to steal %total items!
	if (%caught > 0) then echo *** You got caught %caught times!
	if (%trivial > 0) then echo *** %trivial items were trival, check log.
	put #parse Script Done
	exit