# lulz

var orbtype faenella
if_2 goto puzzle
if_1 var orbtype %1
action goto exit when Seek ye the high altar at the center of the temple of the gods

pray:
pause 1  
put kneel
put pray
pause 1
put pray
put pray
pause 1
put say %orbtype
put stand
pause 1
put get %orbtype orb
pause 1
put go arch
pause 1

puzzle:
match plant plant
match sponge sponge
match jug jug
match tinders tinders
match vase vase
match look bubbling pool
match look difficult
put look
matchwait

plant:
pause
match plant ...wait
match plant shimy
match plant loosen
match open swift breeze moves into the room
put open window
matchwait

open:
pause
put go window
goto puzzle  

sponge:
put clean altar
put climb stair
pause 1
put go door
goto puzzle

jug:
put fill font
put climb stair
pause 1
put go door
goto puzzle

tinders:
put light candle
put climb stair
pause 1
put go door
goto puzzle

vase:
put get flower
put go path
goto puzzle

look:
put look

exit:
exit
