var forageitem %1
var foragecount 0
var foragemax 16

FORAGE:

FORAGE_1:
  match FORAGE_2 Roundtime
  put collect %forageitem
  matchwait 2
  goto FORAGE_1

FORAGE_2:
  if %foragecount = %foragemax then goto DONE
  gosub get %forageitem
  gosub put my %forageitem in my mortar
  math foragecount add 1
  goto FORAGE_2

DONE:
  put #parse Done Forage
  pause 0.5
  exit

include includes.cmd
