action send wave wand at $1 when You also see.+\b(scholar|mage|gentleman|scoundrel|warrior|farmer|maiden|hunter|healer)\b(?! \(immobile\))
action send wave wand at $1 when ^A wall panel slides open to usher.+\b(scholar|mage|gentleman|scoundrel|warrior|farmer|maiden|hunter|healer)\b into the maze
action send pull rope when You also see.+rope
action send go white door when You also see.+white door
action send get key when golden key
action send shake wand when It's pitch dark and you can't see a thing\!
action send wave wand at $1 when (\w+) begins to move around again\.$
action instant send stand when $standing = 0

goto top

put get my pass
pause 0.1
#put break my pass
#pause 0.1
#put put my other pass in my back
#pause 0.5
put redeem pass
pause 0.5
put redeem pass

waitfor You have just redeemed

pause 0.5
put get my multi
pause 0.5
put redeem multi
pause 0.5
put redeem multi
put ask spieler about access
waitfor Almost faster than you can blink

#put get my shield
#put wear my shield
#waitfor You slide your left
pause

put get my wand
pause 0.5
put go door
put go door

top:
waitforre You have earned \d+ Droughtman's indicia and a maze runner's package

put open my package
waitfor You open your runner's package.

coin:
  matchre coin \.\.\wait|^Sorry,|You pick
  match look What were you referring to?
  put get coin
  matchwait

look:
put look in my package
exit
