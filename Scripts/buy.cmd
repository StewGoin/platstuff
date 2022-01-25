# incorporate into Base/includes and alias it.

var item ""
IF_1 var item %1
var amount 0
IF_2 var amount %2
var bought 0

buying:
	if %bought >= %amount then goto done
	else evalmath bought (%bought + 1)
	put buy %item
	waitfor The sales clerk hands you
	put put $righthandnoun in my $pack
	waitfor You put your
	pause 0.2
	goto buying
	
done:
	echo "All bought!"
	exit
