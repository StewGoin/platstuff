#Climbing in Shard
#debuglevel 5
counter set 0
ECHO
ECHO *** Start ANYWHERE IN SHARD
ECHO
put get adze
put get nightstick
pause .2
if_1 then goto %1

Start:
counter add 1
if $Athletics.LearningRate >= 25 then goto DONE
ECHO
ECHO *** STARTING CLIMBING SESSION %c ***
ECHO

SHARD.TO.BRANCH:
gosub automove North gate
pause 0.5
gosub automove waterfall
pause 0.5

UNDER.TO.PRACTICE:
gosub automove 37
pause 0.5
gosub automove 44
pause 0.5
put app branch
pause 2
pause
BRANCH.CONTINUE:
pause .1
gosub automove undergondola
pause .1
FORAGING:
pause .5
put stow adze
put collect rock
pause 2
pause
put collect rock
pause 2
pause
put kick pile
put kick pile
pause .5
pause .1
put collect rock
pause 2
pause
put kick pile
pause .5
put get adze
goto CLIMBING.CHECK

CLIMBING.CHECK:
if $Athletics.LearningRate <= 25 then goto UNDER.TO.PRACTICE
pause 0.2
gosub automove 1
pause 0.5
pause 0.5
gosub automove shard
pause .5
goto Start

##################################################

RETURN:
RETURN

automove:
var toroom $1
automovecont:
matchre automove.return YOU HAVE ARRIVED|SHOP CLOSED
match automovecont YOU HAVE FAILED
put #goto %toroom
matchwait

automove.return:
pause 0.1
pause 0.1
RETURN

DONE:
pause
put #echo >Log Lime *** %c Climbing loops to $Athletics.LearningRate / 34 ***
put stow adze
put stow nightstick
pause .1
put exp
put #parse CLIMBING DONE
put #parse DONE CLIMBING
put #parse CLIMBING LOCKED
EXIT
