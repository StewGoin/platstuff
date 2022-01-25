# See if this can be modded to handle new spells (or if they should be in Base/includes)

#debug 5
start:
var ease 1
var maf 1



loop:
action remove The air around you shimmers with a weak yellow light that quickly disperses|collapsing under the force of the attack in a silent cascade of glassy fragments
action remove ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
#action goto MAF when The air around you shimmers with a weak yellow light that quickly disperses|collapsing under the force of the attack in a silent cascade of glassy fragments
action goto MAF when eval $spell_maf_isactive = 0
#action goto EASE when ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
waitfor ALL DONE BUFFS


MAF:
#action remove The air around you shimmers with a weak yellow light that quickly disperses|collapsing under the force of the attack in a silent cascade of glassy fragments
#action remove ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
action remove eval $spell_maf_isactive = 0
#action var ease 0 when ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
waitforre Roundtime|There is nothing else to face
put .cast maf 10 45 45
# from .maf #parse
waitfor Spell Cast
if %ease = 0 then goto EASE
else goto loop

EASE:
var ease 0
action remove The air around you shimmers with a weak yellow light that quickly disperses|collapsing under the force of the attack in a silent cascade of glassy fragments
action remove ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
action var maf 0 when The air around you shimmers with a weak yellow light that quickly disperses|collapsing under the force of the attack in a silent cascade of glassy fragments
waitforre Roundtime|There is nothing else to face
put .ease
# from .ease #parse
waitfor EASE back up
var ease 1
if %maf = 0 then goto MAF
else goto loop
