# incorporate into Base/includes and alias it.

var item ""
IF_1 var item %1
var amount 0
IF_2 var amount %2
var bought 0

buying:
	if %bought >= %amount then goto done
	else evalmath bought (%bought + 1)
	put order %item;order %item
	waitfor and hands you
	put put $lefthandnoun in my $craftpack
	waitfor You put your
	pause 0.2
	goto buying

done:
	echo "All bought!"
	put #parse All bought!
	exit
