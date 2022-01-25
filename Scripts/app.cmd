var metal no
var maxcharge N/A

action setvariable noun $1 when .+ the .+ (\S+) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the .+ (\S+) (is|are|could be|might be) probably worth
action setvariable noun $1 when .+ the (\S+) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the (\S+) (is|are|could be|might be) probably worth
action setvariable tap $2 when ^In your right hand, you are carrying (a|an|some|the) (.+), and in your left hand, you are carrying

action setvariable wtype $1 when .+ is a (.*) .+ weapon

action setvariable range melee when melee-ranged weapon\.$
action setvariable range pole when pole-ranged weapon\.$
action setvariable wacc am certain that when You are certain that it could do
action setvariable wacc am confident that when You are confident that it could do
action setvariable wacc think that when You think that it could do
action setvariable wacc think it is likely that when You think it is likely that it could do
action setvariable wacc believe that when You believe that it could do
action setvariable wacc am pretty sure that when You are pretty sure that it could do
action setvariable wacc estimate that when You estimate that it could do
action setvariable wacc guess that when You guess that it could do
action setvariable wacc wonder if when You wonder if it could do
action setvariable puncture $1 when ^\s+(.*) puncture damage$
action setvariable slice $1 when ^\s+(.*) slice damage$
action setvariable impact $1 when ^\s+(.*) impact damage$
action setvariable fire $1 when ^\s+(.*) fire damage$
action setvariable cold $1 when ^\s+(.*) cold damage$
action setvariable electric $1 when ^\s+(.*) electric damage$
action setvariable puncture $1 when ^\s+(.*) puncture damage increase$
action setvariable slice $1 when ^\s+(.*) slice damage increase$
action setvariable impact $1 when ^\s+(.*) impact damage increase$
action setvariable fire $1 when ^\s+(.*) fire damage increase$
action setvariable cold $1 when ^\s+(.*) cold damage increase$
action setvariable electric $1 when ^\s+(.*) electric damage increase$
action setvariable bacc am certain that when ^You are certain that .+ balanced
action setvariable bacc feel certain that when ^You feel certain that .+ balanced
action setvariable bacc am confident that when ^You are confident that .+ balanced
action setvariable bacc feel confident that when ^You feel confident that .+ balanced
action setvariable bacc think that when ^You think that .+ balanced
action setvariable bacc think it is likely that when ^You think it is likely that .+ balanced
action setvariable bacc believe that when ^You believe that .+ balanced
action setvariable bacc am pretty sure that when ^You are pretty sure that .+ balanced
action setvariable bacc feel pretty sure that when ^You feel pretty sure that .+ balanced
action setvariable bacc estimate that when ^You estimate that .+ balanced
action setvariable bacc guess that when ^You guess that .+ balanced
action setvariable bacc wonder if when ^You wonder if .+ balanced
action setvariable force $2 when ^The .+ (is|are) (.+) designed for improving the force of your attacks\.$
action setvariable balance $2 when the .+ (is|are) (.+) balanced and .+ suited to gaining extra attack power from your strength\.$
action setvariable power $1 when balanced and is (.+) suited to gaining extra attack power from your strength\.$

action setvariable stype $1 when ^This shield is (\w+) in size\.$
action setvariable sacc am certain that when ^You are certain that the .+ offers
action setvariable sacc feel certain that when ^You feel certain that the .+ offers
action setvariable sacc am confident that when ^You are confident that the .+ offers
action setvariable sacc feel confident that when ^You feel confident that the .+ offers
action setvariable sacc think that when ^You think that the .+ offers
action setvariable sacc think it is likely that when ^You think it is likely that the .+ offers
action setvariable sacc believe that when ^You believe that the .+ offers
action setvariable sacc am pretty sure that when ^You are pretty sure that the .+ offers
action setvariable sacc feel pretty sure that when ^You feel pretty sure that the .+ offers
action setvariable sacc estimate that when ^You estimate that the .+ offers
action setvariable sacc guess that when ^You guess that the .+ offers
action setvariable sacc wonder if when ^You wonder if the .+ offers
action setvariable sprotection $1 when .+ offers (.*) protection\.$
action setvariable shindrance $1 when .+ it imposes (.+) maneuvering hinde?rance\.$

