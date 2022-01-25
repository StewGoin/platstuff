#Steal in Riverhaven, starting east-side
include steal.cmd
START:
	var crossing.locksmith ordinary.lockpick|ordinary.lockpick|ordinary.lockpick|ordinary.lockpick
	var crossing.bard bones|bones|bones|bones
	var crossing.bath soap.in.basin|soap.in.basin|soap.in.basin|soap.in.basin
	var crossing.cleric chalice|chalice|chalice|chalice
	var crossing.general heavy.rope|heavy.rope|heavy.rope|heavy.rope
	var crossing.jewler stud|stud|stud|stud
	var crossing.stitch sash|sash|sash|sash
	var crossing.armor leather.helm|leather.helm|leather.helm|leather.helm
	var crossing.weapon cudgel|cudgel|cudgel|cudgel
	var crossing.cobbler hose|hose|hose|hose
	var crossing.alch pestle|pestle|pestle|pestle
	var crossing.tanner stout.thread|stout.thread|stout.thread|stout.thread
	var crossing.haber vest|vest|vest|vest
	
	var total 0
	var caught 0
	var trivial 0

	put remove my $buckler;stow my $buckler
	pause 0.5
	put .aoff
	waitfor Armor Off
	put #var powerwalk 1
	gosub move 219
	gosub steal %crossing.locksmith
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 510
	gosub steal %crossing.bard
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 344
	gosub steal %crossing.bath
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 517
	gosub steal %crossing.cleric
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 190
	gosub steal %crossing.general
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 398
	gosub steal %crossing.jewler
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 546
	gosub steal %crossing.stitch
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 193
	gosub steal %crossing.armor
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 192
	gosub steal %crossing.weapon
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 547
	gosub steal %crossing.cobbler
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 227
	gosub steal %crossing.alch
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 223
	gosub steal %crossing.tanner
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
	gosub move 555
	gosub steal %crossing.haber
	evalmath total %total + %c
	evalmath caught %caught + %STEAL.caught
	evalmath trivial %trivial + %STEAL.trivial
	if ($Stealing.LearningRate > 30) then goto done
	
DONE:
	gosub move 612
	put .aon
	waitfor Armor On
	echo *** You managed to steal %total items!
	if (%caught > 0) then echo *** You got caught %caught times!
	if (%trivial > 0) then echo *** %trivial items were trival, check log.
	put #parse Script Done
	exit