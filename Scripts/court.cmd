#  validate and clean

## Raven's Court

if $raventime < $gametime then goto start
else goto LEAVE.COURT

start:
	# Only do this if it's been more than one hour since the last run
	evalmath inttime $gametime + 3660
	put #var raventime %inttime

	# Bard stuff
#	put stop sing
#	put .enc harm 35 quiet on
#   pause 1

   if $roomid != 530 then gosub go_room 530
   gosub STUDY raven
   gosub MOVE e
   gosub MOVE climb step
   gosub STUDY mermaid
   gosub MOVE climb step
   gosub MOVE w
#
   gosub MOVE ne
   gosub MOVE go door
   gosub MOVE nw
   pause
   put knock knocker
   pause
   gosub MOVE n
   gosub MOVE n
   gosub MOVE go adder door
   gosub STUDY painting
   gosub MOVE go door
   gosub MOVE s
   gosub MOVE s
   gosub MOVE go door
   gosub MOVE se
   gosub MOVE go doors
   gosub MOVE sw
#
   gosub MOVE n
   gosub MOVE climb step
   gosub MOVE climb stair
   gosub MOVE s
   gosub STUDY sculpture
   gosub STUDY painting
   gosub STUDY carving
   gosub STUDY statue
   gosub STUDY second painting
   gosub MOVE w
   gosub STUDY painting
   gosub STUDY triptych
   gosub STUDY statue
   gosub STUDY figurine
   gosub STUDY second painting
   gosub MOVE s
   gosub STUDY cylinder
   gosub STUDY sculpture
   gosub STUDY statue
   gosub STUDY painting
   gosub STUDY second painting
   gosub MOVE s
   gosub STUDY sphere
   gosub STUDY panel
   gosub STUDY painting
   gosub STUDY canvas
   gosub STUDY statue
   gosub MOVE e
   gosub STUDY painting
   gosub STUDY diorama
   gosub STUDY figure
   gosub STUDY statue
   gosub STUDY second painting
LEAVE.COURT:
   pause .2
   pause .2
   gosub go_room 530
   goto DONE

STUDY:
   var Study $0
STUDY2:
   pause .2
   if $Scholarship.LearningRate > 30 then goto LEAVE.COURT
   matchre STUDY2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Roundtime
   put study %Study
   matchwait

DONE:
	 put #parse Script Done
   exit

include includes.cmd