action setvariable atype $2 when ^The.+(is|are) (plate|brigandine|chain|light) armor\.$
action setvariable aacc am certain that when ^You are certain that .+ appears? to impose
action setvariable aacc feel certain that when ^You feel certain that .+ appears? to impose
action setvariable aacc am confident that when ^You are confident that .+ appears? to impose
action setvariable aacc feel confident that when ^You feel confident that .+ appears? to impose
action setvariable aacc think that when ^You think that .+ appears? to impose
action setvariable aacc think it is likely that when ^You think it is likely that .+ appears? to impose
action setvariable aacc believe that when ^You believe that .+ appears? to impose
action setvariable aacc am pretty sure that when ^You are pretty sure that .+ appears? to impose
action setvariable aacc feel pretty sure that when ^You feel pretty sure that .+ appears? to impose
action setvariable aacc estimate that when ^You estimate that .+ appears? to impose
action setvariable aacc guess that when ^You guess that .+ appears? to impose
action setvariable aacc wonder if when ^You wonder if .+ appears? to impose
action setvariable abpuncture $1 when .+ \s(.*) for puncture attacks\.$
action setvariable abslice $1 when .+ \s(.*) for slice attacks\.$
action setvariable abimpact $1 when .+ \s(.*) for impact attacks\.$
action setvariable abfire $1 when .+ \s(.*) for fire attacks\.$
action setvariable abcold $1 when .+ \s(.*) for cold attacks\.$
action setvariable abelectrical $1 when .+ \s(.*) for electrical attacks\.$
action setvariable appuncture $1 when .+ \s(.*) protection and .+ damage absorption for puncture attacks\.$
action setvariable apslice $1 when .+ \s(.*) protection and .+ damage absorption for slice attacks\.$
action setvariable apimpact $1 when .+ \s(.*) protection and .+ damage absorption for impact attacks\.$
action setvariable apfire $1 when .+ \s(.*) protection and .+ damage absorption for fire attacks\.$
action setvariable apcold $1 when .+ \s(.*) protection and .+ damage absorption for cold attacks\.$
action setvariable apelectrical $1 when .+ \s(.*) protection and .+ damage absorption for electrical attacks\.$
action setvariable aapuncture $1 when .+ protection and (.*) damage absorption for puncture attacks\.$
action setvariable aaslice $1 when .+ protection and (.*) damage absorption for slice attacks\.$
action setvariable aaimpact $1 when .+ protection and (.*) damage absorption for impact attacks\.$
action setvariable aafire $1 when .+ protection and (.*) damage absorption for fire attacks\.$
action setvariable aacold $1 when .+ protection and (.*) damage absorption for cold attacks\.$
action setvariable aaelectrical $1 when .+ protection and (.*) damage absorption for electrical attacks\.$
action setvariable ahindrance $1 when .+ appears? to impose (.*), offering:$
action setvariable mhindrance $1 when .+ appears? to impose (.*) maneuvering hindrance and.+offering:$
action setvariable shindrance $1 when .+ appears? to impose .+ maneuvering hindrance and (.*) stealth hindrance, offering:$

action setvariable construct $2 when ^You are certain that the .+ (is|are) (.*), and (is|are)
action setvariable metal yes when ^The .+ is|are made with metal\.$
action setvariable weight1 $1 when ^You are certain that .+ weighs exactly (\d+) (stones|stone)\.$
action setvariable weight2 $1 when ^You are certain that .+ weighs exactly \d+ (.*)\.$
action setvariable value $2 when ^You are certain that .+ (is|are) worth exactly (\d+) kronars\.

send appraise %1 %2

matchre wthrown thrown
matchre wmelee range
matchre wstick parry stick|calcified femur
matchre wbrawling brawling|elbow blades|elbow spikes|elbow wraps
matchre shield shield
matchre armor2 gauntlets|gloves|greaves|leathers|legguards|vambraces
matchre armor light armor|chain armor|brigandine armor|plate armor
matchre wammob2 arrows
matchre wammoc2 bolts|quadrellos|quarrels|pulzones
matchre wammos2 bullets|clumps|lumps|rocks
matchre wammob arrow
matchre wammoc bolt|quadrello|quarrel|pulzone
matchre wammos bullet|clump|lump|rock
matchre wbow bow|sling
matchwait

wthrown:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype weapon can be thrown from missile range or wielded at %range range. It can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This %weight1-stone %noun can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force/%balance balanced/%power suited, %construct

