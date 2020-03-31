#Steal in Riverhaven, starting east-side
include steal.cmd
START:
#	var haven.herb herb.pouch|herb.pouch|herb.pouch|herb.pouch
	var haven.clericshop blessed.incense|blessed.incense|blessed.incense|blessed.incense
	var haven.bardshop drum.stick|drum.stick|drum.stick|drum.stick
	var haven.drygoods herb.pouch|herb.pouch|herb.pouch|herb.pouch
	var haven.noelarms stiletto|stiletto|stiletto|stiletto
	
	var total 0
	var caught 0
	var trivial 0

	put remove my $buckler;stow my $buckler
	pause 0.5
	put .aoff
	waitfor Armor Off
	put #var powerwalk 1
#	gosub move 149
#	gosub steal %haven.herb
#	evalmath total %total + %c
#	evalmath caught %caught + %STEAL.caught
#	evalmath trivial %trivial + %STEAL.trivial
#	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 150
	gosub steal %haven.clericshop
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 200
	gosub steal %haven.drygoods
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 173
	gosub steal %haven.noelarms
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 158
	gosub steal %haven.bardshop
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
DONE:
	gosub move 63
	put .aon
	waitfor Armor On
	echo *** You managed to steal %total items!
	if (%caught > 0) then echo *** You got caught %caught times!
	if (%trivial > 0) then echo *** %trivial items were trival, check log.
	put #parse Script Done
	exit
