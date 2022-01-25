# diff vs. app.cmd

#class app off

put appraise %1 %2

action setvariable noun $1 when .+ the .+ (.*) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the .+ (.*) (is|are|could be|might be) probably worth
action setvariable noun $1 when .+ the (.*) (is|are|could be|might be) worth
action setvariable noun $1 when .+ the (.*) (is|are|could be|might be) probably worth

action setvariable wtype $1 when .+ is a (.*) .+ weapon

action setvariable range melee when melee-ranged
action setvariable range pole when pole-ranged
action setvariable wacc am certain that when You are certain that it could do
action setvariable wacc am confident that when You are confident that it could do
action setvariable wacc think that when You think that it could do
action setvariable wacc think it is likely that when You think it is likely that it could do
action setvariable wacc believe that when You believe that it could do
action setvariable wacc am pretty sure that when You are pretty sure that it could do
action setvariable wacc estimate that when You estimate that it could do
action setvariable wacc guess that when You guess that it could do
action setvariable wacc wonder if when You wonder if it could do
action setvariable puncture $1 when \s(.*) puncture damage
action setvariable slice $1 when \s(.*) slice damage
action setvariable impact $1 when \s(.*) impact damage
action setvariable bacc am certain that when You are certain that .+ balanced
action setvariable bacc feel certain that when You feel certain that .+ balanced
action setvariable bacc am confident that when You are confident that .+ balanced
action setvariable bacc feel confident that when You feel confident that .+ balanced
action setvariable bacc think that when You think that .+ balanced
action setvariable bacc think it is likely that when You think it is likely that .+ balanced
action setvariable bacc believe that when You believe that .+ balanced
action setvariable bacc am pretty sure that when You are pretty sure that .+ balanced
action setvariable bacc feel pretty sure that when You feel pretty sure that .+ balanced
action setvariable bacc estimate that when You estimate that .+ balanced
action setvariable bacc guess that when You guess that .+ balanced
action setvariable bacc wonder if when You wonder if .+ balanced
action setvariable balance $1 when .+ is (.*) balanced
action setvariable suited $1 when .+ is (.*) suited

action setvariable stype $1 when .+ is (.*) in size
action setvariable sacc am certain that when You are certain that the .+ offers
action setvariable sacc feel certain that when You feel certain that the .+ offers
action setvariable sacc am confident that when You are confident that the .+ offers
action setvariable sacc feel confident that when You feel confident that the .+ offers
action setvariable sacc think that when You think that the .+ offers
action setvariable sacc think it is likely that when You think it is likely that the .+ offers
action setvariable sacc believe that when You believe that the .+ offers
action setvariable sacc am pretty sure that when You are pretty sure that the .+ offers
action setvariable sacc feel pretty sure that when You feel pretty sure that the .+ offers
action setvariable sacc estimate that when You estimate that the .+ offers
action setvariable sacc guess that when You guess that the .+ offers
action setvariable sacc wonder if when You wonder if the .+ offers
action setvariable sprotection $1 when .+ offers (.*) protection
action setvariable shindrance $1 when .+ it imposes a (.*) maneuvering hinde?rance
action setvariable shindrance $1 when .+ it imposes an (.*) maneuvering hinde?rance

