put #var corn_incidentals pass|deed|limb|stack|ear|bead|pile|rattle|bracelet
put #echo >Log Orange Looting Cornmaze!
action put #echo >Log Red Search Failed when I could not find what you were referring to\.
action put #echo >Log LightBlue $1 found when ^You manage to find (.*)

goto start
# .rep "-loot treasure;-stow gem;-get coin;-attack"

## Movement ################################
MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Obvious
   send %Dir
   matchwait

go_room:
	pause 0.2
	match good_move YOU HAVE ARRIVED
	match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return
good_MOVE_2:
    PAUSE 0.2
    MATCH ACTION YOU HAVE ARRIVED
    MATCH good_MOVE_2 MOVE FAILED
    PUT #goto $1 $2
    MATCHWAIT
    ACTION:
    return

RETURN:
   return

stowcheck:
pause 0.5
#put stow my pass
put put my $righthandnoun in my bright.pouch;put my $lefthandnoun in my bright.pouch
pause
return
#if "$righthand" != "Empty" then put #echo >Log $righthand
if matchre("$righthand", "$cornkeepers") then
{
    #put #echo >Log $righthand
    put stow right
}
else put empty right
#if "$lefthand" != "Empty" then put #echo >Log $lefthand
if matchre("$lefthand", "$cornkeepers") then 
{
    #put #echo >Log $lefthand
    put stow left
}
else put empty left
return

start:
put stow left;stow right
gosub go_room 5
put search stones
gosub stowcheck
gosub go_room 16
put search rake
gosub stowcheck
gosub go_room 17
put search hay
gosub stowcheck
gosub go_room 22
put search pail
gosub stowcheck
gosub go_room 26
put search fencepost
gosub stowcheck
gosub go_room 30
put search burrow
gosub stowcheck
gosub go_room 15
put search wagon
gosub stowcheck
gosub go_room 38
put search statue
gosub stowcheck
gosub go_room 42
put search hut
gosub stowcheck
gosub go_room 47
put search straw
gosub stowcheck
gosub go_room 103
put search statue
gosub stowcheck
gosub go_room 104
put search spiderweb
gosub stowcheck
gosub go_room 111
put search rake
gosub stowcheck
gosub go_room 115
put search stones
gosub stowcheck
gosub go_room 120
put search hay
gosub stowcheck
gosub go_room 125
put search boulder
gosub stowcheck
gosub go_room 147
put search wheelbarrow
gosub stowcheck
gosub go_room 141
put search boulder
gosub stowcheck
gosub go_room 133
put search wheelbarrow
gosub stowcheck
gosub go_room 137
put search boulder
gosub stowcheck
gosub go_room 52
put search wood
gosub stowcheck
gosub go_room 59
put search basket
gosub stowcheck
gosub go_room 61
put search stones
gosub stowcheck
gosub go_room 79
put search hay
gosub stowcheck
gosub go_room 99
put search rake
gosub stowcheck
gosub go_room 69
put search boulder
gosub stowcheck
gosub go_room 86
put search wheelbarrow
gosub stowcheck
gosub go_room 93
put search boulder
gosub stowcheck
gosub go_room 96
put search spiderweb
gosub stowcheck
gosub go_room 231
put search spiderweb
gosub stowcheck
gosub go_room 282
put search basket
gosub stowcheck
gosub go_room 260
put search wood
gosub stowcheck
gosub go_room 251
put search rake
gosub stowcheck
gosub go_room 262
put search hay
gosub stowcheck
gosub go_room 271
put search stones
gosub stowcheck
gosub go_room 273
put search boulder
gosub stowcheck
gosub go_room 234
put search boulder
gosub stowcheck
gosub go_room 239
put search basket
gosub stowcheck
gosub go_room 244
put search wheelbarrow
gosub stowcheck
gosub go_room 293
put search stones
gosub stowcheck
gosub go_room 297
put search boulder
gosub stowcheck
gosub go_room 349
put search rake
gosub stowcheck
gosub go_room 340
put search hay
gosub stowcheck
gosub go_room 320
put search spiderweb
gosub stowcheck
gosub go_room 324
put search basket
gosub stowcheck
gosub go_room 336
put search rake
gosub stowcheck
gosub go_room 311
put search hay
gosub stowcheck
gosub go_room 317
put search stones
gosub stowcheck
gosub go_room 333
put search spiderweb
gosub stowcheck
gosub go_room 327
put search wood
gosub stowcheck
gosub go_room 386
put search wheelbarrow
gosub stowcheck
gosub go_room 289
put search boulder
gosub stowcheck
gosub move west
gosub go_room 359
put search boulder
gosub stowcheck
gosub go_room 366
put search spiderweb
gosub stowcheck
gosub go_room 371
put search basket
gosub stowcheck
gosub go_room 377
put search wood
gosub stowcheck
gosub go_room 382
put search rake
gosub stowcheck
gosub go_room 388
put search hay
gosub stowcheck
gosub go_room 394
put search stones
gosub stowcheck
gosub go_room 211
put search stones
gosub stowcheck
gosub go_room 208
put search hay
gosub stowcheck
gosub go_room 201
put search rake
gosub stowcheck
gosub go_room 195
put search wood
gosub stowcheck
gosub go_room 222
put search basket
gosub stowcheck
gosub go_room 218
put search spiderweb
gosub stowcheck
gosub go_room 186
put search boulder
gosub stowcheck
gosub go_room 178
put search wheelbarrow
gosub stowcheck
gosub go_room 174
put search boulder
gosub stowcheck
gosub go_room 169
put search stones
gosub stowcheck
gosub go_room 163
put search hay
gosub stowcheck
gosub go_room 158
put search rake
gosub stowcheck
gosub go_room 152
put search wood
gosub stowcheck
gosub go_room 402
put search basket
gosub stowcheck
gosub go_room 398
put search wood
gosub stowcheck
gosub go_room 413
put search hay
gosub stowcheck
gosub go_room 425
put search stones
gosub stowcheck



