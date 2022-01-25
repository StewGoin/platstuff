IF_1 goto combat.waiting

put stow left;stow right
pause
put .fight PRIMARY
pause
put .aon
waitfor Armor On
pause
put #class circuit false
put #var GH_CYCLE_HUNT 0

## use this section when trying to keep a specific skill moving
#put #var GH_CIRCUIT $offense_num
#if ($offense_num < $GH_MULTI_NUM) then put #math offense_num + 1
#else put #var offense_num 1
#put #class circuit true
#put gm $offense_num;.hunt

## Generic single circuit section
put #var GH_CIRCUIT $GH_MULTI_NUM
put #class circuit true
put gm 1;.hunt

exit
