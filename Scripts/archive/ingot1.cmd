## Created by drtyprior
## debuglevel 10

ROD:
        put get rod
        pause
        goto MIX

MIX:
        pause
        put mix cruc with rod   
        match SHOVEL As you complete working the fire dies down and needs more fuel
        match BELLOWS As you finish the fire flickers and is unable to consume its fuel
        match CRUCIBLE Upon finishing you observe clumps of molten metal
        matchre END You can only mix|What were you referring to
        matchre MIX Roundtime
        matchre MIX ^\.\.\.wait|^Sorry
        matchwait

SHOVEL:
        put stow rod
        pause
        put get shovel
        pause
        put push fuel with shovel
        pause
        put stow shovel
        pause
        put get rod
        goto MIX

BELLOWS:
        put stow rod
        pause
        put get bell
        pause
        put push bell
        pause
        put stow bell
        pause
        put get rod
        goto MIX 

CRUCIBLE:
        put turn the crucible
        pause
        goto MIX

END:
        put #echo Yellow *** INGOT IS FINISHED! ***
        put #script abort