action setvariable atype cloth when cloth armor|cloth
action setvariable atype leather when leather armor
action setvariable atype bone when bone armor
action setvariable atype light chain when light chain
action setvariable atype heavy chain when heavy chain
action setvariable atype light plate when light plate
action setvariable atype heavy plate when heavy plate
action setvariable aacc am certain that when You are certain that .+ appears? to impose
action setvariable aacc feel certain that when You feel certain that .+ appears? to impose
action setvariable aacc am confident that when You are confident that .+ appears? to impose
action setvariable aacc feel confident that when You feel confident that .+ appears? to impose
action setvariable aacc think that when You think that .+ appears? to impose
action setvariable aacc think it is likely that when You think it is likely that .+ appears? to impose
action setvariable aacc believe that when You believe that .+ appears? to impose
action setvariable aacc am pretty sure that when You are pretty sure that .+ appears? to impose
action setvariable aacc feel pretty sure that when You feel pretty sure that .+ appears? to impose
action setvariable aacc estimate that when You estimate that .+ appears? to impose
action setvariable aacc guess that when You guess that .+ appears? to impose
action setvariable aacc wonder if when You wonder if .+ appears? to impose
action setvariable apuncture $1 when .+ \s(.*) for puncture attacks
action setvariable aslice $1 when .+ \s(.*) for slice attacks
action setvariable aimpact $1 when .+ \s(.*) for impact attacks
action setvariable afire $1 when .+ \s(.*) for fire attacks
action setvariable acold $1 when .+ \s(.*) for cold attacks
action setvariable aelectrical $1 when .+ \s(.*) for electrical attacks
action setvariable ahindrance $1 when .+ appears? to impose (.*), offering

action setvariable construct extremely weak when extremely weak
action setvariable construct somewhat flimsy when somewhat flimsy
action setvariable construct of average strength when average strength
action setvariable construct fairly sturdy when fairly sturdy
action setvariable construct moderately strong when moderately strong
action setvariable construct well constructed when well constructed
action setvariable construct very strong when very strong
action setvariable construct quite hard when quite hard
action setvariable construct incredibly hard when incredibly hard
action setvariable construct unbelievably strong when unbelievably strong

matchre wthrown thrown
matchre wmelee range
matchre wstick parry stick|calcified femur
matchre wbrawling brawling|elbow blades|elbow spikes|elbow wraps
matchre shield shield
matchre armor2 gauntlets|gloves|greaves|leathers|legguards|vambraces
matchre armor cloth armor|cloth|leather armor|bone armor|light chain|heavy chain|light plate|heavy plate
matchre wammob2 arrows
matchre wammoc2 bolts|quadrellos|quarrels|pulzones
matchre wammos2 bullets|clumps|lumps|rocks
matchre wammob arrow
matchre wammoc bolt|quadrello|quarrel|pulzone
matchre wammos bullet|clump|lump|rock
matchre wbow bow|sling
matchwait

wthrown:
put chat This %noun can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. It is %balance balanced, %suited suited to taking advantage of the wielder's strength, and %construct.

pause
goto end

wmelee:
put chat This %noun can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. It is %balance balanced, %suited suited to taking advantage of the wielder's strength, and %construct.

pause
goto end

wstick:
put chat This parry stick is %balance balanced and %construct.

pause
goto end

wbrawling:
put chat These %noun can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. They are %construct.

pause
goto end

shield:
put chat This shield offers %sprotection protection at the expense of %shindrance hindrance to one's ability to maneuver in combat. When used offensively, the %noun can inflict%impact impact damage, is %balance balanced, and is %suited suited to taking advantage of the user's strength. It is %construct.

pause
goto end

armor2:
put chat This armor offers %apuncture for puncture attacks, %aslice for slice attacks, %aimpact for impact attacks, %afire for fire attacks, %acold for cold attacks, and %aelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun are %construct.

pause
goto end

armor:
put chat This armor offers %apuncture for puncture attacks, %aslice for slice attacks, %aimpact for impact attacks, %afire for fire attacks, %acold for cold attacks, and %aelectrical for electrical attacks. This protection comes at the expense of %ahindrance. The %noun is %construct.

pause
goto end

wammob2:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun are %construct.

pause
goto end

wammoc2:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun are %construct.

pause
goto end

wammos2:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun are %construct.

pause
goto end

wammob:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun is %construct.

pause
goto end

wammoc:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun is %construct.

pause
goto end

wammos:
put chat This ammunition can inflict%puncture puncture damage,%slice slice damage, and%impact impact damage. The %noun is %construct.

pause
goto end

wbow:
put chat This %noun is %balance balanced and is %suited suited to taking advantage of the wielder's strength. It is %construct.

pause
goto end

end:

#class app on
