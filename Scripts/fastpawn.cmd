# Update/clean and consider for includes.

# Fast Gem seller version 1.0
# Written by Copernicus of TF 5/17/08
var typeaheads 2

action math sell.queue subtract 1 when ^You get a|^What were you referring to|^Sell what|^You are already holding that\.|then hands you|he hands you|Relf rocks back and forth
action var sell.more.of.this.gem FALSE when ^What were you referring to\?|^Sell what\?|Trying to sell me a pig in a poke

gosub fast.sell.gems
#put stretch
exit

fast.sell.gems:
var sell.queue 0
gosub fast.selling armband
gosub fast.selling bracelet
gosub fast.selling anklet
return

fast.selling:
var gem.to.sell $0
var sell.more.of.this.gem TRUE
get.gem.to.sell:
gosub wait.sell.queue
put get my %gem.to.sell from my pack
math sell.queue add 1
gosub wait.sell.queue
put sell my %gem.to.sell
math sell.queue add 1
if %sell.more.of.this.gem = TRUE then goto get.gem.to.sell
gosub clear.sell.queue
return

wait.sell.queue:
if %sell.queue <= %typeaheads then return
pause .1
goto wait.sell.queue

clear.sell.queue:
if %sell.queue < 1 then return
pause .1
goto clear.sell.queue
