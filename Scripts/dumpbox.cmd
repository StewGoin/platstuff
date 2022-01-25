# Clean this up and see if it makes sense to alias + include

var Container1 %1
	var boxtype greenish|cracked|rusty|reinforced|worm-eaten|dull|dented|deeply gouged|copper-edged|plain|crooked|mud-stained|pitted|salt-stained|sturdy|rotting|moldy|misshaped|poorly made|crust-covered|mildewy|corroded|greenish brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
	var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox

WHAT.BOX:
		match WHAT.BOX ...wait
		matchre BOX (%boxtype)\s\w+\s(%boxes)
		matchre DONE Encumbrance
		put rumm MY %Container1
		put enc
	matchwait

BOX:
var BOX $2
if_2 goto BOX2
put get %BOX from my %Container1;drop %BOX
pause 0.5
goto WHAT.BOX

BOX2:
if ("%2" = "bucket") || ("%2" = "bin") || ("%2" = "chute") then put get %BOX from my %Container1;put %BOX in %2
else put get %BOX from my %Container1;put %BOX in my %2
pause 0.5
goto WHAT.BOX

DONE:
exit
