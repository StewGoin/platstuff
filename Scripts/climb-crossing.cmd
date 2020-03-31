##Climbing Script for Crossing (Currently).. Start from anywhere within Crossing. It will end outside Crossing Bank.


##DEBUG 10
ACTION send exit when eval $health < 60

##CROSSING Climbing locations
if $zoneid = 1 then var ROOM.NUMBER 68|170|171|172|252|386|387|387|395|396|396|398|399|768
if $zoneid = 1 then var ROOM.CLIMB bank|wall|wall|wall|tree|embrasure|break|embrasure|embrasure|break|embrasure|embrasure|embrasure|trunk

eval ROOM.COUNT count ("%ROOM.NUMBER", "|")
counter set 0

MAIN:
	if $Athletics.LearningRate > 33 then GOTO END
	if (%c > %ROOM.COUNT) then counter set 0
	
	GoSub MAP_CHECK
##	put #ECHO >Output **** Room - %ROOM.NUMBER(%c) , %ROOM.CLIMB(%c)
	GoSub ROOM_MOVE %ROOM.NUMBER(%c)
	GoSub CLIMB %ROOM.CLIMB(%c)
	counter add 1
	GOTO MAIN

MAP_CHECK:
## CROSSING Map checks
		## zoneid-4 is Outside Crossing West Gate
	if $zoneid = 4 then GoSub ROOM_MOVE 14
		## zoneid-6 is Outside Crossing North Gate
	if $zoneid = 6 then GoSub ROOM_MOVE 23
		## zoneid-7 is Outside Crossing, Northern Trade Road
	if $zoneid = 7 then GoSub ROOM_MOVE 349
		## zoneid-8 is Outside Crossing East Gate
	if $zoneid = 8 then GoSub ROOM_MOVE 43
		## zoneid = 1 is Crossing
	if $zoneid = 1 then GOTO RETURN1
	
## SHARD MAP CHECK (TODO)
	
	GOTO MAP_CHECK

CLIMB:
	send climb $0
	wait 1
	RETURN
		
ROOM_MOVE:
ROOM_MOVE.SUB:
	if $roomid != $0 then {
			matchre RETURN1 YOU HAVE ARRIVED
			matchre RETURN1 Script Finished
		put #goto $0
		matchwait 10
	}
	RETURN
	
END:
	GoSub MAP_CHECK
	wait .5
	GoSub ROOM_MOVE 42
	wait .5
	EXIT

RETURN1:
	wait .5
	RETURN
