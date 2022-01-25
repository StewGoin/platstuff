#debug 10

Start:
	var pawn amulet|apron|bangles|basket|bathrobe|battle shield|bear|blanket|blossom|bowl|bottoms|bracer|briquet|broom|brush|charts|choker|cookbook|cufflinks|dagger|diary|earrings|knife|burin|cloak|comb|contract case|cowbell|crossbow|cube|cudgel|cylinder|distaff|fabric|fan|gloves|guide|handker|harp|imbue rod|jug|kaleidoscope|knives|lamp|lap harp|leaflet|ledger|lens|letter opener|locket|longsword|lunchbox|manual|memory orb|mirror|mixing stick|mouse|napkin|nightcap|nightgown|oil|pajamas|paperweight|parry stick|piggy bank|pillow|plate|portrait|pot helm|prism|quill|rasp|razor|ring|rustic pestle|rat|rustic mortar|scissors|shakers|shaper|skillet|slate|slippers|small scroll|sieve|snare|stirring rod|stove|sphere|statuette|tankard|telescope case|thumb ring|tool case|top|tote|towel|twine|vase|witch ball|worn book|yardstick

	eval PawnMax count("%pawn", "|")
	counter set 0
	var container duffel bag

Trash:
	put get my %pawn(%c) from my %container
	matchre Sell ^You get|^You are already
	matchre Next ^What were you referring to|^I could not find
	matchwait 30
	goto Trash

Sell:
	put sell my %pawn(%c)
	matchre Trash ^You ask|^You sell
	matchre Bucket shakes (his|her) head|Not worth my time|whistles and says
	matchwait 10
	goto Sell

Next:
	counter add 1
	if %c > %PawnMax then goto Recipe.Box
	goto Trash

Bucket:
	put put my %pawn(%c) in bucket
	waitforre ^You drop|^You put
	goto Trash

Recipe.Box:
	put get my recipe box from my %container
	matchre Dump.Box ^You get|^You are already
	matchre End ^What were you referring to|^I could not find
	matchwait 10
	goto Recipe.Box

Dump.Box:
	put put my recipe box in bucket
	waitforre ^You drop|^You put
	goto Recipe.Box
	
End:
	put stow 
	pause .5
	put stow left
	pause .5
	echo All pawned!
	pause .01
	send #parse Pawned!
	pause .01
	exit
