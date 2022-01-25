# CLean, rename, etc...

#######################################
###        Aveda's  Amazing         ###
###        Ratha Recall Run         ###
###     Last updated 6/01/2008      ###
### http://dr.aveda.googlepages.com ###
###                                 ###
###     Sewer-moving mechanic       ###
###     by Kraelyst the Hand        ###
###                                 ###
###      Begin in the center of     ###
###        Truffenyi's Green        ###
###     To operate, just type:      ###
###              .rrr               ###
###                                 ###
#######################################

start:
pause
move s
move w
move w
move nw
move ne
move ne
move ne
move n
move w
move nw
move ne
move e
put go building
move e

#setvariable recpoint 1recall
#goto recallit1
echo
Echo Blast you Yaziyi!
Echo Why'd you have to go?!?
echo

1recall:
pause
move w
move out
move w
move sw
move se
move e
move s
move sw
move sw
move sw
move go structure
setvariable recpoint 2recall
goto recallit1

2recall:
pause
move out
move ne
move go grat
move go crev

039:
save 039
match 040 tang of the salt sea
match retreat You are engaged 
put e
matchwait

040:
save 040
match 041 something silent brushing past
match retreat You are engaged 
put se
matchwait

041:
save 041
match 042 the reek of mold
match retreat You are engaged 
put down
matchwait

042:
save 042
match 043 odd whiff of incense
match retreat You are engaged 
put s
matchwait

043:
save 043
match 044 [The Sewers, Beneath the Drain]
match retreat You are engaged 
put go open
matchwait

044:
pause
move go drain
move ne
move w
move w
move w
move w
move sw
move w
move go shop
setvariable recpoint 3recall
goto recallit1

3recall:
pause
move go alcove
setvariable recpoint 4recall
goto recallit1

4recall:
pause
move out
move out
setvariable recpoint 5recall
goto recallit1

5recall:
pause
move w
move nw
move n
move w
move w
move ne
move nw
move nw
move sw
move s
move go shop
setvariable recpoint 6recall
goto recallit1

6recall:
pause
move out
move s
move go arch
move se
move s
move sw
move s
setvariable recpoint 7recall
goto recallit1

7recall:
pause
move sw
move s
move sw
move s
move ne
move e
move se
move ne
move e
move se
move e
move ne
move e
move e
move e
move se
move e
move se
move e
move e
move e
move e
move e
move se
move e
setvariable recpoint 8recall
goto recallit1

8recall:
pause
move w
move nw
move w
move n
move nw
move nw
move nw
move n
move nw
move nw
move w
move sw
move go drain 
move go open 

007:
save 007
match 008 the touch of a feathery
match retreat You are engaged 
put down
matchwait

008:
save 008
match 009 pungent, spicy aroma
match retreat You are engaged 
put ne
matchwait

009:
save 009
match 010 the feel of soft, yielding mud
match retreat You are engaged 
put se
matchwait

010:
save 010
match 011 an odd whiff of incense
match retreat You are engaged 
put e
matchwait

011:
save 011
match 012 The Sewers, Beneath the Drain]
match retreat You are engaged 
put go passage
matchwait

012:
pause
move go grat
move e
move ne
move ne
move go shop
setvariable recpoint 9recall
goto recallit1

9recall:
pause
move out
move nw
move n
setvariable recpoint 10recall
goto recallit1

10recall:
pause
put retreat
put retreat
move s
move s
move s
move w
move w
move w
move w
move nw
setvariable recpoint 11recall
goto recallit1

11recall:
pause
put retreat
put retreat
move w
move w
move w
move sw
setvariable recpoint 12recall
goto recallit1

12recall:
pause
put retreat
put retreat
move nw
move w
move n
move ne
move n
setvariable recpoint 13recall
goto recallit1

13recall:
pause
put retreat
put retreat
move s
move sw
move s
move e
move se
move sw
move w
move sw
move sw
move s
move s
move se
setvariable recpoint 14recall
goto recallit1

14recall:
pause
put retreat
put retreat
move s
move sw
move s
move s
move sw
move s
move s
move s
move ne
move e
move ne
move ne
setvariable recpoint 15recall
goto recallit1

15recall:
pause
put retreat
put retreat
move e
move e
move ne
move e
move ne
move e
move e
move e
move ne
move e
move se
move e
move e
move e
move e
move e
move e
move n
move go shop
setvariable recpoint 16recall
goto recallit1

16recall:
pause
move out
move s
move w
move w
move w
move w
move w
move n
move n
move n
move nw
move nw
move n
setvariable recpoint 17recall
goto recallit1

17recall:
pause
put retreat
put retreat
move nw
move sw
move w
move go grat 
move go passage 

013:
save 013
match 014 the slip of a loose brick
match retreat You are engaged 
put nw
matchwait

014:
save 014
match 015 the touch of a drop of water
match retreat You are engaged 
put sw
matchwait

015:
save 015
match 016 the touch of a feathery
match retreat You are engaged 
put w
matchwait

016:
save 016
match 017 odd whiff of incense
match retreat You are engaged 
put up
matchwait

017:
save 017
match 018 the chill of a clammy breeze
match retreat You are engaged 
put n
matchwait

018:
save 018
match 019 something silent brushing past
match retreat You are engaged 
put up
matchwait

019:
save 019
match 020 tang of the salt sea
match retreat You are engaged 
put nw
matchwait

020:
save 020
match 021 the smell of fish, fresh
match retreat You are engaged 
put w
matchwait

021:
save 021
match 022 [The Sewers, Beneath the Grating]
match retreat You are engaged 
put go crev
matchwait

022:
pause
move go grat
move sw
move se
move e
move e
move n
goto end

recallit1:
match recallit1 ...wait
match percit1 mind lock
match recallit2 Overall state of
put skill SCH
matchwait

recallit2:
match recallit2 Roundtime: 3 seconds.
match percit1 Roundtime:
match recallit2 ...wait
put recall history
matchwait

percit1:
match percit1 ...wait
match %recpoint mind lock
match percit2 Overall state of
put skill PP
matchwait

percit2:
pause
put perceive
waitfor Roundtime:
pause
goto %recpoint

retreat:
match retreat You retreat back to pole range.
match retreat still stunned
match %s You retreat from combat.
put retreat
matchwait

end:
put skill PP
put skill SCH


