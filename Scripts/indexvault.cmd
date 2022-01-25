var containers backpack|pack|bag|haversack|sack|case|rucksack

# ------------

var retry_messages ^\.\.\.wait|^You can't do that while entangled in a web\.|^You are still stunned|^You don't seem to be able to move to do that|^You can't do that while entangled in a web|^You struggle against the shadowy webs to no avail\.|^Sorry, system is slow\.  No type ahead allowed\.|^You attempt that, but end up getting caught in an invisible box\.|^Sorry, you may only|^It's all a blur!

action var tmp $1 when ^You rummage through .+ and see (.*)\.
action var tmp $1 when ^(?:On|In) the .+ you see (.*)\.

var numbers first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth

gosub rummage vault

var contents %tmp
eval contents replace("%contents", ", ", "|")
eval contents replace("%contents", " and a", "|a")
eval total count("%contents", "|")

counter set 0

var output Vault Inventory:

loop:
	var item %contents(%c)
	var output %output|    %item
	
	if matchre("%item", "\b(%containers)$") then
	{
		if matchre("%item", "\b([\w\-\']+)$") then var item $1
		eval target_count count("%parseditems", "|%item")
		var parseditems %parseditems|%item
		if %target_count > 0 then var item %numbers(%target_count) %item
		gosub showcontainer %item
	}

	if matchre("%item", "\b(drawer)$") then
	{
		if matchre("%item", "\b([\w\-\']+)$") then var item $1
		eval target_count count("%parseditems", "|%item")
		var parseditems %parseditems|%item
		if %target_count > 0 then var item %numbers(%target_count) %item
		gosub showdrawer %item
	}

	if matchre("%item", "\b(shelf)$") then
	{
		if matchre("%item", "\b([\w\-\']+)$") then var item $1
		eval target_count count("%parseditems", "|%item")
		var parseditems %parseditems|%item
		if %target_count > 0 then var item %numbers(%target_count) %item
		gosub showshelf %item
	}

	counter add 1
	if %c > %total then goto showoutput
	goto loop

# -----------

showcontainer:
	var tmp
	gosub rummage $0 in vault
	goto parsecontainer

showshelf:
	var tmp
	put look on $0 in vault
	waitforre ^On the .+ you see|^There is nothing
	goto parsecontainer

showdrawer:
	var tmp
	put look in $0 in vault
	waitforre ^In the .+ you see|^There is nothing
	goto parsecontainer

# -----------

parsecontainer:
	if "%tmp" = "" then return
	var containercontents %tmp
	eval containercontents replace("%containercontents", ", ", "|")
	eval containercontents replace("%containercontents", " and ", "|")
	eval containertotal count("%containercontents", "|")
	var i 0
	goto showcontainer.loop
showcontainer.loop:
	var containeritem %containercontents(%i)
	var output %output|        %containeritem
	math i add 1
	if %i > %containertotal then return
	goto showcontainer.loop

# -----------

rummage:
	var cmd $0
rummage.do:
	matchre rummage.do %retry_messages
	matchre return ^You rummage through
	matchre return ^That would accomplish nothing
	matchre rummage.open ^While it's closed
	put rummage %cmd
	matchwait
rummage.open:
	put open %cmd
	wait
	goto rummage.do

# -----------

return:
	return

# -----------

showoutput:
	var outputcount count("%output", "|")
	var i 0
	goto showoutput.loop
showoutput.loop:
	put #parse %output(%i)
	math i add 1
	if %i > %outputcount then goto done
	goto showoutput.loop

done:
	put #parse Done.
	exit
