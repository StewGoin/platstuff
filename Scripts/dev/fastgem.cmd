# cleanup and consider incorporate -- not useful at this time for Plat

#debug 8
# Fast Gem seller version 1.0
# Written by Copernicus of TF 5/17/08
var typeaheads 2

action var sell.more.of.this.gem FALSE when ^What were you referring to\?|^Sell what\?
action math sell.queue subtract 1 when ^You get a|^You are already holding that\.|then hands you

gosub fast.sell.gems
#put stretch
exit

fast.sell.gems:
gosub fast.selling amethyst
gosub fast.selling silver.bar
gosub fast.selling bloodstone
gosub fast.selling nugget
gosub fast.selling rock.crystal
gosub fast.selling diopside
gosub fast.selling jasper
gosub fast.selling quartz
gosub fast.selling topaz
gosub fast.selling zircon
gosub fast.selling turquoise.stone
gosub fast.selling green.stone
gosub fast.selling aquamarine.gem
gosub fast.selling alexandrite
gosub fast.selling egg
gosub fast.selling opal
gosub fast.selling emerald
gosub fast.selling pearl
gosub fast.selling diamond
gosub fast.selling goldstone
gosub fast.selling moonstone
gosub fast.selling sunstone
gosub fast.selling sapphire
gosub fast.selling bloodgem
gosub fast.selling malachite
gosub fast.selling lazuli
gosub fast.selling ruby
gosub fast.selling clear.crystal
gosub fast.selling iolite
gosub fast.selling morganite
gosub fast.selling andalusite
gosub fast.selling gold bar
gosub fast.selling bronze bar
gosub fast.selling ivory
gosub fast.selling jade
gosub fast.selling hematite
gosub fast.selling amber
gosub fast.selling waermodi.stone
gosub fast.selling lasmodi.stone
gosub fast.selling sjatmal.stone
gosub fast.selling turquoise
gosub fast.selling chalcedony
gosub fast.selling onyx
gosub fast.selling moonstone
gosub fast.selling kunzite
gosub fast.selling chrysoprase
gosub fast.selling coral
gosub fast.selling garnet
gosub fast.selling agate
gosub fast.selling chrysoberyl
gosub fast.selling platinum.bar
gosub fast.selling peridot
gosub fast.selling aquamarine
gosub fast.selling carnelia
gosub fast.selling beryl
gosub fast.selling citrine
gosub fast.selling tanzanite
gosub fast.selling spinel
gosub fast.selling tourmaline
gosub fast.selling star-stone
gosub fast.selling tsavorite
gosub fast.selling ivory.tooth
gosub fast.selling glass.pebble
return

fast.selling:
pause 0.5
var gem.to.sell $0
var sell.queue 0
var sell.more.of.this.gem TRUE
pause 0.5
get.gem.to.sell:
gosub wait.sell.queue
math sell.queue add 2
put get my %gem.to.sell
gosub wait.sell.queue
math sell.queue add 2
put sell my %gem.to.sell
if "%sell.more.of.this.gem" = "TRUE" then goto get.gem.to.sell
return

wait.sell.queue:
if %sell.queue <= %typeaheads then return
if "%sell.more.of.this.gem" = "FALSE" then return
pause .5
math sell.queue subtract 1
goto wait.sell.queue
