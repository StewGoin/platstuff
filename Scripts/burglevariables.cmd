## Reveler's BurgleVariables Script
## v.2.0 
## 05/30/2020
## Discord Reveler#6969

## v. 2.0 updates:
## Added option to hide before searches
## Added variable to drop burgled items if not in your donotpawnthis variable

## THIS IS AN INCLUDED SCRIPT IN THE BURGLE SCRIPT AND MUST BE COMPLETED BEFORE RUNNING .BURGLE.CMD

#debug 10

#Preliminary variables - don't touch
var skip NULL
var donotpawnthis NULL
var trashit NO
### Edit below here


## SET YOUR CHARACTER'S NAMES BELOW, IF NOTHING USE NULL
## MAKE SURE TO UPDATE EACH CHARACTERS VARIABLES INDIVIDUALLY BELOW
var CHARACTER1 Ryken
var CHARACTER2 XXXXXX
var CHARACTER3 XXXXXX
var CHARACTER4 XXXXXX
var CHARACTER5 XXXXXX
var CHARACTER6 XXXXXX
var CHARACTER7 XXXXXX
var CHARACTER8 XXXXXX


## SET ALL YOUR CUSTOM VARIABLES PER EACH CHARACTER IN THE BLOCKS BELOW THIS!
##### CHARACTER 1 VARIABLES
if ("$charactername" = "%CHARACTER1") then 
{
# do you use the temporal eddy for storage of items?  If yes, list the items in an array, with LOOT for burgle loot, ROPE for burgle rope entry, RING for lockpick ring and LOCKPICK for loose lockpicks.  NULL if you don't use the eddy
#var eddy LOCKPICK|ROPE|LOOT
var eddy NULL
# where do you want to store your stolen items?  If storing in your eddy, you must use noun "portal"
var pack sash
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
# NOTE: This version contains an if/else statement if you want to train different skills depending on learning rates
#if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
if ($Athletics.LearningRate >= 16) then var method RING
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
if ("%method" = "RING") then var worn YES
else var worn NO
# Travel location should be the city and the roomid.  Pick a room where you *know* there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
#var hideme YES
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER2") then 
{
# where do you want to store your stolen items?
var pack sadd
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method RING
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype hemp rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER3") then 
{
# where do you want to store your stolen items?
var pack carryall
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method RING
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype climbing rope
# Toggle for worn lockpick ring/rope
var worn YES
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}
if ("$charactername" = "%CHARACTER4") then 
{
# where do you want to store your stolen items?
var pack backpack
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method RING
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER5") then 
{
# where do you want to store your stolen items?
var pack carryall
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER6") then 
{
# where do you want to store your stolen items?
var pack bag
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER7") then 
{
# where do you want to store your stolen items?
var pack bag
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER8") then 
{
# where do you want to store your stolen items?
var pack bag
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER9") then 
{
# where do you want to store your stolen items?
var pack backpack
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method RING
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
if ("%method" = "RING") then var worn YES
else var worn NO
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}

if ("$charactername" = "%CHARACTER10") then 
{
# where do you want to store your stolen items?
var pack leather bag
# method can be RING, LOCKPICK, or ROPE; RING (uses lockpick stacker) and LOCKPICK (uses spare lockpicks) teach locks, ROPE teaches athletics. VARIABLE MUST BE IN ALL CAPS
if ($Athletics.LearningRate >= $Locksmithing.LearningRate) then var method LOCKPICK
else var method ROPE
# ringtype is the type of lockpick ring you have.  It can be any of the following: lockpick ring|lockpick case|lockpick ankle-cuff|golden key
var ringtype lockpick ring
# Use your adjective-noun for your rope
# DANCING ROPES DO NOT WORK
var ropetype heavy rope
# Toggle for worn lockpick ring/rope
var worn YES
# Travel location should be the city and the roomid.  Pick a room where you know there will not be a guard, or leave NULL
var travel NULL
# maximum times to try to search surfaces
var maxgrabs 3
# do you want to hide before you search? Will ALWAYS be hidden for first search. ON will attempt to hide before any additional search. WARNING - MAY BE MORE RISKY BECAUSE OF ROUND TIME AND WILL REDUCE NUMBER OF POTENTIAL ROOMS YOU WILL HAVE TIME TO SEARCH
var hideme YES
# pawn YES will try to pawn your stolen goods NOTE - PUT NO IF PAWNING THROUGH UBERCOMBAT
var pawn NO
# Rooms you do not want to search.  Choose from following: kitchen|bedroom|workroom|sanctum|armory|library
var skip NULL
# put loot you DO NOT wish to sell here if you use pawning within .BURGLE.  The full lootpool variable is in .burgle. Separate with |
var donotpawnthis case|manual|scimitar|opener
# if you want to drop everything EXCEPT the "donotpawnthis" items, put YES here
var trashit NO
}
######### END USER VARIABLES DON'T TOUCH ANYTHING ELSE

put #var BURGLE.EDDY %eddy
put #var BURGLE.PACK %pack
put #var BURGLE.METHOD %method
put #var BURGLE.RINGTYPE %ringtype
put #var BURGLE.ROPETYPE %ropetype
put #var BURGLE.WORN %worn
put #var BURGLE.TRAVEL %travel
put #var BURGLE.MAXGRABS %maxgrabs
put #var BURGLE.PAWN %pawn
put #var BURGLE.KEEP %donotpawnthis
