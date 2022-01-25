# Genie-ize and consider making it available via Base

################################################################################
################################################################################

#################################TRAVEL SCRIPTS#################################

################################################################################
################################################################################

TRAVEL:

   setvariable STARTINGLOCATION none
   counter set 0

    IF_1 var destination %1
    IF_1 eval destination toupper(%destination)

map_check:
	if $zoneid = 1 then
  {
    gosub go_room 532
    goto CROSSINGLOCATION
  }
	if $zoneid = 30 then
  {
    gosub go_room 331
    goto RIVERHAVENLOCATION
  }
	if $zoneid = 67 then
  {
    gosub go_room 455
    goto SHARDLOCATION
  }
	if $zoneid = 99 then
  {
    gosub go_room 115
    goto AESRYLOCATION
  }
	if $zoneid = 107 then
  {
    gosub go_room 273
    goto MERKRESHLOCATION
  }
	if $zoneid = 90 then
  {
    gosub go_room 468
    goto RATHALOCATION
  }
	if $zoneid = 40 then
  {
    gosub go_room 254
    goto ELBAINSLOCATION
  }
	if $zoneid = 47 then
  {
    gosub go_room 97
    goto MUSPARILOCATION
  }
	if $zoneid = 116 then
  {
    gosub go_room 188
    goto HIBLOCATION
  }

   CROSSINGLOCATION:

      setvariable STARTINGLOCATION CROSSING
      counter set 1
      goto SELECTLOCATION

   CROSSINGLOCATIONADJUST:

      move go door
      goto TRAVEL

   AESRYLOCATION:

      setvariable STARTINGLOCATION AESRY
      counter set 2
      goto SELECTLOCATION

   AESRYLOCATIONADJUST:

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      goto TRAVEL

   SHARDLOCATION:

      setvariable STARTINGLOCATION SHARD
      counter set 3
      goto SELECTLOCATION

   SHARDLOCATIONADJUST:

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      goto TRAVEL

   MERKRESHLOCATION:

      setvariable STARTINGLOCATION MER'KRESH
      counter set 4
      goto SELECTLOCATION

   MERKRESHLOCATIONADJUST:

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      goto TRAVEL

   RIVERHAVENLOCATION:

      setvariable STARTINGLOCATION RIVERHAVEN
      counter set 5
      goto SELECTLOCATION

   RIVERHAVENLOCATIONADJUST:

      move go gate
      move se
      move climb stair
      move go door
      goto TRAVEL

   RATHALOCATION:

      setvariable STARTINGLOCATION RATHA
      counter set 6
      goto SELECTLOCATION

   RATHALOCATIONADJUST:

      move go door
      move e
      goto TRAVEL

   ELBAINSLOCATION:

      setvariable STARTINGLOCATION ELBAIN'S
      counter set 7
      goto SELECTLOCATION

   ELBAINSLOCATIONADJUST:

      move go tree
      move s
      move s
      goto TRAVEL

   MUSPARILOCATION:

      setvariable STARTINGLOCATION MUSPAR'I
      counter set 8
      goto SELECTLOCATION

   MUSPARILOCATIONADJUST:

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      goto TRAVEL

   HIBLOCATION:

      setvariable STARTINGLOCATION HIBARNHVIDAR
      counter set 9
      goto SELECTLOCATION

   HIBLOCATIONADJUST:

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      goto TRAVEL

   SELECTLOCATION:

      pause
      ECHO ######################################################################
      ECHO ################You are currently in %STARTINGLOCATION###############
      ECHO ######################################################################

      ECHO ############################################################
      ECHO Please select your destination from the following:
      ECHO 1.CROSSING
      ECHO 2.AESRY
      ECHO 3.SHARD
      ECHO 4.MERKRESH
      ECHO 5.RIVERHAVEN
      ECHO 6.RATHA
      ECHO 7.ELBAINS
      ECHO 8.MUSPARI
      ECHO 9.HIBARN
      ECHO Type out the location without the number in CAPS! (ie HIBARN)
      ECHO #############################################################

      Match %cCROSSING CROSSING
      Match %cAESRY AESRY
      Match %cSHARD SHARD
      Match %cMERKRESH MERKRESH
      Match %cRIVERHAVEN RIVERHAVEN
      Match %cRATHA RATHA
      Match %cELBAINS ELBAINS
      Match %cMUSPARI MUSPARI
      Match %cHIBARN HIBARN
      IF_1 put echo %destination
      Matchwait     

   1CROSSING:

      ECHO #####################
      ECHO #Already in CROSSING#
      ECHO #####################
      exit

   1AESRY:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   1SHARD:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   1MERKRESH:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   1RIVERHAVEN:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   1RATHA:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   1ELBAINS:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   1MUSPARI:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   1HIBARN:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2CROSSING:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2AESRY:

      ECHO #####################
      ECHO ###Already in AESRY##
      ECHO #####################
      exit

   2SHARD:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   2MERKRESH:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   2RIVERHAVEN:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2RATHA:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2ELBAINS:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2MUSPARI:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   2HIBARN:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   3CROSSING:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
     exit

   3AESRY:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   3SHARD:

      ECHO #####################
      ECHO ###Already in SHARD##
      ECHO #####################
      exit

   3MERKRESH:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   3RIVERHAVEN:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
     exit

   3RATHA:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   3ELBAINS:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   3MUSPARI:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   3HIBARN:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4CROSSING:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4AESRY:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4SHARD:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4MERKRESH:

      ECHO #######################
      ECHO ##Already in MERKRESH##
      ECHO #######################
      exit

   4RIVERHAVEN:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   4RATHA:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4ELBAINS:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4MUSPARI:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   4HIBARN:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5CROSSING:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5AESRY:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5SHARD:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5MERKRESH:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   5RIVERHAVEN:

      ECHO ###########################
      ECHO ###Already in RIVERHAVEN###
      ECHO ###########################
      exit

   5RATHA:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   5ELBAINS:

      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5MUSPARI:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   5HIBARN:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6CROSSING:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6AESRY:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6SHARD:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6MERKRESH:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   6RIVERHAVEN:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6RATHA:

      ECHO #####################
      ECHO ###Already in RATHA##
      ECHO #####################
      exit

   6ELBAINS:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   6MUSPARI:

      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   6HIBARN:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7CROSSING:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7AESRY:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7SHARD:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7MERKRESH:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   7RIVERHAVEN:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7RATHA:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   7ELBAINS:

      ECHO ########################
      ECHO ###Already in ELBAINS###
      ECHO ########################
      exit

   7MUSPARI:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   7HIBARN:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8CROSSING:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8AESRY:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8SHARD:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8MERKRESH:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   8RIVERHAVEN:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8RATHA:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8ELBAINS:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   8MUSPARI:

      ECHO ########################
      ECHO ###Already in MUSPARI###
      ECHO ########################
      exit

   8HIBARN:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   9CROSSING:

      move go portal
      put #parse Done Portalhax
      pause
      exit

   9AESRY:

      move go portal

      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9SHARD:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9MERKRESH:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      put #parse Done Portalhax
      pause
      exit

   9RIVERHAVEN:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9RATHA:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9ELBAINS:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9MUSPARI:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      put #parse Done Portalhax
      pause
      exit

   9HIBARN:

      ECHO ####################
      ECHO ###Already in HIB###
      ECHO ####################
      exit

##################################################################################

      ECHO #########################################################
      ECHO Please select your destination from the following:
      ECHO CROSSING
      ECHO AESRY
      ECHO SHARD
      ECHO MERKRESH
      ECHO RIVERHAVEN
      ECHO RATHA
      ECHO ELBAINS
      ECHO MUSPARI
      ECHO HIBARN
      ECHO Simply say outloud where you wish to go (ie say SHARD) and 
      ECHO capitalize the location!
      ECHO ##########################################################

      ECHO #####################
      ECHO ###Already in ###
      ECHO #####################
      exit

#(crossing arrival)

      move go door
      move go portal

#(crossing departure)
#(aesry arrival)

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

#(aesry departure)
#(shard arrival)

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

#(shard departure)
#(merkeresh arrival)

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

#(merkeresh departure)
#(riverhaven arrival)

      move go gate
      move se
      move climb stair
      move go door
      move go portal

#(riverhaven departure)
#(ratha arrival)

      move go door
      move e
      move go portal

#(ratha departure)
#(elbains arrival)

      move go tree
      move s
      move s
      move go portal

#(ebains departure)
#(muspari arrival)

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

#(muspari departure)
#(hibarn arrival)

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

#(hibarn departure)
#(crossing arrival)

      exit
################################################################################
################################################################################

include includes.cmd
