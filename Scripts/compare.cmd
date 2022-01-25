# validate this and see if it can be better placed in an include

send compare %1 with %2

action setvariable name1 $1 when You are certain that a (.*) (add|is)
action setvariable name1 $1 when You are certain that an (.*) (add|is)
action setvariable name1 $1 when You are certain that some (.*) (add|is)
action setvariable name1 $1 when You are certain that the (.*) (add|is)
action setvariable name1 $1 when You are certain that a (.*) is .+ resistant
action setvariable name1 $1 when You are certain that an (.*) is .+ resistant
action setvariable name1 $1 when You are certain that some (.*) is .+ resistant
action setvariable name1 $1 when You are certain that the (.*) is .+ resistant
action setvariable name2 $1 when You are certain that .+ as a (.*).
action setvariable name2 $1 when You are certain that .+ as an (.*).
action setvariable name2 $1 when You are certain that .+ as some (.*).
action setvariable name2 $1 when You are certain that .+ as the (.*).
action setvariable name2 $1 when You are certain that .+ than a (.*).
action setvariable name2 $1 when You are certain that .+ than an (.*).
action setvariable name2 $1 when You are certain that .+ than some (.*).
action setvariable name2 $1 when You are certain that .+ than the (.*).
action setvariable const1 when You are certain that the .+ is stronger than .+
action setvariable const1 $1 when You are certain that the .+ is (.*) stronger than .+
action setvariable const1 $1 when You are certain that the .+ is (.*) weaker than .+
action setvariable const1 when You are certain that the .+ is weaker than .+
action setvariable const1 $1 when You are certain that the .+ is (.*) as strong as .+
action setvariable const2 stronger than when .+ stronger than .+
action setvariable const2 weaker than when .+ weaker than .+
action setvariable const2 as strong as when .+ about as strong as .+
action setvariable balance $1 when You are certain that .+ is (.*) balanced than .+
action setvariable balance $1 when You are certain that .+ is (.*) balanced as .+
action setvariable power $1 when You are certain that .+ is (.*) suited to gaining extra attack power from your strength than .+
action setvariable power $1 when You are certain that .+ is (.*) suited to gaining extra attack power from your strength as .+
action setvariable puncture $1 when You are certain that .+ add (.*) puncture damage .+
action setvariable puncture $1 when You are certain that .+ does (.*) puncture damage .+
action setvariable slice $1 when You are certain that .+ add (.*) slice damage .+
action setvariable slice $1 when You are certain that .+ does (.*) slice damage .+
action setvariable impact $1 when You are certain that .+ improve impact damage (.*) (a|an|the|some)
action setvariable impact $1 when You are certain that .+ does (.*) impact damage .+
action setvariable hindrance $1 when You are certain that .+ is (.*) to maneuver with .+
action setvariable bdefense $1 when You are certain that .+ has (.*) basic defense .+
action setvariable fdefense $1 when You are certain that .+ has (.*) full defense .+
action setvariable presist $1 when You are certain that .+ is (.*) resistant to puncture damage .+
action setvariable sresist $1 when You are certain that .+ is (.*) resistant to slice damage .+
action setvariable iresist $1 when You are certain that .+ is (.*) resistant to impact damage .+
action setvariable fresist $1 when You are certain that .+ is (.*) resistant to fire .+
action setvariable cresist $1 when You are certain that .+ is (.*) resistant to cold .+
action setvariable eresist $1 when You are certain that .+ is (.*) resistant to electricity .+
action setvariable pabsorb $1 when You are certain that .+ is (.*) absorptive of puncture damage .+
action setvariable sabsorb $1 when You are certain that .+ is (.*) absorptive of slice damage .+
action setvariable iabsorb $1 when You are certain that .+ is (.*) absorptive of impact damage .+
action setvariable fabsorb $1 when You are certain that .+ is (.*) absorptive of fire .+
action setvariable cabsorb $1 when You are certain that .+ is (.*) absorptive of cold .+
action setvariable eabsorb $1 when You are certain that .+ is (.*) absorptive of electricity .+

matchre melee does
matchre pstick parry stick|calcified femur
matchre brawlinge affect impact damage|elbow blades|elbow spikes|elbow wraps
matchre brawlingb affect puncture|slice damage
matchre shield basic defense|full defense
matchre armor2 gauntlets|gloves|greaves|leathers|legguards|vambraces
matchre armor1 resistant
matchre ammo2 arrows|bolts|bullets|clumps|lumps|pulzones|quadrellos|quarrels|rocks
matchre ammo1 arrow|bolt|bullet|clump|lump|pulzone|quadrello|quarrel|rock
matchre bow bow
matchwait

melee:
echo The %name1 does %puncture puncture damage, does %slice slice damage, does %impact impact damage, is %balance balanced, is %power suited to gaining extra attack power from your strength, and is %const1 %const2 the %name2.
pause
goto end

pstick:
echo The %name1 and the %name2 are parry sticks, which are simply worn to parry blows. All parry sticks are reasonably balanced. However, some are better made than others. The construction of these items cannot be compared without appraising each of them.
pause
goto end

brawlinge:
echo The %name1 add %puncture puncture damage and add %slice slice damage than the %name2. These weapons are too different to compare their effect on impact damage.
pause
goto end

brawlingb:
echo The %name1 improve impact damage %impact the %name2.
pause
goto end

shield:
echo The %name1 has %bdefense basic defense, has %fdefense full defense, is %hindrance to maneuver with, and is %const1 %const2 the %name2.
pause
goto end

armor2:
echo The %name1 are %presist resistant to and %pabsorb absorptive of puncture damage, are %sresist resistant to and %sabsorb absorptive of slice damage, are %iresist resistant to and %iabsorb absorptive of impact damage, are %fresist resistant to and %fabsorb absorptive of fire, are %cresist resistant to and %cabsorb absorptive of cold, are %eresist resistant to and %eabsorb absorptive of electricity, are %hindrance to maneuver with, and are %const1 %const2 the %name2.
pause
goto end

armor1:
echo The %name1 is %presist resistant to and %pabsorb absorptive of puncture damage, is %sresist resistant to and %sabsorb absorptive of slice damage, is %iresist resistant to and %iabsorb absorptive of impact damage, is %fresist resistant to and %fabsorb absorptive of fire, is %cresist resistant to and %cabsorb absorptive of cold, is %eresist resistant to and %eabsorb absorptive of electricity, is %hindrance to maneuver with, and is %const1 %const2 the %name2.
pause
goto end

ammo2:
echo The %name1 do %puncture puncture damage, do %slice slice damage, do %impact impact damage, and are %const1 %const2 the %name2.
pause
goto end

ammo1:
echo The %name1 does %puncture puncture damage, does %slice slice damage, does %impact impact damage, and is %const1 %const2 the %name2.
pause
goto end

bow:
echo The %name1 is %balance balanced and is %power suited to gaining extra attack power from your strength than the %name2.
pause
goto end

end:
