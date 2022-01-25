# clean, rename if needed, and does this make sense in Includes / alias usage instead?

var collect.once 0
var xptype Outdoorsmanship
IF_1 var xptype Perception
IF_2 var collect.once 1

start:
match kickrocks You manage to collect a pile of rocks.
match dustbunny Roundtime
put collect rock
matchwait 10
goto done

rocks:
if $humming = 0 then put hum concerto masterful
if %collect.once = 0 && $%xptype.LearningRate > 32 then goto done
if %collect.once = 1 && $%xptype.LearningRate > 32 then goto done
match kickrocks You manage to collect a pile of rocks.
match kickrocks ...wait
put collect rock
matchwait 5

kickrocks:
pause 0.5
if %collect.once = 0 then matchre rocks You take a step back and run up to the pile of rocks|I could not find what you were referring to
else matchre done You take a step back and run up to the pile of rocks|I could not find what you were referring to
match kickrocks ...wait
put kick rock
matchwait 5
goto rocks

dustbunny:
if $humming = 0 then put hum concerto masterful
if %collect.once = 0 && $%xptype.LearningRate > 32 then goto done
if %collect.once = 1 && $%xptype.LearningRate > 32 then goto done
match kickdust You manage to collect a pile of dust bunnies.
match kickdust ...wait
match done Roundtime
put collect dust bunny
matchwait 5

kickdust:
pause 0.5
if %collect.once = 0 then matchre dustbunny You take a step back and run up to the pile of bunnies|I could not find what you were referring to
else matchre done You take a step back and run up to the pile of bunnies|I could not find what you were referring to
match kickdust ...wait
put kick dust bunnies
matchwait 5
goto dustbunny

done:
pause
put #parse Script Done
exit
