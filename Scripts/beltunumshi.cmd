action var loot $1 when vela\s(branch|chip|limb|sapling|shaving|sprig|stick|switch|twig)\!
action var pure "true" when and a replenished khor\'vela

loop:
    var loot ""
    var pure ""
    pause 0.5
    put loot
    pause 0.5
    if ("%loot" <> "" && "%pure" = "true") then put stow khor %loot in my bag
    else if "%loot" <> "" then put stow khor %loot
    put attack
    goto loop