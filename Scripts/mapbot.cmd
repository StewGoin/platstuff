# Is there a more recent version?

# mapper bot script v1.0 by Conny Wallström

var list |

move_unlinked:
    # check current room for unlinked exits

    if $northid = 0 then
    {
        var direction north
        var reversedir south
        goto move_dir
    }

    if $northeastid = 0 then
    {
        var direction northeast
        var reversedir southwest
        goto move_dir
    }

    if $eastid = 0 then
    {
        var direction east
        var reversedir west
        goto move_dir
    }
    
    if $southeastid = 0 then
    {
        var direction southeast
        var reversedir northwest
        goto move_dir
    }

    if $southid = 0 then
    {
        var direction south
        var reversedir north
        goto move_dir
    }

    if $southwestid = 0 then
    {
        var direction southwest
        var reversedir northeast
        goto move_dir
    }

    if $westid = 0 then
    {
        var direction west
        var reversedir east
        goto move_dir
    }

    if $northwestid = 0 then
    {
        var direction northwest
        var reversedir southeast
        goto move_dir
    }

    if $upid = 0 then
    {
        var direction up
        var reversedir down
        goto move_dir
    }

    if $downid = 0 then
    {
        var direction down
        var reversedir up
        goto move_dir
    }

    goto move_nextinlist

move_dir:
    # move in %direction

    put %direction
    waitfor Obvious
    goto move_reverse_check

move_reverse_check:
    # check if reverse direction exist

    if "%reversedir" = "north" and $north = 1 then goto move_reverse
    if "%reversedir" = "northeast" and $northeast = 1 then goto move_reverse
    if "%reversedir" = "east" and $east = 1 then goto move_reverse
    if "%reversedir" = "southeast" and $southeast = 1 then goto move_reverse
    if "%reversedir" = "south" and $south = 1 then goto move_reverse
    if "%reversedir" = "southwest" and $southwest = 1 then goto move_reverse
    if "%reversedir" = "west" and $west = 1 then goto move_reverse
    if "%reversedir" = "northwest" and $northwest = 1 then goto move_reverse
    if "%reversedir" = "up" and $up = 1 then goto move_reverse
    if "%reversedir" = "down" and $down = 1 then goto move_reverse

    var reversedir none
    gosub move_addtolist_check
    goto move_unlinked

move_reverse:
    # move in reverse direction

    gosub move_addtolist_check
    
    put %reversedir
    waitfor Obvious
    goto move_unlinked

move_nextinlist:
    # extract next room from list
    
    if matchre("%list", "\|(\d+)(\|.*)") then
    {
        var list $2
        put #mapper walk $1
        waitfor Encumbrance
        goto move_unlinked
    }
    echo DONE MAPPING!
    exit

# SUBS ----

move_addtolist_check:
    # check if room we moved to needs to be added to list
    
    if $northid = 0 and "%reversedir" <> "north" then goto move_addtolist
    if $northeastid = 0 and "%reversedir" <> "northeast" then goto move_addtolist
    if $eastid = 0 and "%reversedir" <> "east" then goto move_addtolist
    if $southeastid = 0 and "%reversedir" <> "southeast" then goto move_addtolist
    if $southid = 0 and "%reversedir" <> "south" then goto move_addtolist
    if $southwestid = 0 and "%reversedir" <> "southwest" then goto move_addtolist
    if $westid = 0 and "%reversedir" <> "west" then goto move_addtolist
    if $northwestid = 0 and "%reversedir" <> "northwest" then goto move_addtolist
    if $upid = 0 and "%reversedir" <> "up" then goto move_addtolist
    if $downid = 0 and "%reversedir" <> "down" then goto move_addtolist

    if contains("%list", "|$roomid|") then
    {
        # this room exist in list but was fixed from reverse movement
        eval list replace("%list", "|$roomid|", "")
    }
    return

move_addtolist:
    # add room first in list
    
    if contains("%list", "|$roomid|") then return
    var list |$roomid%list
    return
