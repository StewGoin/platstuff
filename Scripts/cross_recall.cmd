# Validate this (add as needed) and genie-fy movements then rename per appropriate.

#######################################
###         Aveda's Amazing         ###
###       Crossing Recall Run       ###
###      Last updated 6/01/2008     ###
### http://dr.aveda.googlepages.com ###
###                                 ###
###      Begin in the Crossing      ###
### Bards's Guild, Prop Room        ###
###     To operate, just type:      ###
###              .crr               ###
###                                 ###
#######################################

start:
move go door
pause
save 1recall
goto recallit1

1recall:
pause
move e
move e
move e
save 2recall
goto recallit1

2recall:
pause
move w
move out
save 3recall
goto recallit1

3recall:
pause
move e
move e
move s
save 4recall
goto recallit1

4recall:
pause
move s
move s
save 5recall
goto recallit1

5recall:
pause
move s
move s
move e
move e
move se
move e
move s
move s
save 6recall
goto recallit1

6recall:
pause
move s
save 7recall
goto recallit1

7recall:
pause
move climb stair
move down
move go dock
save 8recall
goto recallit1

8recall:
pause
move n
move climb stair
move up
move n
move n
move n
move e
move e
move n
move n
move n
move ne
save 9recall
goto recallit1

9recall:
pause
move n
move w
move w
move w
move n
move w
move w
move w
move w
move w
move go build
move go portal
move go arch
move go door
goto end

recallit1:
if $Scholarship.LearningRate = 12 then goto percit1
else goto recallit2

recallit2:
match recallit2 Roundtime: 3 seconds.
match percit1 Roundtime:
match recallit2 ...wait
put recall history
matchwait


percit1:
goto %s
if $Power_Perceive.LearningRate = 12 then goto %s
else goto percit2

percit2:
pause
put perceive
waitfor Roundtime:
pause
goto %s

end:
put echo Script Done