pause
goto measure

wmelee:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype weapon can be wielded at %range range. It can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This %weight1-stone %noun can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force/%balance balanced/%power suited, %construct

pause
goto measure

wstick:
echo
echo Verbose IC: This %weight1-stone parry stick is a purely defensive item that is simply worn in combat. It is %balance balanced and %construct.
echo
echo Concise IC: This %weight1-stone parry stick is %balance balanced and %construct.
echo
echo OOC: Parry stick (%weight1 %weight2): %balance balanced and %construct

pause
goto measure

wbrawling:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %weight1-stone %noun are worn while brawling to increase damage. They can inflict %puncture puncture damage, %slice slice damage, and %impact impact damage. They %force improve the force of your attacks. The %noun are %construct.
echo
echo Concise IC: These %weight1-stone %noun can inflict %puncture puncture damage, %slice slice damage, and %impact impact damage. They %force improve the force of your attacks and are %construct.
echo
echo OOC: Brawling weapon (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact, %force improve force, %construct

pause
goto measure

shield:
echo
echo Verbose IC: This %stype shield offers %sprotection protection at the expense of %shindrance hindrance to one's ability to maneuver in combat. When used offensively, the %noun can inflict %impact impact damage, is %balance balanced, and is %power suited to taking advantage of your strength. It weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This %weight1-stone shield offers %sprotection protection at the expense of %shindrance hindrance. When used offensively, the %noun can inflict %impact impact damage, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %stype shield (%weight1 %weight2): %sprotection protection, %shindrance hindrance, %construct

pause
goto measure

armor2:
echo
echo Verbose IC: This %atype armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun weigh %weight1 %weight2 and are %construct.
echo
echo Concise IC: This %weight1-stone armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun are %construct.
echo
echo OOC: %atype armor (%weight1 %weight2) - puncture: %appuncture/%aapuncture, slice: %apslice/%aaslice, impact: %apimpact/%aaimpact, fire: %apfire/%aafire, cold: %apcold/%aacold, electrical: %apelectrical/%aaelectrical, hindrance: %mhindrance/%shindrance, construction: %construct


pause
goto measure

armor:
echo
echo Verbose IC: This %atype armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This %weight1-stone armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun is %construct.
echo
echo OOC: %atype armor (%weight1 %weight2) - puncture: %appuncture/%aapuncture, slice: %apslice/%aaslice, impact: %apimpact/%aaimpact, fire: %apfire/%aafire, cold: %apcold/%aacold, electrical: %apelectrical/%aaelectrical, hindrance: %mhindrance/%shindrance, construction: %construct

pause
goto measure

wammob2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a bow. When fired, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. They %force improve the force of your attacks. The %noun weigh %weight1 %weight2 and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improve the force of your attacks. They weigh %weight1 %weight2 and are %construct.
echo
echo OOC: Bow ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammoc2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a crossbow. When fired, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. They %force improve the force of your attacks. The %noun weigh %weight1 %weight2 and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improve the force of your attacks. They weigh %weight1 %weight2 and are %construct.
echo
echo OOC: Crossbow ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammos2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a sling or staff sling. When hurled, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. They %force improve the force of your attacks. The %noun weigh %weight1 %weight2 and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improve the force of your attacks. They weigh %weight1 %weight2 and are %construct.
echo
echo OOC: Sling ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammob:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a bow. When fired, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks. The %noun weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks. It weighs %weight1 %weight2 and is %construct.
echo
echo OOC: Bow ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wammoc:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a crossbow. When fired, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks. The %noun weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks. It weighs %weight1 %weight2 and is %construct.
echo
echo OOC: Crossbow ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wammos:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a sling or staff sling. When hurled, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks. The %noun weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks. It weighs %weight1 %weight2 and is %construct.
echo
echo OOC: Sling ammunition (%weight1 %weight2): %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wbow:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype can be used from missile range. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It weighs %weight1 %weight2 and is %construct.
echo
echo Concise IC: This %weight1-stone %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype (%weight1 %weight2): %force improves force, %balance balanced/%power suited, %construct

pause
goto measure

measure:
echo
goto exit
send get my yardstick
waitforre ^You get|^You are already holding that
send look my $righthandnoun
pause .5
send read my $righthandnoun
pause .5
send measure my $righthandnoun with yardstick
wait
pause .5
send stow my yardstick

exit:

var metal no
var maxcharge N/A

action setvariable noun $1 when .+ the .+ (\S+) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the .+ (\S+) (is|are|could be|might be) probably worth
action setvariable noun $1 when .+ the (\S+) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the (\S+) (is|are|could be|might be) probably worth
action setvariable tap $2 when ^In your right hand, you are carrying (a|an|some|the) (.+), and in your left hand, you are carrying

action setvariable wtype $1 when .+ is a (.*) .+ weapon

action setvariable range melee when melee-ranged weapon\.$
action setvariable range pole when pole-ranged weapon\.$
action setvariable wacc am certain that when You are certain that it could do
action setvariable wacc am confident that when You are confident that it could do
action setvariable wacc think that when You think that it could do
action setvariable wacc think it is likely that when You think it is likely that it could do
action setvariable wacc believe that when You believe that it could do
action setvariable wacc am pretty sure that when You are pretty sure that it could do
action setvariable wacc estimate that when You estimate that it could do
action setvariable wacc guess that when You guess that it could do
action setvariable wacc wonder if when You wonder if it could do
action setvariable puncture $1 when ^\s+(.*) puncture damage$
action setvariable slice $1 when ^\s+(.*) slice damage$
action setvariable impact $1 when ^\s+(.*) impact damage$
action setvariable fire $1 when ^\s+(.*) fire damage$
action setvariable cold $1 when ^\s+(.*) cold damage$
action setvariable electric $1 when ^\s+(.*) electric damage$
action setvariable puncture $1 when ^\s+(.*) puncture damage increase$
action setvariable slice $1 when ^\s+(.*) slice damage increase$
action setvariable impact $1 when ^\s+(.*) impact damage increase$
action setvariable fire $1 when ^\s+(.*) fire damage increase$
action setvariable cold $1 when ^\s+(.*) cold damage increase$
action setvariable electric $1 when ^\s+(.*) electric damage increase$
action setvariable bacc am certain that when ^You are certain that .+ balanced
action setvariable bacc feel certain that when ^You feel certain that .+ balanced
action setvariable bacc am confident that when ^You are confident that .+ balanced
action setvariable bacc feel confident that when ^You feel confident that .+ balanced
action setvariable bacc think that when ^You think that .+ balanced
action setvariable bacc think it is likely that when ^You think it is likely that .+ balanced
action setvariable bacc believe that when ^You believe that .+ balanced
action setvariable bacc am pretty sure that when ^You are pretty sure that .+ balanced
action setvariable bacc feel pretty sure that when ^You feel pretty sure that .+ balanced
action setvariable bacc estimate that when ^You estimate that .+ balanced
action setvariable bacc guess that when ^You guess that .+ balanced
action setvariable bacc wonder if when ^You wonder if .+ balanced
action setvariable force $2 when ^The .+ (is|are) (.+) designed for improving the force of your attacks\.$
action setvariable balance $2 when the .+ (is|are) (.+) balanced and .+ suited to gaining extra attack power from your strength\.$
action setvariable power $1 when balanced and is (.+) suited to gaining extra attack power from your strength\.$

action setvariable stype $1 when ^This shield is (\w+) in size\.$
action setvariable sacc am certain that when ^You are certain that the .+ offers
action setvariable sacc feel certain that when ^You feel certain that the .+ offers
action setvariable sacc am confident that when ^You are confident that the .+ offers
action setvariable sacc feel confident that when ^You feel confident that the .+ offers
action setvariable sacc think that when ^You think that the .+ offers
action setvariable sacc think it is likely that when ^You think it is likely that the .+ offers
action setvariable sacc believe that when ^You believe that the .+ offers
action setvariable sacc am pretty sure that when ^You are pretty sure that the .+ offers
action setvariable sacc feel pretty sure that when ^You feel pretty sure that the .+ offers
action setvariable sacc estimate that when ^You estimate that the .+ offers
action setvariable sacc guess that when ^You guess that the .+ offers
action setvariable sacc wonder if when ^You wonder if the .+ offers
action setvariable sprotection $1 when .+ offers (.*) protection\.$
action setvariable shindrance $1 when .+ it imposes (.+) maneuvering hinde?rance\.$

action setvariable atype $2 when ^The.+(is|are) (plate|brigandine|chain|light) armor\.$
action setvariable aacc am certain that when ^You are certain that .+ appears? to impose
action setvariable aacc feel certain that when ^You feel certain that .+ appears? to impose
action setvariable aacc am confident that when ^You are confident that .+ appears? to impose
action setvariable aacc feel confident that when ^You feel confident that .+ appears? to impose
action setvariable aacc think that when ^You think that .+ appears? to impose
action setvariable aacc think it is likely that when ^You think it is likely that .+ appears? to impose
action setvariable aacc believe that when ^You believe that .+ appears? to impose
action setvariable aacc am pretty sure that when ^You are pretty sure that .+ appears? to impose
action setvariable aacc feel pretty sure that when ^You feel pretty sure that .+ appears? to impose
action setvariable aacc estimate that when ^You estimate that .+ appears? to impose
action setvariable aacc guess that when ^You guess that .+ appears? to impose
action setvariable aacc wonder if when ^You wonder if .+ appears? to impose
action setvariable abpuncture $1 when .+ \s(.*) for puncture attacks\.$
action setvariable abslice $1 when .+ \s(.*) for slice attacks\.$
action setvariable abimpact $1 when .+ \s(.*) for impact attacks\.$
action setvariable abfire $1 when .+ \s(.*) for fire attacks\.$
action setvariable abcold $1 when .+ \s(.*) for cold attacks\.$
action setvariable abelectrical $1 when .+ \s(.*) for electrical attacks\.$
action setvariable appuncture $1 when .+ \s(.*) protection and .+ damage absorption for puncture attacks\.$
action setvariable apslice $1 when .+ \s(.*) protection and .+ damage absorption for slice attacks\.$
action setvariable apimpact $1 when .+ \s(.*) protection and .+ damage absorption for impact attacks\.$
action setvariable apfire $1 when .+ \s(.*) protection and .+ damage absorption for fire attacks\.$
action setvariable apcold $1 when .+ \s(.*) protection and .+ damage absorption for cold attacks\.$
action setvariable apelectrical $1 when .+ \s(.*) protection and .+ damage absorption for electrical attacks\.$
action setvariable aapuncture $1 when .+ protection and (.*) damage absorption for puncture attacks\.$
action setvariable aaslice $1 when .+ protection and (.*) damage absorption for slice attacks\.$
action setvariable aaimpact $1 when .+ protection and (.*) damage absorption for impact attacks\.$
action setvariable aafire $1 when .+ protection and (.*) damage absorption for fire attacks\.$
action setvariable aacold $1 when .+ protection and (.*) damage absorption for cold attacks\.$
action setvariable aaelectrical $1 when .+ protection and (.*) damage absorption for electrical attacks\.$
action setvariable ahindrance $1 when .+ appears? to impose (.*), offering:$
action setvariable mhindrance $1 when .+ appears? to impose (.*) maneuvering hindrance and.+offering:$
action setvariable shindrance $1 when .+ appears? to impose .+ maneuvering hindrance and (.*) stealth hindrance, offering:$

action setvariable construct $2 when ^You are certain that the .+ (is|are) (.*), and (is|are)
action setvariable metal yes when ^The .+ is|are made with metal\.$
action setvariable weight1 $1 when ^You are certain that .+ weighs exactly (\d+) (stones|stone)\.$
action setvariable weight2 $1 when ^You are certain that .+ weighs exactly \d+ (.*)\.$
action setvariable value $2 when ^You are certain that .+ (is|are) worth exactly (\d+) kronars\.

send appraise %1 %2

matchre wthrown thrown
matchre wmelee range
matchre wstick parry stick|calcified femur
matchre wbrawling brawling|elbow blades|elbow spikes|elbow wraps
matchre shield shield
matchre armor2 gauntlets|gloves|greaves|leathers|legguards|vambraces
matchre armor light armor|chain armor|brigandine armor|plate armor
matchre wammob2 arrows
matchre wammoc2 bolts|quadrellos|quarrels|pulzones
matchre wammos2 bullets|clumps|lumps|rocks
matchre wammob arrow
matchre wammoc bolt|quadrello|quarrel|pulzone
matchre wammos bullet|clump|lump|rock
matchre wbow bow|sling
matchwait

wthrown:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype weapon can be thrown from missile range or wielded at %range range. It can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo Concise IC: This %noun can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force/%balance balanced/%power suited, %construct

pause
goto measure

wmelee:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype weapon can be wielded at %range range. It can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo Concise IC: This %noun can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. It %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force/%balance balanced/%power suited, %construct

pause
goto measure

wstick:
echo
echo Verbose IC: This parry stick is a purely defensive item that is simply worn in combat. It is %balance balanced and %construct.
echo
echo Concise IC: This parry stick is %balance balanced and %construct.
echo
echo OOC: Parry stick: %balance balanced and %construct

pause
goto measure

wbrawling:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are worn while brawling to increase damage. They can inflict %puncture puncture damage, %slice slice damage, and %impact impact damage. They %force improve the force of your attacks. The %noun are %construct.
echo
echo Concise IC: These %noun can inflict %puncture puncture damage, %slice slice damage, and %impact impact damage. They %force improve the force of your attacks and are %construct.
echo
echo OOC: Brawling weapon: %puncture puncture/%slice slice/%impact impact, %force improve force, %construct

pause
goto measure

shield:
echo
echo Verbose IC: This %stype shield offers %sprotection protection at the expense of %shindrance hindrance to one's ability to maneuver in combat. When used offensively, the %noun can inflict %impact impact damage, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo Concise IC: This shield offers %sprotection protection at the expense of %shindrance hindrance. When used offensively, the %noun can inflict %impact impact damage, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %stype shield: %sprotection protection, %shindrance hindrance, %construct

pause
goto measure

armor2:
echo
echo Verbose IC: This %atype armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun are %construct.
echo
echo Concise IC: This armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun are %construct.
echo
echo OOC: %atype armor - puncture: %appuncture/%aapuncture, slice: %apslice/%aaslice, impact: %apimpact/%aaimpact, fire: %apfire/%aafire, cold: %apcold/%aacold, electrical: %apelectrical/%aaelectrical, hindrance: %mhindrance/%shindrance, construction: %construct


pause
goto measure

armor:
echo
echo Verbose IC: This %atype armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun is %construct.
echo
echo Concise IC: This armor offers %abpuncture for puncture attacks, %abslice for slice attacks, %abimpact for impact attacks, %abfire for fire attacks, %abcold for cold attacks, and %abelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun is %construct.
echo
echo OOC: %atype armor - puncture: %appuncture/%aapuncture, slice: %apslice/%aaslice, impact: %apimpact/%aaimpact, fire: %apfire/%aafire, cold: %apcold/%aacold, electrical: %apelectrical/%aaelectrical, hindrance: %mhindrance/%shindrance, construction: %construct

pause
goto measure

wammob2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a bow. When fired, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun are %construct.
echo
echo OOC: Bow ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammoc2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a crossbow. When fired, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun are %construct.
echo
echo OOC: Crossbow ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammos2:
if "%force" = "not" then var force do not
echo
echo Verbose IC: These %noun are ammunition for a sling or staff sling. When hurled, they can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and are %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun are %construct.
echo
echo OOC: Sling ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improve force, %construct

pause
goto measure

wammob:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a bow. When fired, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun is %construct.
echo
echo OOC: Bow ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wammoc:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a crossbow. When fired, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun is %construct.
echo
echo OOC: Crossbow ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wammos:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %noun is ammunition for a sling or staff sling. When hurled, it can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun %force improves the force of your attacks and is %construct.
echo
echo Concise IC: This ammunition can inflict %puncture puncture damage, %slice slice damage, %impact impact damage, %fire fire damage, %cold cold damage, and %electric electric damage. The %noun is %construct.
echo
echo OOC: Sling ammunition: %puncture puncture/%slice slice/%impact impact/%fire fire/%cold cold/%electric electric, %force improves force, %construct

pause
goto measure

wbow:
if "%force" = "not" then var force does not
echo
echo Verbose IC: This %wtype can be used from missile range. The %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo Concise IC: This %noun %force improves the force of your attacks, is %balance balanced, and is %power suited to taking advantage of your strength. It is %construct.
echo
echo OOC: %wtype: %force improves force, %balance balanced/%power suited, %construct

pause
goto measure

measure:
echo
goto exit
send get my yardstick
waitforre ^You get|^You are already holding that
send look my $righthandnoun
pause .5
send read my $righthandnoun
pause .5
send measure my $righthandnoun with yardstick
wait
pause .5
send stow my yardstick

exit:
